create or replace function update_user_metrics(i integer) returns VOID as $$
BEGIN
delete from api_userattributeweight where user_id = i;

insert into api_userattributeweight (user_id, subcategory_id, value, created_at, updated_at)
/* Unweighted optional question answers for the user, using decimal scaling*/
with mapped_answers as (
select 
	qm.question_id as question_id,
	c.choice_text as choice_text,
	qm.subcategory_id as subcategory_id,
	c.id as choice_id,
	qm.ordinal_reverse as needs_reverse
from 
	(select * from api_questionmapping where question_type = 'user') qm
inner join 
	api_choice c
using (question_id)
group by 1,2,3,4,5 
having ordinal_reverse is not null

),ord_vals as (
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
),final_mapped as ( 
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
	u.user_id,
	f.subcategory_id,
	f.ord_val
from
	api_useranswer u
left join
	final_mapped f
on
	f.choice_text = u.answer
and
	f.question_id = u.question_id),
decimal_question_values_unadjusted as (	
select 
	user_id,
	subcategory_id,
	avg(ord_val) as average_ord_val
from applied_ords	
group by 1, 2
),
/* unweighted manual questions */
-- salary
raw_salary as(	
	select
		u.user_id as user_id,
		r.average as average_salary,
		r.minimum as minimum_salary,
		r.standardized_value,
		r.multiplier
	from 
		(select user_id, role_id, city, state from api_userbasicprofile where user_id = i) u
	left join
		(select *, case 
					when city = 'state-default-value' then 1
					else 0 end as default_val 
		from 
			api_rolesalary) r
		ON
			r.state = trim(upper(u.state))
		and	
			r.role_id = u.role_id 
	where
		trim(lower(u.city)) = r.city
	or
		default_val = 1
	order by 
		r.default_val desc
	limit 1
),
desired_salary as (
	select 
		regexp_replace(answer,'[^0-9]+','','g')::float as desired_salary
	from
		(select answer from api_useranswer
	where 
		user_id = i
	and 
		question_id = 42
	order by created_at desc
	limit 1) a
	
),
adjusted_salary as (
	select
		(coalesce(((desired_salary - minimum_salary) * multiplier),standardized_value) + standardized_value) / 2.0 as adjusted_salary_standardized,
		((coalesce(((desired_salary - minimum_salary) * multiplier),standardized_value)  + standardized_value) / 2.0) / multiplier as adjusted_salary
		
	from
		raw_salary
	left join
		desired_salary
	on 1=1
	group by 1,2
),
-- urban vs rural, using decimal converted federal census RUCA codes
office_location as (
	select
		u.user_id as user_id,
		z.zip_code as inferred_zip_code,
		z.ruca_standardized as rural_score
	from 
		(select user_id, zipcode from api_userbasicprofile where user_id = i) u
	left join
		api_zipcodedetail z
	on 1=1 
	where 
		(abs(z.zip_code::int - u.zipcode::int)) < 100
	order by 
		(abs(z.zip_code::int - u.zipcode::int)) desc
	limit 1
),
-- flex rate 
flex_rate as (
	select 
	((case
		when (extract('year' from NOW()::date)  - extract('year' from u.birthday::date)) > 35 then 1
		when (extract('year' from NOW()::date)  - extract('year' from u.birthday::date)) > 29 then .75
		when (extract('year' from NOW()::date)  - extract('year' from u.birthday::date)) > 25 then .5
		when (extract('year' from NOW()::date)  - extract('year' from u.birthday::date)) > 22 then .25
	else 0 end +
	-- hypothesis: undergrads are most likely to move, then graduates, doctorate & HS stay put 
	case
		when lower(u.education) in ('rocket scientist','doctorate') then .75
		when lower(u.education) = 'graduate' then .25
		when lower(u.education) = 'undergraduate' then .25
		when lower(u.education) = 'high school' then .75
	else 0 end +
	case
		when u.num_dependents > 1 then 1
		when u.num_dependents > 0 then .5
	else 0 end +
	case 
		when u.relationship_status in ('married','involved') then .5
	else 0 end ) /4.0 ) as flex_rate
	from 
		(select 
			* 
		from 
			api_userbasicprofile
		where
		user_id = i ) u
),
/* build out the full subcategory suite */
all_subcats as (
	select
		id as subcategory_id,
		0.5 as value
	from
		api_subcategory
	group by 1
),
user_unweighted_vals as (
	select
		a.subcategory_id,
		
		case
			when a.subcategory_id in (9,15,16) then coalesce(((coalesce(d.average_ord_val,0.5) * 2) + flex_rate),1.5) /3.0 
			when a.subcategory_id = 24 then coalesce((coalesce(d.average_ord_val,0.5) + flex_rate),1.0) / 2.0
			when a.subcategory_id = 17 then coalesce((ass.adjusted_salary_standardized),0.5)
			when a.subcategory_id = 6 then coalesce(((coalesce(ol.rural_score,0.5) * 2 ) + flex_rate),1.5) /3.0
			else coalesce(coalesce(d.average_ord_val,0.5), a.value)
		end as value
	from
		all_subcats a
	left join
		decimal_question_values_unadjusted d
	on
		d.subcategory_id = a.subcategory_id
	left join
		 adjusted_salary ass
	on 1=1
	left join
		flex_rate
	on 1=1
	left join
		office_location ol
	on 1=1
	group by 1,2
),
user_weights as (
	select
		subcategory_id,
		abs(value - 0.5) + 1 as weight
	from
		user_unweighted_vals
)

