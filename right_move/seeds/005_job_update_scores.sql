
create or replace function update_job_metrics(i integer) returns VOID as $$
BEGIN
/* update actual user values! */
delete from api_jobattribute where job_id = i;

insert into api_jobattribute (job_id, subcategory_id, value, created_at, updated_at)
/* Unweighted optional question answers for the user, using decimal scaling*/
with mapped_answers as (
select 
	qm.question_id as question_id,
	c.choice_text as choice_text,
	qm.subcategory_id as subcategory_id,
	c.id as choice_id,
	qm.ordinal_reverse as needs_reverse
from 
	(select * from api_questionmapping where question_type = 'job') qm
inner join 
	api_jobchoice c
using (question_id)
group by 1,2,3,4,5 
having ordinal_reverse is not null
order by question_id 

)

,ord_vals as (
	with answer_counts as (
		select
			subcategory_id,
			question_id,
			count(*) as answer_count
		from
			mapped_answers
		group by 1,2)select
		subcategory_id,
		question_id,
		choice_id,
		case
			when needs_reverse then 
				round(row_number() over(partition by subcategory_id, question_id order by choice_id DESC) / (answer_count * 1.0),2) 
			else
				round(row_number() over(partition by subcategory_id, question_id order by choice_id ASC) / (answer_count * 1.0),2)
		end as ord_val
	from
		mapped_answers
	inner join 
		answer_counts
	using (question_id, subcategory_id)
)
,final_mapped as ( 
select
o.subcategory_id as subcategory_id,
	o.question_id as question_id,
	o.ord_val as ord_val,
	c.choice_text as choice_text
FROM
	ord_vals o
left join 
	(select id as choice_id, choice_text from api_choice) c
using (choice_id)
order BY
subcategory_id, question_id, ord_val
), applied_ords as (select
	j.job_id,
	f.subcategory_id,
	f.ord_val
from
	api_jobanswer j
left join
	final_mapped f
on
	f.choice_text = j.answer
and
	f.question_id = j.question_id),
