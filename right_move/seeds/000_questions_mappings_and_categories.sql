BEGIN;
ALTER TABLE api_questionmapping ALTER COLUMN ordinal_reverse DROP NOT NULL;
COMMIT;


BEGIN;
INSERT INTO 
api_category (
                created_at, 
                updated_at, 
                category_name
            ) 
VALUES 
(
                NOW(),
                NOW(),
                'Culture'
        ),
(
                NOW(),
                NOW(),
                'Commute'
        ),
(
                NOW(),
                NOW(),
                'Learning'
        ),
(
                NOW(),
                NOW(),
                'Growth'
        ),
(
                NOW(),
                NOW(),
                'Wellness'
        ),
(
                NOW(),
                NOW(),
                'Compensation'
        ),
(
                NOW(),
                NOW(),
                'Purpose'
        ),
(
                NOW(),
                NOW(),
                'Workday'
        );

COMMIT;
BEGIN;
INSERT INTO 
api_subcategory (
                id, 
                created_at, 
                updated_at, 
                subcategory_name, 
                category_id,
                heuristic_value)
 VALUES 
(
                1, 
                NOW(),
                NOW(),
                'Office Space', 
                (SELECT 
                        id 
                FROM 
                    api_category 
                WHERE 
                    category_name = 'Culture'
                LIMIT 1
                ),
                1.0 
        ),
(
                2, 
                NOW(),
                NOW(),
                'Cultural Alignment', 
                (SELECT 
                        id 
                FROM 
                    api_category 
                WHERE 
                    category_name = 'Culture'
                LIMIT 1
                ),
                1.0 
        ),
(
                3, 
                NOW(),
                NOW(),
                'Company Size', 
                (SELECT 
                        id 
                FROM 
                    api_category 
                WHERE 
                    category_name = 'Culture'
                LIMIT 1
                ),
                1.0 
        ),
(
                4, 
                NOW(),
                NOW(),
                'Remote', 
                (SELECT 
                        id 
                FROM 
                    api_category 
                WHERE 
                    category_name = 'Commute'
                LIMIT 1
                ),
                1.0 
        ),
(
                5, 
                NOW(),
                NOW(),
                'Commute Distance', 
                (SELECT 
                        id 
                FROM 
                    api_category 
                WHERE 
                    category_name = 'Commute'
                LIMIT 1
                ),
                1.0 
        ),
(
                6, 
                NOW(),
                NOW(),
                'Office Location', 
                (SELECT 
                        id 
                FROM 
                    api_category 
                WHERE 
                    category_name = 'Commute'
                LIMIT 1
                ),
                1.0 
        ),
(
                7, 
                NOW(),
                NOW(),
                'Learn New Things', 
                (SELECT 
                        id 
                FROM 
                    api_category 
                WHERE 
                    category_name = 'Learning'
                LIMIT 1
                ),
                1.0 
        ),
(
                8, 
                NOW(),
                NOW(),
                'Acheivements', 
                (SELECT 
                        id 
                FROM 
                    api_category 
                WHERE 
                    category_name = 'Learning'
                LIMIT 1
                ),
                1.0 
        ),
(
                9, 
                NOW(),
                NOW(),
                'Gaining Experience', 
                (SELECT 
                        id 
                FROM 
                    api_category 
                WHERE 
                    category_name = 'Learning'
                LIMIT 1
                ),
                1.0 
        ),
(
                10, 
                NOW(),
                NOW(),
                'Menteeship', 
                (SELECT 
                        id 
                FROM 
                    api_category 
                WHERE 
                    category_name = 'Learning'
                LIMIT 1
                ),
                1.0 
        ),
(
                11, 
                NOW(),
                NOW(),
                'Direct Reports', 
                (SELECT 
                        id 
                FROM 
                    api_category 
                WHERE 
                    category_name = 'Growth'
                LIMIT 1
                ),
                1.0 
        ),
(
                12, 
                NOW(),
                NOW(),
                'Mentorship', 
                (SELECT 
                        id 
                FROM 
                    api_category 
                WHERE 
                    category_name = 'Growth'
                LIMIT 1
                ),
                1.0 
        ),
(
                13, 
                NOW(),
                NOW(),
                'Directing/Architecting', 
                (SELECT 
                        id 
                FROM 
                    api_category 
                WHERE 
                    category_name = 'Growth'
                LIMIT 1
                ),
                1.0 
        ),
(
                14, 
                NOW(),
                NOW(),
                'Org Structure', 
                (SELECT 
                        id 
                FROM 
                    api_category 
                WHERE 
                    category_name = 'Growth'
                LIMIT 1
                ),
                1.0 
        ),
(
                15, 
                NOW(),
                NOW(),
                'Time Off', 
                (SELECT 
                        id 
                FROM 
                    api_category 
                WHERE 
                    category_name = 'Wellness'
                LIMIT 1
                ),
                1.0 
        ),
(
                16, 
                NOW(),
                NOW(),
                'Family Benefits', 
                (SELECT 
                        id 
                FROM 
                    api_category 
                WHERE 
                    category_name = 'Wellness'
                LIMIT 1
                ),
                1.0 
        ),
(
                17, 
                NOW(),
                NOW(),
                '$$$$$', 
                (SELECT 
                        id 
                FROM 
                    api_category 
                WHERE 
                    category_name = 'Compensation'
                LIMIT 1
                ),
                1.0 
        ),
(
                18, 
                NOW(),
                NOW(),
                'Options', 
                (SELECT 
                        id 
                FROM 
                    api_category 
                WHERE 
                    category_name = 'Compensation'
                LIMIT 1
                ),
                1.0 
        ),
(
                19, 
                NOW(),
                NOW(),
                'Company Mission', 
                (SELECT 
                        id 
                FROM 
                    api_category 
                WHERE 
                    category_name = 'Purpose'
                LIMIT 1
                ),
                1.0 
        ),
(
                20, 
                NOW(),
                NOW(),
                'Global Sense of Worth', 
                (SELECT 
                        id 
                FROM 
                    api_category 
                WHERE 
                    category_name = 'Purpose'
                LIMIT 1
                ),
                1.0 
        ),
(
                21, 
                NOW(),
                NOW(),
                'Management', 
                (SELECT 
                        id 
                FROM 
                    api_category 
                WHERE 
                    category_name = 'Workday'
                LIMIT 1
                ),
                1.0 
        ),
(
                22, 
                NOW(),
                NOW(),
                'Intensity', 
                (SELECT 
                        id 
                FROM 
                    api_category 
                WHERE 
                    category_name = 'Workday'
                LIMIT 1
                ),
                1.0 
        ),
(
                23, 
                NOW(),
                NOW(),
                'Workflow maturity', 
                (SELECT 
                        id 
                FROM 
                    api_category 
                WHERE 
                    category_name = 'Workday'
                LIMIT 1
                ),
                1.0 
        ),
(
                24, 
                NOW(),
                NOW(),
                'Adversity to change', 
                (SELECT 
                        id 
                FROM 
                    api_category 
                WHERE 
                    category_name = 'Wellness'
                LIMIT 1
                ),
                1.0 
        );

COMMIT;
BEGIN;
INSERT INTO
api_question (
                id,
                created_at,
                updated_at,
                question_text,
                subcategory_id,
                input_type,
                placeholder
            )
VALUES
(
                1,
                NOW(),
                NOW(),
                'This is where I feel most productive:',
                1,
                'image',
                'please enter a number'
            ),
(
                2,
                NOW(),
                NOW(),
                'Next halloween, it would be great if my boss came dressed as:',
                1,
                'radio',
                'please enter a number'
            ),
(
                3,
                NOW(),
                NOW(),
                'The company handbook refers to retirement savings as "old people perks"',
                1,
                'radio',
                'please enter a number'
            ),
(
                4,
                NOW(),
                NOW(),
                'It’s your birthday. Someone gives me a calfskin wallet. How do I react?',
                1,
                'radio',
                'please enter a number'
            ),
(
                5,
                NOW(),
                NOW(),
                'Every June, the company logo at my job is updated to rainbow colors.',
                1,
                'radio',
                'please enter a number'
            ),
(
                6,
                NOW(),
                NOW(),
                'It''s Monday morning. What do I want to wear to work today?',
                1,
                'radio',
                'please enter a number'
            ),
(
                7,
                NOW(),
                NOW(),
                'My phone contacts include:',
                1,
                'radio',
                'please enter a number'
            ),
(
                8,
                NOW(),
                NOW(),
                'The internet is down in our office.',
                1,
                'radio',
                'please enter a number'
            ),
(
                9,
                NOW(),
                NOW(),
                'The best company holiday party:',
                1,
                'image',
                'please enter a number'
            ),
(
                10,
                NOW(),
                NOW(),
                'I would love to work for a company with _____ employees.',
                1,
                'radio',
                'please enter a number'
            ),
(
                11,
                NOW(),
                NOW(),
                'The hardest working employee is the one that clocks in first and clocks out last.',
                1,
                'radio',
                'please enter a number'
            ),
(
                12,
                NOW(),
                NOW(),
                'Video meetings, calls and emails:',
                1,
                'radio',
                'please enter a number'
            ),