select 
	i as user_id,
	subcategory_id,
	weight as value,
	NOW(),
	NOW()
	
from user_weights;


/* update actual user values! */
delete from api_userattribute where user_id = i;

insert into api_userattribute (user_id, subcategory_id, value, created_at, updated_at)
/* Unweighted optional question answers for the user, using decimal scaling*/
with mapped_answers as (
select 
	qm.question_id as question_id,
	c.choice_text as choice_text,
	qm.subcategory_id as subcategory_id,
	c.id as choice_id,
	qm.ordinal_reverse as needs_reverse
from 
	(select * from api_questionmapping where question_type = 'user') qm
inner join 
	api_choice c
using (question_id)
group by 1,2,3,4,5 
having ordinal_reverse is not null

),ord_vals as (
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
),final_mapped as ( 
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
	u.user_id,
	f.subcategory_id,
	f.ord_val
from
	api_useranswer u
left join
	final_mapped f
on
	f.choice_text = u.answer
and
	f.question_id = u.question_id),
decimal_question_values_unadjusted as (	
select 
	user_id,
	subcategory_id,
	avg(ord_val) as average_ord_val
from applied_ords	
group by 1, 2
),
/* unweighted manual questions */
-- salary
raw_salary as(	
	select
		u.user_id as user_id,
		r.average as average_salary,
		r.minimum as minimum_salary,
		r.standardized_value,
		r.multiplier
	from 
		(select user_id, role_id, city, state from api_userbasicprofile where user_id = i) u
	left join
		(select *, case 
					when city = 'state-default-value' then 1
					else 0 end as default_val 
		from 
			api_rolesalary) r
		ON
			r.state = trim(upper(u.state))
		and	
			r.role_id = u.role_id 
	where
		trim(lower(u.city)) = r.city
	or
		default_val = 1
	order by 
		r.default_val desc
	limit 1
),
desired_salary as (
	select 
		regexp_replace(answer,'[^0-9]+','','g')::float as desired_salary
	from
		(select answer from api_useranswer
	where 
		user_id = i
	and 
		question_id = 42
	order by created_at desc
	limit 1) a
	
),
adjusted_salary as (
	select
		(coalesce(((desired_salary - minimum_salary) * multiplier),standardized_value) + standardized_value) / 2.0 as adjusted_salary_standardized,
		((coalesce(((desired_salary - minimum_salary) * multiplier),standardized_value)  + standardized_value) / 2.0) / multiplier as adjusted_salary
		
	from
		raw_salary
	left join
		desired_salary
	on 1=1
	group by 1,2
),
-- urban vs rural, using decimal converted federal census RUCA codes
office_location as (
	select
		u.user_id as user_id,
		z.zip_code as inferred_zip_code,
		z.ruca_standardized as rural_score
	from 
		(select user_id, zipcode from api_userbasicprofile where user_id = 1) u
	left join
		api_zipcodedetail z
	on 1=1 
	where 
		(abs(z.zip_code::int - u.zipcode::int)) < 100
	order by 
		(abs(z.zip_code::int - u.zipcode::int)) desc
	limit 1
),
-- flex rate 
flex_rate as (
	select 
	((case
		when (extract('year' from NOW()::date)  - extract('year' from u.birthday::date)) > 35 then 1
		when (extract('year' from NOW()::date)  - extract('year' from u.birthday::date)) > 29 then .75
		when (extract('year' from NOW()::date)  - extract('year' from u.birthday::date)) > 25 then .5
		when (extract('year' from NOW()::date)  - extract('year' from u.birthday::date)) > 22 then .25
	else 0 end +
	-- hypothesis: undergrads are most likely to move, then graduates, doctorate & HS stay put 
	case
		when lower(u.education) in ('rocket scientist','doctorate') then .75
		when lower(u.education) = 'graduate' then .25
		when lower(u.education) = 'undergraduate' then .25
		when lower(u.education) = 'high school' then .75
	else 0 end +
	case
		when u.num_dependents > 1 then 1
		when u.num_dependents > 0 then .5
	else 0 end +
	case 
		when u.relationship_status in ('married','involved') then .5
	else 0 end ) /4.0 ) as flex_rate
	from 
		(select 
			* 
		from 
			api_userbasicprofile
		where
		user_id = i ) u
),
/* build out the full subcategory suite */
all_subcats as (
	select
		id as subcategory_id,
		0.5 as value
	from
		api_subcategory
	group by 1
),
user_unweighted_vals as (
	select
		a.subcategory_id,
		
		case
			when a.subcategory_id in (9,15,16) then coalesce(((coalesce(d.average_ord_val,0.5) * 2) + flex_rate),1.5) /3.0 
			when a.subcategory_id = 24 then coalesce((coalesce(d.average_ord_val,0.5) + flex_rate),1) / 2.0
			when a.subcategory_id = 17 then coalesce((ass.adjusted_salary_standardized),0.5)
			when a.subcategory_id = 6 then coalesce(((coalesce(ol.rural_score,0.5) * 2 ) + flex_rate),1.5) /3.0
			else coalesce(coalesce(d.average_ord_val,0.5), a.value)
		end as value
	from
		all_subcats a
	left join
		decimal_question_values_unadjusted d
	on
		d.subcategory_id = a.subcategory_id
	left join
		 adjusted_salary ass
	on 1=1
	left join
		flex_rate
	on 1=1
	left join
		office_location ol
	on 1=1
	group by 1,2
)

select 
	i as user_id,
	subcategory_id,
	value,
	NOW(),
	NOW()
	
from user_unweighted_vals;

end;
$$ language plpgsql;