decimal_question_values_unadjusted as (	
select 
	job_id,
	subcategory_id,
	avg(ord_val) as average_ord_val
from applied_ords	
group by 1, 2
)
,
/* unweighted manual questions */
-- salary
raw_salary as(	
	select
		j.job_id as job_id,
		r.average as average_salary,
		r.minimum as minimum_salary,
		r.standardized_value,
		r.multiplier
	from 
		(select id as job_id, role_id, city, state from api_job where id = i) j
	left join
		(select *, case 
					when city = 'state-default-value' then 1
					else 0 end as default_val 
		from 
			api_rolesalary) r
		ON
			r.state = trim(upper(j.state))
		and	
			r.role_id = j.role_id 
	where
		trim(lower(j.city)) = r.city
	or
		default_val = 1
	order by 
		r.default_val desc
	limit 1
)
,
parsed_salary as (
	select 
		salary as offered_salary
	from
		(select
			salary
		FROM
		api_job
		where id = i) a
	
)
,
adjusted_salary as (
	select
		(coalesce(((offered_salary - minimum_salary) * multiplier),standardized_value) + standardized_value) / 2.0 as adjusted_salary_standardized,
		((coalesce(((offered_salary - minimum_salary) * multiplier),standardized_value)  + standardized_value) / 2.0) / multiplier as adjusted_salary
		
	from
		raw_salary
	left join
		parsed_salary
	on 1=1
	group by 1,2
),
-- urban vs rural, using decimal converted federal census RUCA codes
office_location as (
	select
		j.job_id as job_id,
		z.zip_code as inferred_zip_code,
		z.ruca_standardized as rural_score
	from 
		(select id as job_id, zipcode from api_job where id = i) j
	left join
		api_zipcodedetail z
	on 1=1 
	where 
		(abs(z.zip_code::int - j.zipcode::int)) < 100
	order by 
		(abs(z.zip_code::int - j.zipcode::int)) desc
	limit 1
),
office_size as (
	SELECT
		CASE 
			when num_employees > 1000 THEN 1 
			WHEN num_employees BETWEEN 300 AND 999 THEN 0.75
			WHEN num_employees BETWEEN 150 AND 299 THEN 0.5
			WHEN num_employees BETWEEN 75  AND 149 THEN 0.25
			WHEN num_employees BETWEEN 29  AND 75  THEN 0.15
			WHEN num_employees < 28 THEN 0
		END AS num_employees
	from
		(select
			NULLIF(regexp_replace(answer, '[^0-9\.]','','g'), '')::numeric as num_employees
		 from 
			api_jobanswer
		WHERE
			question_id = i
		AND 
			job_id = i
		LIMIT 1
		) os
),
mentorship as (
	select 
		case 
			when mentors > 1 then 1
			when mentors = 1 then .75
			when mentors < 1 then 0
		end as mentors
	from
		(select
			NULLIF(regexp_replace(answer, '[^0-9\.]','','g'), '')::numeric as mentors
		 from 
			api_jobanswer
		WHERE
			question_id = 7
		AND 
			job_id = i
		LIMIT 1
		) os
),
direct_reports as (
	select 
	case 
			when reports > 5 then 1
			when reports > 1 then .75
			when reports =  1 then .5
			else 0
		end as reports
	from
		(select
			NULLIF(regexp_replace(answer, '[^0-9\.]','','g'), '')::numeric as reports
		 from 
			api_jobanswer
		WHERE
			question_id = 8
		AND 
			job_id = i
		LIMIT 1
		) os
),
PTO as (
	select 
	case 
			when pto > 20 then 1
			when pto > 16 then .85
			when pto > 14 then .75
			when pto = 14 then .5
			when pto > 10 then .3
			when pto >= 7 then .2
			when pto < 7 then 0
		end as pto
	from
		(select
			NULLIF(regexp_replace(answer, '[^0-9\.]','','g'), '')::numeric as pto
		 from 
			api_jobanswer
		WHERE
			question_id = 18
		AND 
			job_id = i
		LIMIT 1
		) os
),
-- for MVP just do zipcode delta. 2nd release we want actual lat/long distances
zip_distance as (
	select
		-- lowest and highest zipcode in contig. usa
		abs(u.zipcode::int - j.zipcode::int)/(99950 - 501) as ord_val
	from
		(select * from api_job where id = i) j
	inner join
		api_userbasicprofile u
	on
		u.user_id = j.user_id
	limit 1
),
--build out the full subcategory suite 
all_subcats as (
	select
		id as subcategory_id,
		0.5 as value
	from
		api_subcategory
	group by 1
),
job_unweighted_vals as (
	select
		a.subcategory_id,
		case
			when a.subcategory_id = i then coalesce(os.num_employees,0.5)
			-- gaining experience
			when a.subcategory_id = 5 then coalesce(zd.ord_val, 0.5)
			when a.subcategory_id = 6 then coalesce(ol.rural_score, 0.5)
			when a.subcategory_id = 9 then coalesce(((coalesce(m.mentors,0.5) * 2)  + d.average_ord_val),1.5) /3.0 
			when a.subcategory_id = 10 then coalesce((coalesce(m.mentors,0.5)  + d.average_ord_val),1) /2.0 
			when a.subcategory_id in (11,12) then coalesce((coalesce(dr.reports,0.5) + d.average_ord_val),1) / 2.0
			when a.subcategory_id = 17 then (coalesce(ass.adjusted_salary_standardized, 0.5))
			when a.subcategory_id = 15 then coalesce(((coalesce(pto.pto,0.5)* 2) + d.average_ord_val),1.5) /3.0
			when a.subcategory_id = 22 then coalesce((coalesce(pto.pto,0.5) + d.average_ord_val),1) /2.0
			else coalesce(coalesce(d.average_ord_val,0.5), a.value)
		end as value
		from
		all_subcats a
	left join
		decimal_question_values_unadjusted d
	on
		d.subcategory_id = a.subcategory_id
	left join
		mentorship m
	on 1=1
	left join
		office_size os
	on 1=1
	left join
		office_location ol
	on 1=1
	left join
		direct_reports dr
	on 1=1 
	left join
		PTO pto
	on 1=1
	left join
		adjusted_salary ass 
	on 1=1
	left join
		zip_distance zd
	on 1=1 
	group by 1,2
)
select 
	i as job_id,
	subcategory_id,
	value,
	NOW(),
	NOW()
	
from job_unweighted_vals;

--- set the job score! 
with 
distance_calc as (
	select 
		s.id as subcategory_id,
		((((10 * s.heuristic_value) + 1.0 + uw.value)) * (abs(u.value - j.value)^ 2))::numeric as sigma
	from 
		api_subcategory s
	inner join
		api_jobattribute j
	on
		j.subcategory_id = s.id
	inner join
		api_job job
	on
		job.id = j.job_id
	inner join	
		api_userattribute u
	on
		job.user_id = u.id
	inner join
		api_userattributeweight uw
	on 
		uw.user_id = job.user_id
	where
		job.id = i
),
final_score as (
	select 
	100 - sqrt(sum(sigma)) as calculated_score
from distance_calc
)
update api_job a set score = round(calculated_score::numeric,2)
from final_score
where a.id = i;

end;
$$ language plpgsql;