(
                13,
                NOW(),
                NOW(),
                'On the days I don''t go into the office:',
                1,
                'radio',
                'please enter a number'
            ),
(
                14,
                NOW(),
                NOW(),
                'Working from a cabana in the caribbean:',
                1,
                'radio',
                'please enter a number'
            ),
(
                15,
                NOW(),
                NOW(),
                'Focus time without interruption is:',
                1,
                'radio',
                'please enter a number'
            ),
(
                16,
                NOW(),
                NOW(),
                'Best way to get to work:',
                1,
                'image',
                'please enter a number'
            ),
(
                17,
                NOW(),
                NOW(),
                'I own a car.',
                1,
                'radio',
                'please enter a number'
            ),
(
                18,
                NOW(),
                NOW(),
                'Working on personal projects related to my profession:',
                1,
                'radio',
                'please enter a number'
            ),
(
                19,
                NOW(),
                NOW(),
                'If my company offered to pay for (another) degree, no strings attached:',
                1,
                'radio',
                'please enter a number'
            ),
(
                20,
                NOW(),
                NOW(),
                'The last time I read a blog post, Medium etc relating to what I do for a living was:',
                1,
                'radio',
                'please enter a number'
            ),
(
                21,
                NOW(),
                NOW(),
                'When I look back on today a year from now:',
                1,
                'radio',
                'please enter a number'
            ),
(
                22,
                NOW(),
                NOW(),
                'At a profession-related meetup, the room breaks up into "teachers" and "students".',
                1,
                'radio',
                'please enter a number'
            ),
(
                23,
                NOW(),
                NOW(),
                'My resume would greater benefit from:',
                1,
                'radio',
                'please enter a number'
            ),
(
                24,
                NOW(),
                NOW(),
                'I really need more professional "seat time".',
                1,
                'radio',
                'please enter a number'
            ),
(
                25,
                NOW(),
                NOW(),
                'The most valuable relationship I could find at my next role would be:',
                1,
                'radio',
                'please enter a number'
            ),
(
                26,
                NOW(),
                NOW(),
                'I prefer feedback that:',
                1,
                'radio',
                'please enter a number'
            ),
(
                27,
                NOW(),
                NOW(),
                'No matter what my role, the buck stops with me.',
                1,
                'radio',
                'please enter a number'
            ),
(
                28,
                NOW(),
                NOW(),
                'Coaching others to be great makes me feel:',
                1,
                'radio',
                'please enter a number'
            ),
(
                29,
                NOW(),
                NOW(),
                'Being "the boss" is something to be proud of.',
                1,
                'radio',
                'please enter a number'
            ),
(
                30,
                NOW(),
                NOW(),
                'There are things I know now, professionally, that I wish I could share with my past self.',
                1,
                'radio',
                'please enter a number'
            ),
(
                31,
                NOW(),
                NOW(),
                'The next project or job I am on, I want to be:',
                1,
                'radio',
                'please enter a number'
            ),
(
                32,
                NOW(),
                NOW(),
                'I prefer "big picture" thinking to in-the-weeds implementation.',
                1,
                'radio',
                'please enter a number'
            ),
(
                33,
                NOW(),
                NOW(),
                '"Senior Lead Banana Handler" sounds better than "Banana Handler".',
                1,
                'radio',
                'please enter a number'
            ),
(
                34,
                NOW(),
                NOW(),
                'My org vertical is less than 5 people tall from top to bottom.',
                1,
                'radio',
                'please enter a number'
            ),
(
                35,
                NOW(),
                NOW(),
                'The best way to grow your career is usually to change companies.',
                1,
                'radio',
                'please enter a number'
            ),
(
                36,
                NOW(),
                NOW(),
                'My friends want to book a 18 day trip to either Europe, Mexico or Portland (my choice).',
                1,
                'radio',
                'please enter a number'
            ),
(
                37,
                NOW(),
                NOW(),
                'My relationship with my professional work is:',
                1,
                'radio',
                'please enter a number'
            ),
(
                38,
                NOW(),
                NOW(),
                'The number of days I took off from work last year was:',
                1,
                'text',
                'please enter a number'
            ),
(
                39,
                NOW(),
                NOW(),
                'If I suddenly had zero health benefits:',
                1,
                'radio',
                'please enter a number'
            ),
(
                40,
                NOW(),
                NOW(),
                'I have been to the dentist:',
                1,
                'radio',
                'please enter a number'
            ),
(
                41,
                NOW(),
                NOW(),
                'I have been to the emergency room or hospital:',
                1,
                'radio',
                'please enter a number'
            ),
(
                42,
                NOW(),
                NOW(),
                'I think I should be earning _______ in total anually (including bonuses etc).',
                1,
                'text',
                'please enter a number'
            ),
(
                43,
                NOW(),
                NOW(),
                'Gym memberships, free lunches, on-site baristas...',
                1,
                'radio',
                'please enter a number'
            ),
(
                44,
                NOW(),
                NOW(),
                'Believing in the work I do:',
                1,
                'radio',
                'please enter a number'
            ),
(
                45,
                NOW(),
                NOW(),
                'It would bother me the most if:',
                1,
                'radio',
                'please enter a number'
            ),
(
                46,
                NOW(),
                NOW(),
                'My professional self-worth is most significantly influenced by:',
                1,
                'radio',
                'please enter a number'
            ),
(
                47,
                NOW(),
                NOW(),
                'Who is the most successful?',
                1,
                'image',
                'please enter a number'
            ),
(
                48,
                NOW(),
                NOW(),
                'It is my birthday. In a perfect world my supervisor:',
                1,
                'radio',
                'please enter a number'
            ),
(
                49,
                NOW(),
                NOW(),
                'A project I am working on has fallen behind. My boss:',
                1,
                'radio',
                'please enter a number'
            ),
(
                50,
                NOW(),
                NOW(),
                'A project my team member is working on has fallen behind, holding my work up. The boss:',
                1,
                'radio',
                'please enter a number'
            ),
(
                51,
                NOW(),
                NOW(),
                '9-to-5 is:',
                1,
                'radio',
                'please enter a number'
            ),
(
                52,
                NOW(),
                NOW(),
                'In order to bring the Apollo 13 Astronauts home safely, Mission Control team members worked tirelessly without sleep or showers for several days.',
                1,
                'radio',
                'please enter a number'
            ),
(
                53,
                NOW(),
                NOW(),
                'One of these things is not like the other',
                1,
                'image',
                'please enter a number'
            ),
(
                54,
                NOW(),
                NOW(),
                'I will sleep when I''m dead.',
                1,
                'radio',
                'please enter a number'
            ),
(
                55,
                NOW(),
                NOW(),
                'Adrenaline in the workplace:',
                1,
                'radio',
                'please enter a number'
            ),
(
                56,
                NOW(),
                NOW(),
                'I prefer to get my work via',
                1,
                'radio',
                'please enter a number'
            ),
(
                57,
                NOW(),
                NOW(),
                'Ideally, I know what I will be working on:',
                1,
                'radio',
                'please enter a number'
            ),
(
                58,
                NOW(),
                NOW(),
                'When I see a thing that needs to be changed about the project I am working on:',
                1,
                'radio',
                'please enter a number'
            ),
(
                59,
                NOW(),
                NOW(),
                'My company is opening offices in Paris, Sydney, Capetown and Buenos Aires. They are relocating everyone to one of the three (employees'' choice).',
                1,
                'radio',
                'please enter a number'
            ),
(
                60,
                NOW(),
                NOW(),
                'When I walk in to the office Monday morning, it would be refreshing if:',
                1,
                'radio',
                'please enter a number'
            ),
(
                61,
                NOW(),
                NOW(),
                'Here is a YouTube link to something I would play in the background while working:',
                1,
                'text',
                'please enter a number'
            ),
(
                62,
                NOW(),
                NOW(),
                'Who is the real James Bond?',
                1,
                'radio',
                'please enter a number'
            ),
(
                63,
                NOW(),
                NOW(),
                'When it comes to professional sports:',
                1,
                'radio',
                'please enter a number'
            ),
(
                64,
                NOW(),
                NOW(),
                '1 in 5 prisoners in the United States are drug related non-violent offenders.',
                1,
                'radio',
                'please enter a number'
            );

COMMIT;
BEGIN;
INSERT INTO
api_jobquestion (
                id,
                created_at,
                updated_at,
                question_text,
                subcategory_id,
                input_type,
                placeholder
            )
VALUES
(
                1,
                NOW(),
                NOW(),
                'The remote work policy for this role is:',
                1,
                'radio',
                'please enter a number'
            ),
(
                2,
                NOW(),
                NOW(),
                'If I do not take this role, it would still be cool to hang out with at least one person I''ve met at this company socially.',
                1,
                'radio',
                'please enter a number'
            ),
(
                3,
                NOW(),
                NOW(),
                'How many people work at this company?',
                1,
                'text',
                'please enter a number'
            ),
(
                4,
                NOW(),
                NOW(),
                'My new-hire packet is most likely to include:',
                1,
                'radio',
                'please enter a number'
            ),
(
                5,
                NOW(),
                NOW(),
                'The techniques, technologies and skills I use in this role:',
                1,
                'radio',
                'please enter a number'
            ),
(
                6,
                NOW(),
                NOW(),
                'In this role I will be:',
                1,
                'radio',
                'please enter a number'
            ),
(
                7,
                NOW(),
                NOW(),
                'How many people will I be able to learn from directly, considering only people I can identify by first name?',
                1,
                'text',
                'please enter a number'
            ),
(
                8,
                NOW(),
                NOW(),
                'I will have ___ direct reports in this role',
                1,
                'text',
                'please enter a number'
            ),
(
                9,
                NOW(),
                NOW(),
                'When discussing how I will fit into the team:',
                1,
                'radio',
                'please enter a number'
            ),
(
                10,
                NOW(),
                NOW(),
                'In this role I will be:',
                1,
                'radio',
                'please enter a number'
            ),
(
                11,
                NOW(),
                NOW(),
                'My progression path has been outlined:',
                1,
                'radio',
                'please enter a number'
            ),
(
                12,
                NOW(),
                NOW(),
                'When it comes to paid time off, this role:',
                1,
                'radio',
                'please enter a number'
            ),
(
                13,
                NOW(),
                NOW(),
                'The health benefits at this place are:',
                1,
                'radio',
                'please enter a number'
            ),
(
                14,
                NOW(),
                NOW(),
                'Does this role include non-standard perks like a gym membership, free lunches, snacks in the kitchen etc?',
                1,
                'radio',
                'please enter a number'
            ),
(
                15,
                NOW(),
                NOW(),
                'If the company mission was a charitable organization, I would donate to it.',
                1,
                'radio',
                'please enter a number'
            ),
(
                16,
                NOW(),
                NOW(),
                'Someone asks me about this role at a party:',
                1,
                'radio',
                'please enter a number'
            ),
(
                17,
                NOW(),
                NOW(),
                'My direct supervisor in this role:',
                1,
                'radio',
                'please enter a number'
            ),
(
                18,
                NOW(),
                NOW(),
                'The average number of paid time off (PTO) days taken by employees is:',
                1,
                'text',
                'please enter a number'
            ),
(
                19,
                NOW(),
                NOW(),
                'The team this role belongs to tends to average:',
                1,
                'radio',
                'please enter a number'
            ),
(
                20,
                NOW(),
                NOW(),
                'For planning and project management, team this role belongs to uses:',
                1,
                'radio',
                'please enter a number'
            ),
(
                21,
                NOW(),
                NOW(),
                'I would invest money in this company ____.',
                1,
                'radio',
                'please enter a number'
            );

COMMIT;
BEGIN;
INSERT INTO 
api_choice (
            created_at,
            updated_at,
            choice_text,
            question_id
            )
VALUES
(   NOW(),
                                        NOW(),
                                        'https://cdn-images-1.medium.com/max/2600/1*r02q17GGCoyh3JyjNnqoDA.png',
                                        1
                                    ),
(   NOW(),
                                        NOW(),
                                        'https://www.dollarsprout.com/wp-content/uploads/work-from-home-jobs.jpg',
                                        1
                                    ),
(   NOW(),
                                        NOW(),
                                        'https://www.incimages.com/uploaded_files/image/1940x900/Modsy-Office_panoNEW_360130.jpg',
                                        1
                                    ),
(   NOW(),
                                        NOW(),
                                        'https://content.fortune.com/wp-content/uploads/2017/02/gettyimages-501710600.jpg?resize=1402,788',
                                        1
                                    ),
(   NOW(),
                                        NOW(),
                                        'https://www.securitymagazine.com/ext/resources/secenews/2017/board-900.jpg?1483621808',
                                        1
                                    ),
(   NOW(),
                                        NOW(),
                                        'Gene Simmons from KISS',
                                        2
                                    ),
(   NOW(),
                                        NOW(),
                                        'A political figure',
                                        2
                                    ),
(   NOW(),
                                        NOW(),
                                        'A vampire',
                                        2
                                    ),
(   NOW(),
                                        NOW(),
                                        'My boss',
                                        2
                                    ),
(   NOW(),
                                        NOW(),
                                        'That is inappropriate',
                                        3
                                    ),
(   NOW(),
                                        NOW(),
                                        'Sure, why not',
                                        3
                                    ),
(   NOW(),
                                        NOW(),
                                        'Haha that''s awesome',
                                        3
                                    ),
(   NOW(),
                                        NOW(),
                                        'I report them (and also I''m not a replicant)',
                                        4
                                    ),
(   NOW(),
                                        NOW(),
                                        'Thank you I guess?',
                                        4
                                    ),
(   NOW(),
                                        NOW(),
                                        'Nope, I don''t get it',
                                        4
                                    ),
(   NOW(),
                                        NOW(),
                                        'This bothers me',
                                        5
                                    ),
(   NOW(),
                                        NOW(),
                                        'I could care less',
                                        5
                                    ),
(   NOW(),
                                        NOW(),
                                        'This is pretty cool',
                                        5
                                    ),
(   NOW(),
                                        NOW(),
                                        'I love this',
                                        5
                                    ),
(   NOW(),
                                        NOW(),
                                        'Something that meets the minimum legal definintion of "decency"',
                                        6
                                    ),
(   NOW(),
                                        NOW(),
                                        'Something from the clean pile',
                                        6
                                    ),
(   NOW(),
                                        NOW(),
                                        'Something I ironed',
                                        6
                                    ),
(   NOW(),
                                        NOW(),
                                        'Something from a drycleaning bag',
                                        6
                                    ),
(   NOW(),
                                        NOW(),
                                        'Everyone that works at my company',
                                        7
                                    ),
(   NOW(),
                                        NOW(),
                                        'Everyone on my team',
                                        7
                                    ),
(   NOW(),
                                        NOW(),
                                        'Just my boss',
                                        7
                                    ),
(   NOW(),
                                        NOW(),
                                        'A couple friends from work',
                                        7
                                    ),
(   NOW(),
                                        NOW(),
                                        'Zero contacts from work',
                                        7
                                    ),
(   NOW(),
                                        NOW(),
                                        '"did someone remember to pay the internet bill this month?"',
                                        8
                                    ),
(   NOW(),
                                        NOW(),
                                        '"Someone let Cindy know, she''s fixed the network a few times"',
                                        8
                                    ),
(   NOW(),
                                        NOW(),
                                        '"I filled out a ticket with IT but they already know"',
                                        8
                                    ),
(   NOW(),
                                        NOW(),
                                        'https://i.pinimg.com/originals/53/4b/32/534b32bfbbe63f39c41b89b24db9252e.png',
                                        9
                                    ),
(   NOW(),
                                        NOW(),
                                        'https://si.wsj.net/public/resources/images/BN-WK920_HOLIDA_GR_20171204165053.jpg',
                                        9
                                    ),
(   NOW(),
                                        NOW(),
                                        'https://fistfuloftalent.com/wp-content/uploads/2017/12/office-party-.jpg',
                                        9
                                    ),
(   NOW(),
                                        NOW(),
                                        'way more than 300',
                                        10
                                    ),
(   NOW(),
                                        NOW(),
                                        '100 to 300',
                                        10
                                    ),
(   NOW(),
                                        NOW(),
                                        'between 20 and 100',
                                        10
                                    ),
(   NOW(),
                                        NOW(),
                                        'less than 20',
                                        10
                                    ),
(   NOW(),
                                        NOW(),
                                        'Nonsense',
                                        11
                                    ),
(   NOW(),
                                        NOW(),
                                        'Truth',
                                        11
                                    ),
(   NOW(),
                                        NOW(),
                                        'are just as good as face-to-face, maybe even better.',
                                        12
                                    ),
(   NOW(),
                                        NOW(),
                                        'are not quite the same as face-to-face... but close.',
                                        12
                                    ),
(   NOW(),
                                        NOW(),
                                        'are useful, but will never replace in-person time.',
                                        12
                                    ),
(   NOW(),
                                        NOW(),
                                        'are a sad excuse for communication.',
                                        12
                                    ),
(   NOW(),
                                        NOW(),
                                        'I am often up and dressed before the sun rises.',
                                        13
                                    ),
(   NOW(),
                                        NOW(),
                                        'I am usually up in time for brunch.',
                                        13
                                    ),
(   NOW(),
                                        NOW(),
                                        'I am almost always awake before happy hour.',
                                        13
                                    ),
(   NOW(),
                                        NOW(),
                                        'seems pointless. What''s the point of going places to work?',
                                        14
                                    ),
(   NOW(),
                                        NOW(),
                                        'doesn''t phase me either way.',
                                        14
                                    ),
(   NOW(),
                                        NOW(),
                                        'would be awesome.',
                                        14
                                    ),
(   NOW(),
                                        NOW(),
                                        'literally the most valuable thing in the world.',
                                        15
                                    ),
(   NOW(),
                                        NOW(),
                                        'pretty awesome. But not a must-have.',
                                        15
                                    ),
(   NOW(),
                                        NOW(),
                                        'nice to have.',
                                        15
                                    ),
(   NOW(),
                                        NOW(),
                                        'depressing and lonely, really.',
                                        15
                                    ),
(   NOW(),
                                        NOW(),
                                        'https://img.purch.com/h/1000/aHR0cDovL3d3dy5saXZlc2NpZW5jZS5jb20vaW1hZ2VzL2kvMDAwLzA2Ni8yNzEvb3JpZ2luYWwvYWlycGxhbmUtc2VhdC0xNDA1MjAuanBn',
                                        16
                                    ),
(   NOW(),
                                        NOW(),
                                        'http://cdn8.openculture.com/wp-content/uploads/2013/07/Abbey-Road-Album-Cover-.jpg',
                                        16
                                    ),
(   NOW(),
                                        NOW(),
                                        'https://farm4.staticflickr.com/3933/15485047516_3876f78fc5_b.jpg',
                                        16
                                    ),
(   NOW(),
                                        NOW(),
                                        'https://www.zastavki.com/pictures/originals/2015/Auto___Porsche_Brown_Porsche_on_the_highway_outside_the_city_099290_.jpg',
                                        16
                                    ),
(   NOW(),
                                        NOW(),
                                        'Yes I do!',
                                        17
                                    ),
(   NOW(),
                                        NOW(),
                                        'I don''t, but I want one.',
                                        17
                                    ),
(   NOW(),
                                        NOW(),
                                        'Nope.',
                                        17
                                    ),
(   NOW(),
                                        NOW(),
                                        'Is addictive. I need to actively pull myself away from my personal projects.',
                                        18
                                    ),
(   NOW(),
                                        NOW(),
                                        'Happens, but I often loose interest pretty quick.',
                                        18
                                    ),
(   NOW(),
                                        NOW(),
                                        'Seems unhealthy and is not something I do.',
                                        18
                                    ),
(   NOW(),
                                        NOW(),
                                        'I would pass, I don''t have time or interest in more school.',
                                        19
                                    ),
(   NOW(),
                                        NOW(),
                                        'I would enroll next semester!',
                                        19
                                    ),
(   NOW(),
                                        NOW(),
                                        'Today',
                                        20
                                    ),
(   NOW(),
                                        NOW(),
                                        'This week.',
                                        20
                                    ),
(   NOW(),
                                        NOW(),
                                        'Once in college I think?',
                                        20
                                    ),
(   NOW(),
                                        NOW(),
                                        'I want to be embarrassed by how little I knew.',
                                        21
                                    ),
(   NOW(),
                                        NOW(),
                                        'I want to be happy with how much use I''ve gotten from what I know at this moment.',
                                        21
                                    ),
(   NOW(),
                                        NOW(),
                                        'It makes more sense for me to be a teacher.',
                                        22
                                    ),
(   NOW(),
                                        NOW(),
                                        'I would rather be a student.',
                                        22
                                    ),
(   NOW(),
                                        NOW(),
                                        'Impressive production projects that I helped complete.',
                                        23
                                    ),
(   NOW(),
                                        NOW(),
                                        'Additional skills and abilites.',
                                        23
                                    ),
(   NOW(),
                                        NOW(),
                                        'Management experience and direct reports.',
                                        23
                                    ),
(   NOW(),
                                        NOW(),
                                        'Not an issue for me. I have a wealth of experience to draw from.',
                                        24
                                    ),
(   NOW(),
                                        NOW(),
                                        'Sure, I could always gain more insight from doing.',
                                        24
                                    ),
(   NOW(),
                                        NOW(),
                                        'YES! I feel very green.',
                                        24
                                    ),
(   NOW(),
                                        NOW(),
                                        'A friend that I stay close with indefinitely.',
                                        25
                                    ),
(   NOW(),
                                        NOW(),
                                        'A network of professional contacts.',
                                        25
                                    ),
(   NOW(),
                                        NOW(),
                                        'Someone I can learn from and that will push me to grow.',
                                        25
                                    ),
(   NOW(),
                                        NOW(),
                                        'Helps me be a better leader.',
                                        26
                                    ),
(   NOW(),
                                        NOW(),
                                        'Helps me be a better teammate.',
                                        26
                                    ),
(   NOW(),
                                        NOW(),
                                        'Helps me grow and improve my skills.',
                                        26
                                    ),
(   NOW(),
                                        NOW(),
                                        'Nope.',
                                        27
                                    ),
(   NOW(),
                                        NOW(),
                                        'Yes, that''s me.',
                                        27
                                    ),
(   NOW(),
                                        NOW(),
                                        'Amazing. This is easily my favorite part of the job.',
                                        28
                                    ),
(   NOW(),
                                        NOW(),
                                        'Good. This is something I do enjoy among other things.',
                                        28
                                    ),
(   NOW(),
                                        NOW(),
                                        'Meh, I could take or leave it.',
                                        28
                                    ),
(   NOW(),
                                        NOW(),
                                        'Nothing. This isn''t really my focus.',
                                        28
                                    ),
(   NOW(),
                                        NOW(),
                                        'Not really. Work deserves respect, not management.',
                                        29
                                    ),
(   NOW(),
                                        NOW(),
                                        'Yes, great leaders make great teams.',
                                        29
                                    ),
(   NOW(),
                                        NOW(),
                                        'Does the Pope poo in the woods?',
                                        30
                                    ),
(   NOW(),
                                        NOW(),
                                        'Nope, I haven''t really learned enough "the hard way" yet to benefit past me.',
                                        30
                                    ),
(   NOW(),
                                        NOW(),
                                        'Given clear work to accomplish, and judged by how well I complete that work.',
                                        31
                                    ),
(   NOW(),
                                        NOW(),
                                        'Given broad direction with the flexiblity to implement it as I see fit.',
                                        31
                                    ),
(   NOW(),
                                        NOW(),
                                        'Total anonymity to run our portion of the project however I think is best.',
                                        31
                                    ),
(   NOW(),
                                        NOW(),
                                        'Decision-making responsibilty for the entire project.',
                                        31
                                    ),
(   NOW(),
                                        NOW(),
                                        'Absolutely, I love coordinating the different moving parts of a team.',
                                        32
                                    ),
(   NOW(),
                                        NOW(),
                                        'Sure, I enjoy higher level design. But I don''t always love the orchestration parts.',
                                        32
                                    ),
(   NOW(),
                                        NOW(),
                                        'Sorta. I would want to be doing the work as much as planning the big picture.',
                                        32
                                    ),
(   NOW(),
                                        NOW(),
                                        'Not at all. I want to implement.',
                                        32
                                    ),
(   NOW(),
                                        NOW(),
                                        'Not really, corporate titles make me sad.',
                                        33
                                    ),
(   NOW(),
                                        NOW(),
                                        'Either way, doesn''t really mean anything to me.',
                                        33
                                    ),
(   NOW(),
                                        NOW(),
                                        'For sure. People work hard to grow, and titles help acknowledge that.',
                                        33
                                    ),
(   NOW(),
                                        NOW(),
                                        'Perfect!  This is exactly what I want and I hope it never changes.',
                                        34
                                    ),
(   NOW(),
                                        NOW(),
                                        'Good. I could be happy with this forever, and if it did grow a little that would be cool too.',
                                        34
                                    ),
(   NOW(),
                                        NOW(),
                                        'I find this a little concerning, but as long as the org is growing vertically I am excited about it.',
                                        34
                                    ),
(   NOW(),
                                        NOW(),
                                        'This is a red flag for me, I need space to grow my career.',
                                        34
                                    ),
(   NOW(),
                                        NOW(),
                                        'This is the truth and I love it. Life is too short to stay in one place.',
                                        35
                                    ),
(   NOW(),
                                        NOW(),
                                        'This is the truth, though I sometimes wish it was not.',
                                        35
                                    ),
(   NOW(),
                                        NOW(),
                                        'This is not always true.',
                                        35
                                    ),
(   NOW(),
                                        NOW(),
                                        'This usually isn''t true, though I wish it was.',
                                        35
                                    ),
(   NOW(),
                                        NOW(),
                                        'This is untrue and I love it, loyalty is an important virtue that will be repaid.',
                                        35
                                    ),
(   NOW(),
                                        NOW(),
                                        'SICK! Let''s go.',
                                        36
                                    ),
(   NOW(),
                                        NOW(),
                                        'Great, but that feels a little excessive. Can we maybe do 2 weeks?',
                                        36
                                    ),
(   NOW(),
                                        NOW(),
                                        'The longest I am going to put my life on hold is a week, but If that is cool let''s roll!',
                                        36
                                    ),
(   NOW(),
                                        NOW(),
                                        'Long weekend? Sure. That is about my limit at this moment.',
                                        36
                                    ),
(   NOW(),
                                        NOW(),
                                        'Vacations aren''t really how I relax or unwind.',
                                        36
                                    ),
(   NOW(),
                                        NOW(),
                                        'If I didn''t need to, I wouldn''t.',
                                        37
                                    ),
(   NOW(),
                                        NOW(),
                                        'Regularly disconnecting from what I do is critical to my sanity.',
                                        37
                                    ),
(   NOW(),
                                        NOW(),
                                        'Though I may push it to the background during off-hours, my profession is always on my mind',
                                        37
                                    ),
(   NOW(),
                                        NOW(),
                                        'My work is what fuels me. I almost never turn it off.',
                                        37
                                    ),
(   NOW(),
                                        NOW(),
                                        'It would not be a big deal, I / we have another source of coverage.',
                                        39
                                    ),
(   NOW(),
                                        NOW(),
                                        'Oh. Oh no. That would be bad.',
                                        39
                                    ),
(   NOW(),
                                        NOW(),
                                        'At least once in the last 6 months.',
                                        40
                                    ),
(   NOW(),
                                        NOW(),
                                        'At least once in the last year.',
                                        40
                                    ),
(   NOW(),
                                        NOW(),
                                        'Not in a long time. I don''t really dentist.',
                                        40
                                    ),
(   NOW(),
                                        NOW(),
                                        'Never, or at least not in a really long time.',
                                        41
                                    ),
(   NOW(),
                                        NOW(),
                                        'At least once in the last year.',
                                        41
                                    ),
(   NOW(),
                                        NOW(),
                                        'A few times in the last year.',
                                        41
                                    ),
(   NOW(),
                                        NOW(),
                                        'I am in the hospital right now.',
                                        41
                                    ),
(   NOW(),
                                        NOW(),
                                        'Don''t impress me much. Just show me the money.',
                                        43
                                    ),
(   NOW(),
                                        NOW(),
                                        'Are nice enough, but do not really matter in the grand scheme of things.',
                                        43
                                    ),
(   NOW(),
                                        NOW(),
                                        'Can make a meaningful difference in my quality of life.',
                                        43
                                    ),
(   NOW(),
                                        NOW(),
                                        'Make all the difference in today''s office culture.',
                                        43
                                    ),
(   NOW(),
                                        NOW(),
                                        'Is not really important to me.',
                                        44
                                    ),
(   NOW(),
                                        NOW(),
                                        'Would be nice.',
                                        44
                                    ),
(   NOW(),
                                        NOW(),
                                        'Makes it possible for me to thrive.',
                                        44
                                    ),
(   NOW(),
                                        NOW(),
                                        'I am not invested in the mission of my company.',
                                        45
                                    ),
(   NOW(),
                                        NOW(),
                                        'I had made significant sacrifices in the name of the company mission.',
                                        45
                                    ),
(   NOW(),
                                        NOW(),
                                        'I ever put the company mission over my own betterment.',
                                        45
                                    ),
(   NOW(),
                                        NOW(),
                                        'Feeling that my co-workers appreciate me and value what I do.',
                                        46
                                    ),
(   NOW(),
                                        NOW(),
                                        'Feeling like I make a difference in the lives of my co-workers even if they don''t always appreciate it.',
                                        46
                                    ),
(   NOW(),
                                        NOW(),
                                        'The value people outside the organization place on what I do.',
                                        46
                                    ),
(   NOW(),
                                        NOW(),
                                        'The value of my contributions as I see them.',
                                        46
                                    ),
(   NOW(),
                                        NOW(),
                                        'https://img.huffingtonpost.com/asset/5cd5a8132000005c0097ca05.jpeg',
                                        47
                                    ),
(   NOW(),
                                        NOW(),
                                        'https://timesofindia.indiatimes.com/photo/63499375.cms',
                                        47
                                    ),
(   NOW(),
                                        NOW(),
                                        'https://www.coxblue.com/wp-content/uploads/2018/08/wifi-small-business.jpg',
                                        47
                                    ),
(   NOW(),
                                        NOW(),
                                        'https://mondrian.mashable.com/uploads%252Fcard%252Fimage%252F919671%252Feaa5c35b-5076-462d-8aa0-0618f51752f1.jpg%252F950x534__filters%253Aquality%252880%2529.jpg',
                                        47
                                    ),
(   NOW(),
                                        NOW(),
                                        'https://cdn.geekwire.com/wp-content/uploads/2018/01/bezos2-620x403.jpg',
                                        47
                                    ),
(   NOW(),
                                        NOW(),
                                        'Either gets me a cake or discreetly drops off a birthday card, depending on what she thinks will make me happier.',
                                        48
                                    ),
(   NOW(),
                                        NOW(),
                                        'Throws a party, because celebration is part of being a team.',
                                        48
                                    ),
(   NOW(),
                                        NOW(),
                                        'Has no idea today is my birthday.',
                                        48
                                    ),
(   NOW(),
                                        NOW(),
                                        'Has no idea who I am.',
                                        48
                                    ),
(   NOW(),
                                        NOW(),
                                        'Says nothing to me, since I know what is expected.',
                                        49
                                    ),
(   NOW(),
                                        NOW(),
                                        'Lets me know that I am on thin ice, and tells me I need to do whatever it takes to get back on track if I want to keep my job.',
                                        49
                                    ),
(   NOW(),
                                        NOW(),
                                        'Drops me a line that I need to solve the problem and offers to cover my back while I do.',
                                        49
                                    ),
(   NOW(),
                                        NOW(),
                                        'Works through the challenges with me and offers to meet up this weekend so we can get the project back on schedule together.',
                                        49
                                    ),
(   NOW(),
                                        NOW(),
                                        'Commits to a timeline in which the project will be back up to speed, as well as status updates along the way.',
                                        50
                                    ),
(   NOW(),
                                        NOW(),
                                        'Explains that the team member knows they are behind and shares what the team member plans to do about getting back on track.',
                                        50
                                    ),
(   NOW(),
                                        NOW(),
                                        'Holds a meeting with all of the team where responsibility for the work is reviewed, and performance issues documented.',
                                        50
                                    ),
(   NOW(),
                                        NOW(),
                                        'Reprimands the slacking team member to make an example, and lights a fire under them so we can all be sure the work will be on time going forward.',
                                        50
                                    ),
(   NOW(),
                                        NOW(),
                                        'A pipe dream for the masses, and not the kind of work ethic that will get you anywhere.',
                                        51
                                    ),
(   NOW(),
                                        NOW(),
                                        'Something my grandfather did, but would never be competitive today.',
                                        51
                                    ),
(   NOW(),
                                        NOW(),
                                        'As good a place to start as any when considering work/life balance.',
                                        51
                                    ),
(   NOW(),
                                        NOW(),
                                        'A bit overkill in this day and age.',
                                        51
                                    ),
(   NOW(),
                                        NOW(),
                                        'The life of a desk-slave. Find a way to get the job done in 2 hours and go enjoy life.',
                                        51
                                    ),
(   NOW(),
                                        NOW(),
                                        'That would have been such a cool thing to be part of.',
                                        52
                                    ),
(   NOW(),
                                        NOW(),
                                        'I guess they did what they had to do, and I would have done the same.',
                                        52
                                    ),
(   NOW(),
                                        NOW(),
                                        'I would have hated that, and after it was over I would have been looking for a new job.',
                                        52
                                    ),
(   NOW(),
                                        NOW(),
                                        'Nope, that is not for me.',
                                        52
                                    ),
(   NOW(),
                                        NOW(),
                                        'https://upload.wikimedia.org/wikipedia/commons/5/56/Donald_Trump_official_portrait.jpg',
                                        53
                                    ),
(   NOW(),
                                        NOW(),
                                        'https://upload.wikimedia.org/wikipedia/commons/8/8d/President_Barack_Obama.jpg',
                                        53
                                    ),
(   NOW(),
                                        NOW(),
                                        'https://upload.wikimedia.org/wikipedia/commons/e/e1/Hitler_portrait_crop.jpg',
                                        53
                                    ),
(   NOW(),
                                        NOW(),
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/Osama_bin_Laden_portrait.jpg/220px-Osama_bin_Laden_portrait.jpg',
                                        53
                                    ),
(   NOW(),
                                        NOW(),
                                        'Ummm...no. Not cool.',
                                        54
                                    ),
(   NOW(),
                                        NOW(),
                                        'Agreed.',
                                        54
                                    ),
(   NOW(),
                                        NOW(),
                                        'Makes me feel alive!',
                                        55
                                    ),
(   NOW(),
                                        NOW(),
                                        'Makes me feel alive.. and then tired.',
                                        55
                                    ),
(   NOW(),
                                        NOW(),
                                        'Makes me think about finding a new job.',
                                        55
                                    ),
(   NOW(),
                                        NOW(),
                                        'An organized, prioritized task management system.',
                                        56
                                    ),
(   NOW(),
                                        NOW(),
                                        'A collection of todo items I pulled from a project.',
                                        56
                                    ),
(   NOW(),
                                        NOW(),
                                        'My emails and chat messages.',
                                        56
                                    ),
(   NOW(),
                                        NOW(),
                                        'My co-workers asking me directly for help.',
                                        56
                                    ),
(   NOW(),
                                        NOW(),
                                        'Months ahead of time.',
                                        57
                                    ),
(   NOW(),
                                        NOW(),
                                        'Two weeks ahead of time, minimum.',
                                        57
                                    ),
(   NOW(),
                                        NOW(),
                                        'For the next few days.',
                                        57
                                    ),
(   NOW(),
                                        NOW(),
                                        'Today.',
                                        57
                                    ),
(   NOW(),
                                        NOW(),
                                        'As it lands.',
                                        57
                                    ),
(   NOW(),
                                        NOW(),
                                        'I want to be able to just change it.',
                                        58
                                    ),
(   NOW(),
                                        NOW(),
                                        'I want to be able to update a little documentation and pivot.',
                                        58
                                    ),
(   NOW(),
                                        NOW(),
                                        'I want to be able to formally log the change and have a record of it.',
                                        58
                                    ),
(   NOW(),
                                        NOW(),
                                        'WOOO! Packing my things, let''s go!',
                                        59
                                    ),
(   NOW(),
                                        NOW(),
                                        'After much deliberation, I would likely take the relocation.',
                                        59
                                    ),
(   NOW(),
                                        NOW(),
                                        'I''m not moving, so time to look for a new gig.',
                                        59
                                    ),
(   NOW(),
                                        NOW(),
                                        'Everything was exactly the same as we left it on Friday.',
                                        60
                                    ),
(   NOW(),
                                        NOW(),
                                        'There are a few new faces on the team.',
                                        60
                                    ),
(   NOW(),
                                        NOW(),
                                        'The office is re-arranged and some people have changed roles.',
                                        60
                                    ),
(   NOW(),
                                        NOW(),
                                        'The company has completely restructured and I work with all new people.',
                                        60
                                    ),
(   NOW(),
                                        NOW(),
                                        'Sean Connery',
                                        62
                                    ),
(   NOW(),
                                        NOW(),
                                        'Daniel Craig',
                                        62
                                    ),
(   NOW(),
                                        NOW(),
                                        'Roger Moore',
                                        62
                                    ),
(   NOW(),
                                        NOW(),
                                        '‎Ian Fleming',
                                        62
                                    ),
(   NOW(),
                                        NOW(),
                                        '<your team> is a way of life.',
                                        63
                                    ),
(   NOW(),
                                        NOW(),
                                        'I love my teams, but they are not a core part of who I am.',
                                        63
                                    ),
(   NOW(),
                                        NOW(),
                                        'I can watch a game / match and have a good time.',
                                        63
                                    ),
(   NOW(),
                                        NOW(),
                                        'I don''t sportsball.',
                                        63
                                    ),
(   NOW(),
                                        NOW(),
                                        'That is insane, where am I supposed to get my drugs if you keep locking people up?',
                                        64
                                    ),
(   NOW(),
                                        NOW(),
                                        'That is insane. These people need treatment, not punishment.',
                                        64
                                    ),
(   NOW(),
                                        NOW(),
                                        'That is unfortunate, but how we keep order.',
                                        64
                                    ),
(   NOW(),
                                        NOW(),
                                        'That is where they belong, drugs are illigal for a reason.',
                                        64
                                    ),
(   NOW(),
                                        NOW(),
                                        'That is a good start.',
                                        64
                                    );

COMMIT;
BEGIN;
INSERT INTO 
api_jobchoice (
            created_at,
            updated_at,
            choice_text,
            question_id
            )
VALUES
(   NOW(),
                                        NOW(),
                                        'Fully remote.',
                                        1
                                    ),
(   NOW(),
                                        NOW(),
                                        'All but 1-2 days a month.',
                                        1
                                    ),
(   NOW(),
                                        NOW(),
                                        '3-4 days a week.',
                                        1
                                    ),
(   NOW(),
                                        NOW(),
                                        '1-2 days a week.',
                                        1
                                    ),
(   NOW(),
                                        NOW(),
                                        'Zero remote, 100% on-site.',
                                        1
                                    ),
(   NOW(),
                                        NOW(),
                                        'For sure.',
                                        2
                                    ),
(   NOW(),
                                        NOW(),
                                        'Not really.',
                                        2
                                    ),
(   NOW(),
                                        NOW(),
                                        'A nerf gun and a t-shirt.',
                                        4
                                    ),
(   NOW(),
                                        NOW(),
                                        'A couple good professional books.',
                                        4
                                    ),
(   NOW(),
                                        NOW(),
                                        'An employee handbook.',
                                        4
                                    ),
(   NOW(),
                                        NOW(),
                                        'A gold-plated fountain pen.',
                                        4
                                    ),
(   NOW(),
                                        NOW(),
                                        'Will be totally new to me.',
                                        5
                                    ),
(   NOW(),
                                        NOW(),
                                        'Will be a mix of new and stuff I know.',
                                        5
                                    ),
(   NOW(),
                                        NOW(),
                                        'Wil be mostly stuff I know, with a little new.',
                                        5
                                    ),
(   NOW(),
                                        NOW(),
                                        'Will be all old-hat for me.',
                                        5
                                    ),
(   NOW(),
                                        NOW(),
                                        'All hands-on doing the work.',
                                        6
                                    ),
(   NOW(),
                                        NOW(),
                                        'Largely hands-on but also managing.',
                                        6
                                    ),
(   NOW(),
                                        NOW(),
                                        'Mostly managing with a little hands-on.',
                                        6
                                    ),
(   NOW(),
                                        NOW(),
                                        'All management and leadership.',
                                        6
                                    ),
(   NOW(),
                                        NOW(),
                                        'Teammates have expressed interest in learning from me.',
                                        9
                                    ),
(   NOW(),
                                        NOW(),
                                        'The team is generally excited about a new peer.',
                                        9
                                    ),
(   NOW(),
                                        NOW(),
                                        'The team is excited to teach me new things.',
                                        9
                                    ),
(   NOW(),
                                        NOW(),
                                        'Calling the shots.',
                                        10
                                    ),
(   NOW(),
                                        NOW(),
                                        'Taking direction.',
                                        10
                                    ),
(   NOW(),
                                        NOW(),
                                        'Clearly. I know exactly how I will get promoted.',
                                        11
                                    ),
(   NOW(),
                                        NOW(),
                                        'Loosely. We agree what +/- 12 months will look like.',
                                        11
                                    ),
(   NOW(),
                                        NOW(),
                                        'As something that does not matter right now.',
                                        11
                                    ),
(   NOW(),
                                        NOW(),
                                        'Has unlimited and people use it.',
                                        12
                                    ),
(   NOW(),
                                        NOW(),
                                        'Includes > 2 weeks off a year.',
                                        12
                                    ),
(   NOW(),
                                        NOW(),
                                        'Includes <= 2 weeks a year, but some.',
                                        12
                                    ),
(   NOW(),
                                        NOW(),
                                        'Has unlimited, but people are not able to use it.',
                                        12
                                    ),
(   NOW(),
                                        NOW(),
                                        'Has none.',
                                        12
                                    ),
(   NOW(),
                                        NOW(),
                                        'Outstanding - full health, dental, vision etc.',
                                        13
                                    ),
(   NOW(),
                                        NOW(),
                                        'Pretty good coverage, would rate above average.',
                                        13
                                    ),
(   NOW(),
                                        NOW(),
                                        'Average / just OK.',
                                        13
                                    ),
(   NOW(),
                                        NOW(),
                                        'Poor, but something.',
                                        13
                                    ),
(   NOW(),
                                        NOW(),
                                        'No health & wellness coverage.',
                                        13
                                    ),
(   NOW(),
                                        NOW(),
                                        'This role is pretty bare-bones as far as perks go.',
                                        14
                                    ),
(   NOW(),
                                        NOW(),
                                        'There are a few extra perks but they don''t really impact me.',
                                        14
                                    ),
(   NOW(),
                                        NOW(),
                                        'The non-standard perks are cool and I will get use from them.',
                                        14
                                    ),
(   NOW(),
                                        NOW(),
                                        'At least one of the non-standard perks has a significant impact on my life.',
                                        14
                                    ),
(   NOW(),
                                        NOW(),
                                        'Nope.',
                                        15
                                    ),
(   NOW(),
                                        NOW(),
                                        'For sure.',
                                        15
                                    ),
(   NOW(),
                                        NOW(),
                                        'And telling them about it makes me feel cool.',
                                        16
                                    ),
(   NOW(),
                                        NOW(),
                                        'And it will likely lead to an interesting conversation.',
                                        16
                                    ),
(   NOW(),
                                        NOW(),
                                        'And I summarize and look for common ground with them.',
                                        16
                                    ),
(   NOW(),
                                        NOW(),
                                        'And I change the subject.',
                                        16
                                    ),
(   NOW(),
                                        NOW(),
                                        'Is still a mystery to me.',
                                        17
                                    ),
(   NOW(),
                                        NOW(),
                                        'Is less than engaged with this role.',
                                        17
                                    ),
(   NOW(),
                                        NOW(),
                                        'Is marginally engaged with this role.',
                                        17
                                    ),
(   NOW(),
                                        NOW(),
                                        'Is supportive and invested in this role.',
                                        17
                                    ),
(   NOW(),
                                        NOW(),
                                        'Is a champion for this role.',
                                        17
                                    ),
(   NOW(),
                                        NOW(),
                                        'less than 30 hours a week',
                                        19
                                    ),
(   NOW(),
                                        NOW(),
                                        '30-40 hours a week',
                                        19
                                    ),
(   NOW(),
                                        NOW(),
                                        '40-50 hours a week',
                                        19
                                    ),
(   NOW(),
                                        NOW(),
                                        '50+ hours a week without weekends',
                                        19
                                    ),
(   NOW(),
                                        NOW(),
                                        'Seemingly 24/7',
                                        19
                                    ),
(   NOW(),
                                        NOW(),
                                        'A project management tool that the org respects and knows how to use.',
                                        20
                                    ),
(   NOW(),
                                        NOW(),
                                        'A project management tool that is generally used, but often circumvented.',
                                        20
                                    ),
(   NOW(),
                                        NOW(),
                                        'Email chains, chat, and informal todo tools.',
                                        20
                                    ),
(   NOW(),
                                        NOW(),
                                        'Total chaos.',
                                        20
                                    ),
(   NOW(),
                                        NOW(),
                                        'Under no circumstances.',
                                        21
                                    ),
(   NOW(),
                                        NOW(),
                                        'From my "high risk" savings.',
                                        21
                                    ),
(   NOW(),
                                        NOW(),
                                        'From my retirement fund.',
                                        21
                                    ),
(   NOW(),
                                        NOW(),
                                        'From a loved one''s retirement fund.',
                                        21
                                    );

COMMIT;
BEGIN;
 INSERT INTO 
api_questionmapping (
                        question_type,
                        question_id,
                        subcategory_id,
                        ordinal_reverse
                    )
VALUES
(
        'job',
        5,
        10,
        TRUE
    ),
(
        'job',
        4,
        9,
        FALSE
    ),
(
        'job',
        1,
        1,
        FALSE
    ),
(
        'job',
        1,
        4,
        TRUE
    ),
(
        'job',
        2,
        2,
        FALSE
    ),
(
        'job',
        3,
        3,
        NULL
    ),
(
        'job',
        4,
        1,
        FALSE
    ),
(
        'job',
        5,
        7,
        TRUE
    ),
(
        'job',
        6,
        8,
        TRUE
    ),
(
        'job',
        7,
        9,
        NULL
    ),
(
        'job',
        7,
        10,
        NULL
    ),
(
        'job',
        8,
        11,
        NULL
    ),
(
        'job',
        8,
        12,
        NULL
    ),
(
        'job',
        9,
        12,
        TRUE
    ),
(
        'job',
        10,
        13,
        TRUE
    ),
(
        'job',
        11,
        14,
        TRUE
    ),
(
        'job',
        12,
        15,
        TRUE
    ),
(
        'job',
        12,
        2,
        TRUE
    ),
(
        'job',
        12,
        16,
        TRUE
    ),
(
        'job',
        13,
        16,
        TRUE
    ),
(
        'job',
        13,
        18,
        TRUE
    ),
(
        'job',
        14,
        18,
        FALSE
    ),
(
        'job',
        15,
        19,
        FALSE
    ),
(
        'job',
        16,
        20,
        TRUE
    ),
(
        'job',
        17,
        21,
        FALSE
    ),
(
        'job',
        18,
        22,
        NULL
    ),
(
        'job',
        18,
        15,
        NULL
    ),
(
        'job',
        19,
        22,
        FALSE
    ),
(
        'job',
        20,
        23,
        TRUE
    ),
(
        'job',
        21,
        24,
        FALSE
    ),
(
        'user',
        1,
        1,
        FALSE
    ),
(
        'user',
        1,
        4,
        TRUE
    ),
(
        'user',
        2,
        2,
        TRUE
    ),
(
        'user',
        3,
        2,
        FALSE
    ),
(
        'user',
        4,
        2,
        TRUE
    ),
(
        'user',
        5,
        2,
        FALSE
    ),
(
        'user',
        6,
        2,
        TRUE
    ),
(
        'user',
        7,
        3,
        TRUE
    ),
(
        'user',
        8,
        3,
        TRUE
    ),
(
        'user',
        9,
        3,
        TRUE
    ),
(
        'user',
        10,
        3,
        FALSE
    ),
(
        'user',
        11,
        4,
        FALSE
    ),
(
        'user',
        12,
        4,
        FALSE
    ),
(
        'user',
        13,
        4,
        FALSE
    ),
(
        'user',
        14,
        4,
        TRUE
    ),
(
        'user',
        15,
        4,
        FALSE
    ),
(
        'user',
        16,
        5,
        FALSE
    ),
(
        'user',
        17,
        5,
        TRUE
    ),
(
        'user',
        18,
        7,
        TRUE
    ),
(
        'user',
        19,
        7,
        FALSE
    ),
(
        'user',
        20,
        7,
        TRUE
    ),
(
        'user',
        21,
        7,
        TRUE
    ),
(
        'user',
        22,
        7,
        FALSE
    ),
(
        'user',
        23,
        8,
        TRUE
    ),
(
        'user',
        24,
        9,
        FALSE
    ),
(
        'user',
        25,
        10,
        FALSE
    ),
(
        'user',
        26,
        10,
        FALSE
    ),
(
        'user',
        26,
        12,
        TRUE
    ),
(
        'user',
        27,
        11,
        FALSE
    ),
(
        'user',
        28,
        11,
        TRUE
    ),
(
        'user',
        29,
        12,
        FALSE
    ),
(
        'user',
        30,
        12,
        TRUE
    ),
(
        'user',
        31,
        13,
        FALSE
    ),
(
        'user',
        32,
        13,
        TRUE
    ),
(
        'user',
        33,
        14,
        FALSE
    ),
(
        'user',
        34,
        14,
        FALSE
    ),
(
        'user',
        35,
        14,
        TRUE
    ),
(
        'user',
        36,
        15,
        TRUE
    ),
(
        'user',
        37,
        15,
        TRUE
    ),
(
        'user',
        38,
        15,
        NULL
    ),
(
        'user',
        39,
        16,
        FALSE
    ),
(
        'user',
        40,
        16,
        TRUE
    ),
(
        'user',
        41,
        16,
        FALSE
    ),
(
        'user',
        42,
        17,
        NULL
    ),
(
        'user',
        43,
        18,
        FALSE
    ),
(
        'user',
        44,
        19,
        FALSE
    ),
(
        'user',
        45,
        19,
        TRUE
    ),
(
        'user',
        46,
        20,
        TRUE
    ),
(
        'user',
        47,
        20,
        FALSE
    ),
(
        'user',
        48,
        21,
        TRUE
    ),
(
        'user',
        49,
        21,
        FALSE
    ),
(
        'user',
        50,
        21,
        TRUE
    ),
(
        'user',
        51,
        22,
        TRUE
    ),
(
        'user',
        52,
        22,
        TRUE
    ),
(
        'user',
        54,
        22,
        FALSE
    ),
(
        'user',
        55,
        22,
        TRUE
    ),
(
        'user',
        56,
        23,
        TRUE
    ),
(
        'user',
        57,
        23,
        TRUE
    ),
(
        'user',
        58,
        23,
        FALSE
    ),
(
        'user',
        59,
        24,
        FALSE
    ),
(
        'user',
        60,
        24,
        TRUE
    );

COMMIT;
BEGIN;
UPDATE api_question
SET
    subcategory_id = 1
WHERE
    id = 1
;
UPDATE api_question
SET
    subcategory_id = 4
WHERE
    id = 1
;
UPDATE api_question
SET
    subcategory_id = 2
WHERE
    id = 2
;
UPDATE api_question
SET
    subcategory_id = 2
WHERE
    id = 3
;
UPDATE api_question
SET
    subcategory_id = 2
WHERE
    id = 4
;
UPDATE api_question
SET
    subcategory_id = 2
WHERE
    id = 5
;
UPDATE api_question
SET
    subcategory_id = 2
WHERE
    id = 6
;
UPDATE api_question
SET
    subcategory_id = 3
WHERE
    id = 7
;
UPDATE api_question
SET
    subcategory_id = 3
WHERE
    id = 8
;
UPDATE api_question
SET
    subcategory_id = 3
WHERE
    id = 9
;
UPDATE api_question
SET
    subcategory_id = 3
WHERE
    id = 10
;
UPDATE api_question
SET
    subcategory_id = 4
WHERE
    id = 11
;
UPDATE api_question
SET
    subcategory_id = 4
WHERE
    id = 12
;
UPDATE api_question
SET
    subcategory_id = 4
WHERE
    id = 13
;
UPDATE api_question
SET
    subcategory_id = 4
WHERE
    id = 14
;
UPDATE api_question
SET
    subcategory_id = 4
WHERE
    id = 15
;
UPDATE api_question
SET
    subcategory_id = 5
WHERE
    id = 16
;
UPDATE api_question
SET
    subcategory_id = 5
WHERE
    id = 17
;
UPDATE api_question
SET
    subcategory_id = 7
WHERE
    id = 18
;
UPDATE api_question
SET
    subcategory_id = 7
WHERE
    id = 19
;
UPDATE api_question
SET
    subcategory_id = 7
WHERE
    id = 20
;
UPDATE api_question
SET
    subcategory_id = 7
WHERE
    id = 21
;
UPDATE api_question
SET
    subcategory_id = 7
WHERE
    id = 22
;
UPDATE api_question
SET
    subcategory_id = 8
WHERE
    id = 23
;
UPDATE api_question
SET
    subcategory_id = 9
WHERE
    id = 24
;
UPDATE api_question
SET
    subcategory_id = 10
WHERE
    id = 25
;
UPDATE api_question
SET
    subcategory_id = 10
WHERE
    id = 26
;
UPDATE api_question
SET
    subcategory_id = 12
WHERE
    id = 26
;
UPDATE api_question
SET
    subcategory_id = 11
WHERE
    id = 27
;
UPDATE api_question
SET
    subcategory_id = 11
WHERE
    id = 28
;
UPDATE api_question
SET
    subcategory_id = 12
WHERE
    id = 29
;
UPDATE api_question
SET
    subcategory_id = 12
WHERE
    id = 30
;
UPDATE api_question
SET
    subcategory_id = 13
WHERE
    id = 31
;
UPDATE api_question
SET
    subcategory_id = 13
WHERE
    id = 32
;
UPDATE api_question
SET
    subcategory_id = 14
WHERE
    id = 33
;
UPDATE api_question
SET
    subcategory_id = 14
WHERE
    id = 34
;
UPDATE api_question
SET
    subcategory_id = 14
WHERE
    id = 35
;
UPDATE api_question
SET
    subcategory_id = 15
WHERE
    id = 36
;
UPDATE api_question
SET
    subcategory_id = 15
WHERE
    id = 37
;
UPDATE api_question
SET
    subcategory_id = 15
WHERE
    id = 38
;
UPDATE api_question
SET
    subcategory_id = 16
WHERE
    id = 39
;
UPDATE api_question
SET
    subcategory_id = 16
WHERE
    id = 40
;
UPDATE api_question
SET
    subcategory_id = 16
WHERE
    id = 41
;
UPDATE api_question
SET
    subcategory_id = 17
WHERE
    id = 42
;
UPDATE api_question
SET
    subcategory_id = 18
WHERE
    id = 43
;
UPDATE api_question
SET
    subcategory_id = 19
WHERE
    id = 44
;
UPDATE api_question
SET
    subcategory_id = 19
WHERE
    id = 45
;
UPDATE api_question
SET
    subcategory_id = 20
WHERE
    id = 46
;
UPDATE api_question
SET
    subcategory_id = 20
WHERE
    id = 47
;
UPDATE api_question
SET
    subcategory_id = 21
WHERE
    id = 48
;
UPDATE api_question
SET
    subcategory_id = 21
WHERE
    id = 49
;
UPDATE api_question
SET
    subcategory_id = 21
WHERE
    id = 50
;
UPDATE api_question
SET
    subcategory_id = 22
WHERE
    id = 51
;
UPDATE api_question
SET
    subcategory_id = 22
WHERE
    id = 52
;
UPDATE api_question
SET
    subcategory_id = 22
WHERE
    id = 54
;
UPDATE api_question
SET
    subcategory_id = 22
WHERE
    id = 55
;
UPDATE api_question
SET
    subcategory_id = 23
WHERE
    id = 56
;
UPDATE api_question
SET
    subcategory_id = 23
WHERE
    id = 57
;
UPDATE api_question
SET
    subcategory_id = 23
WHERE
    id = 58
;
UPDATE api_question
SET
    subcategory_id = 24
WHERE
    id = 59
;
UPDATE api_question
SET
    subcategory_id = 24
WHERE
    id = 60
;
UPDATE api_jobquestion
SET
    subcategory_id = 1
WHERE
    id = 1
;
UPDATE api_jobquestion
SET
    subcategory_id = 4
WHERE
    id = 1
;
UPDATE api_jobquestion
SET
    subcategory_id = 2
WHERE
    id = 2
;
UPDATE api_jobquestion
SET
    subcategory_id = 3
WHERE
    id = 3
;
UPDATE api_jobquestion
SET
    subcategory_id = 1
WHERE
    id = 4
;
UPDATE api_jobquestion
SET
    subcategory_id = 7
WHERE
    id = 5
;
UPDATE api_jobquestion
SET
    subcategory_id = 8
WHERE
    id = 6
;
UPDATE api_jobquestion
SET
    subcategory_id = 9
WHERE
    id = 7
;
UPDATE api_jobquestion
SET
    subcategory_id = 10
WHERE
    id = 7
;
UPDATE api_jobquestion
SET
    subcategory_id = 11
WHERE
    id = 8
;
UPDATE api_jobquestion
SET
    subcategory_id = 12
WHERE
    id = 8
;
UPDATE api_jobquestion
SET
    subcategory_id = 12
WHERE
    id = 9
;
UPDATE api_jobquestion
SET
    subcategory_id = 13
WHERE
    id = 10
;
UPDATE api_jobquestion
SET
    subcategory_id = 14
WHERE
    id = 11
;
UPDATE api_jobquestion
SET
    subcategory_id = 15
WHERE
    id = 12
;
UPDATE api_jobquestion
SET
    subcategory_id = 2
WHERE
    id = 12
;
UPDATE api_jobquestion
SET
    subcategory_id = 16
WHERE
    id = 12
;
UPDATE api_jobquestion
SET
    subcategory_id = 16
WHERE
    id = 13
;
UPDATE api_jobquestion
SET
    subcategory_id = 18
WHERE
    id = 13
;
UPDATE api_jobquestion
SET
    subcategory_id = 18
WHERE
    id = 14
;
UPDATE api_jobquestion
SET
    subcategory_id = 19
WHERE
    id = 15
;
UPDATE api_jobquestion
SET
    subcategory_id = 20
WHERE
    id = 16
;
UPDATE api_jobquestion
SET
    subcategory_id = 21
WHERE
    id = 17
;
UPDATE api_jobquestion
SET
    subcategory_id = 22
WHERE
    id = 18
;
UPDATE api_jobquestion
SET
    subcategory_id = 15
WHERE
    id = 18
;
UPDATE api_jobquestion
SET
    subcategory_id = 22
WHERE
    id = 19
;
UPDATE api_jobquestion
SET
    subcategory_id = 23
WHERE
    id = 20
;
UPDATE api_jobquestion
SET
    subcategory_id = 24
WHERE
    id = 21
;

COMMIT;
BEGIN;
UPDATE api_subcategory
SET heuristic_value = 0.02 
WHERE id = 1;
UPDATE api_subcategory
SET heuristic_value = 0.04 
WHERE id = 2;
UPDATE api_subcategory
SET heuristic_value = 0.02 
WHERE id = 3;
UPDATE api_subcategory
SET heuristic_value = 0.01 
WHERE id = 4;
UPDATE api_subcategory
SET heuristic_value = 0.03 
WHERE id = 5;
UPDATE api_subcategory
SET heuristic_value = 0.01 
WHERE id = 6;
UPDATE api_subcategory
SET heuristic_value = 0.02 
WHERE id = 7;
UPDATE api_subcategory
SET heuristic_value = 0.02 
WHERE id = 8;
UPDATE api_subcategory
SET heuristic_value = 0.03 
WHERE id = 9;
UPDATE api_subcategory
SET heuristic_value = 0.04 
WHERE id = 10;
UPDATE api_subcategory
SET heuristic_value = 0.01 
WHERE id = 11;
UPDATE api_subcategory
SET heuristic_value = 0.07 
WHERE id = 12;
UPDATE api_subcategory
SET heuristic_value = 0.01 
WHERE id = 13;
UPDATE api_subcategory
SET heuristic_value = 0.01 
WHERE id = 14;
UPDATE api_subcategory
SET heuristic_value = 0.07 
WHERE id = 15;
UPDATE api_subcategory
SET heuristic_value = 0.02 
WHERE id = 16;
UPDATE api_subcategory
SET heuristic_value = 0.25 
WHERE id = 17;
UPDATE api_subcategory
SET heuristic_value = 0.05 
WHERE id = 18;
UPDATE api_subcategory
SET heuristic_value = 0.05 
WHERE id = 19;
UPDATE api_subcategory
SET heuristic_value = 0.05 
WHERE id = 20;
UPDATE api_subcategory
SET heuristic_value = 0.06 
WHERE id = 21;
UPDATE api_subcategory
SET heuristic_value = 0.06 
WHERE id = 22;
UPDATE api_subcategory
SET heuristic_value = 0.03 
WHERE id = 23;
UPDATE api_subcategory
SET heuristic_value = 0.02 
WHERE id = 24;

COMMIT;
BEGIN;

SELECT setval('api_question_id_seq', COALESCE((SELECT MAX(id)+1 FROM api_question), 1), false);
 
SELECT setval('api_jobquestion_id_seq', COALESCE((SELECT MAX(id)+1 FROM api_jobquestion), 1), false);
 
SELECT setval('api_subcategory_id_seq', COALESCE((SELECT MAX(id)+1 FROM api_subcategory), 1), false);
 
COMMIT;
