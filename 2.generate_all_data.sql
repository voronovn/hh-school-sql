-- CREATE FUNCTION random_vacancy_body_id() 
--     RETURNS INT
--     VOLATILE      
--     LANGUAGE SQL
-- AS
-- $$
--     SELECT
--         vacancy_body_id
--     FROM
--         vacancy_body
--     ORDER BY
--         random()
--     LIMIT
--         1 ;
-- $$ ;
-- CREATE FUNCTION random_vacancy_id() 
--     RETURNS INT
--     VOLATILE      
--     LANGUAGE SQL
-- AS
-- $$
--     SELECT
--         vacancy_id
--     FROM
--         vacancy
--     ORDER BY
--         random()
--     LIMIT
--         1 ;
-- $$ ;
-- CREATE FUNCTION random_specialization_id() 
--     RETURNS INT
--     VOLATILE    
--     LANGUAGE SQL
-- AS
-- $$
--     SELECT
--         specialization_id
--     FROM
--         specializations
--     ORDER BY
--         random()
--     LIMIT
--         1 ;
-- $$ ;

--  CREATE FUNCTION random_user_id() 
--      RETURNS INT
--      VOLATILE      
--      LANGUAGE SQL
--  AS
--  $$
--      SELECT
--          user_id
--      FROM
--          users
--      ORDER BY
--          random()
--      LIMIT
--          1 ;
--  $$ ;

--  CREATE FUNCTION random_cv_id() 
--      RETURNS INT
--      VOLATILE      
--      LANGUAGE SQL
--  AS
--  $$
--      SELECT
--          cv_id
--      FROM
--          users_cv
--      ORDER BY
--          random()
--      LIMIT
--          1 ;
--  $$ ;
INSERT INTO specializations (name, laboring, root_specialization)
SELECT 
	(SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
            (random() * 77)::integer + 1, 1
        ), 
        '') 
    	FROM generate_series(1, 1 + (random() * 190 + i % 10)::integer))as name,
	    (random() > 0.5) AS laboring,
		(random() * 1000)::int AS root_specialization
	FROM generate_series(1, 100) AS g(i);

	
		
		
INSERT INTO users (photo_id,last_name,first_name,middle_name,birth_date,gender_id,area_id,has_vehicle)
SELECT 
	(random() * 1000)::int AS photo_id,
	(SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
            (random() * 77)::integer + 1, 1
        ), 
        '') 
    	FROM generate_series(1, 1 + (random() * 190 + i % 10)::integer))as last_name,
	(SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
            (random() * 77)::integer + 1, 1
        ), 
        '') 
    	FROM generate_series(1, 1 + (random() * 190 + i % 10)::integer))as first_name,
		(SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
            (random() * 77)::integer + 1, 1
        ), 
        '') 
    	FROM generate_series(1, 1 + (random() * 190 + i % 10)::integer))as middle_name,
		now()-(random() * 365 * 24 * 3600 * 80) * '1 second'::interval AS birth_date,
		(random() * 10)::int AS gender_id,
		(random() * 100)::int AS area_id,
    	(random() > 0.5) AS has_vehicle
	FROM generate_series(1, 10000) AS g(i);



INSERT INTO users_cv (user_id, relocation_id,business_trip_readiness_id,
					  contact_ids,portfolio_ids,site_ids,title,specialization_ids,
					  salary,employments_ids,schedules_ids,education_ids,language_ids,
					 experience_ids,skills,skill_set,travel_time,recommendation_ids,
					 resume_locale,certificate_ids,access_id,is_finished,is_blocked,cv_status_id, creation_time)
SELECT 
	    (random()*10000)::int as user_id,--random_user_id() as user_id,
 		(select array_agg(round(random()* 10)::int)
     	from generate_series(1, 5+i%10)) as relocation_id,
		(random() * 100)::int AS business_trip_readiness_id,
		(select array_agg(round(random()* 200)::int)
    	from generate_series(1, ((random()*10)+i%10)::int)) as contact_ids,	
		(select array_agg(round(random()* 200)::int)
    	from generate_series(1, ((random()*10)+i%10)::int)) as portfolio_ids,	
		(select array_agg(round(random()* 200)::int)
    	from generate_series(1, ((random()*10)+i%10)::int)) as site_ids,			
		(SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
            (random() * 77)::integer + 1, 1
        ), 
        '') 
    	FROM generate_series(1, 1 + (random() * 140 + i % 10)::integer))as title,
		(select array_agg(random_specialization_id())
    	from generate_series(1, (1 +(random()*10)+i%10)::int)) as specialization_ids,
		50000 + (random() * 200000)::int as salary,
		(select array_agg(round(random()* 200)::int)
    	from generate_series(1, ((1+random()*10)+i%10)::int)) as employments_ids,
		(select array_agg(round(random()* 200)::int)
    	from generate_series(1, (1 +(random()*10)+i%10)::int)) as schedules_ids,
		(select array_agg(round(random()* 200)::int)
    	from generate_series(1, ((1+random()*10)+i%10)::int)) as education_ids,
		(select array_agg(round(random()* 200)::int)
    	from generate_series(1, (1 +(random()*10)+i%10)::int)) as language_ids,
		(select array_agg(round(random()* 200)::int)
    	from generate_series(1, (1 +(random()*30)+i%10)::int)) as experience_ids,
		(SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
            (random() * 77)::integer + 1, 1
        ), 
        '') 
    	FROM generate_series(1, 1 + (random() * 140 + i % 10)::integer)) as skills,
		(select array_agg(round(random()* 200)::int)
    	from generate_series(1, 1 +(random()*30+i%5)::int)) as skill_set,
		1 + (random() * 5)::int as travel_time,
		(select array_agg(round(random()* 200)::int)
    	from generate_series(1, (random()*30)::int)) as recommendation_ids,
		1 + (random() * 50)::int as	resume_locale,
		(select array_agg(round(random()* 200)::int)
    	from generate_series(1, (1 +(random()*30)+i%10)::int)) as certificate_ids,
		(random() * 4)::int as access_id,
		(random() > 0.5) as is_finished,
		(random() > 0.5) as is_blocked,
		1 + (random() * 50)::int as cv_status_id,
        now()-(random() * 365 * 24 * 3600 * 5) * '1 second'::interval AS creation_time

	FROM generate_series(1, 100000) AS g(i);

INSERT INTO vacancy_body(
    company_name, name, text, area_id, address_id, work_experience, 
    compensation_from, compensation_to,test_solution_required,
    work_schedule_type, employment_type, compensation_gross
)
SELECT 
    (SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
            (random() * 77)::integer + 1, 1
        ), 
        '') 
    FROM generate_series(1, 1 + (random() * 140 + i % 10)::integer)) AS company_name,

    (SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
            (random() * 77)::integer + 1, 1
        ), 
        '') 
    FROM generate_series(1, 1 + (random() * 210 + i % 10)::integer)) AS name,

    (SELECT string_agg(
        substr(
            '      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
            (random() * 77)::integer + 1, 1
        ), 
        '') 
    FROM generate_series(1, 1 + (random() * 50 + i % 10)::integer)) AS text,
	

    (random() * 1000)::int AS area_id,
    (random() * 50000)::int AS address_id,
    (random() * 120)::int AS work_experience,
    25000 + (random() * 150000)::int AS compensation_from,
	50000 + (random() * 200000)::int AS compensation_to,
	(random() > 0.5) AS test_solution_required,
    floor(random() * 5)::int AS work_schedule_type,
    floor(random() * 5)::int AS employment_type,
    (random() > 0.5) AS compensation_gross

FROM generate_series(1, 15000) AS g(i);

delete from vacancy_body where compensation_from > compensation_to;
INSERT INTO vacancy (creation_time, expire_time, employer_id, disabled, visible, area_id,vacancy_body_id)
SELECT
    -- random in last 5 years
    now()-(random() * 365 * 24 * 3600 * 5) * '1 second'::interval AS creation_time,
    now()-(random() * 365 * 24 * 3600 * 5) * '1 second'::interval AS expire_time,
    (random() * 1000000)::int AS employer_id,
    (random() > 0.5) AS disabled,
    (random() > 0.5) AS visible,
    (random() * 1000)::int AS area_id,
	(random()*15000)::int as vacancy_body_id
--random_vacancy_body_id() as vacancy_body_id
FROM generate_series(1, 20000) AS g(i);

-- Delete invalid records
DELETE FROM vacancy WHERE expire_time <= creation_time;



INSERT INTO vacancy_body_specialization(
	
    vacancy_body_id,
    specialization_id
)
SELECT     
	--random_vacancy_body_id() as vacancy_body_id,
	(random()*15000)::int as vacancy_body_id,
	random_specialization_id() AS specialization_id
FROM generate_series(1, 5000) AS g(i);


INSERT INTO replies (vacancy_id,cv_id,reply_time)
	SELECT 
		(random()*20000)::int as vacancy_id,--random_vacancy_id() as vacancy_id,
-- 		(select array_agg((random()*100000)::int)--random_cv_id())
-- 			from generate_series(1, (1 +(random()*10)+i%10)::int)) as cv_ids
        (random()*100000)::int as cv_id,
	    now()-(random() * 365 * 24 * 3600 * 5) * '1 second'::interval AS reply_time

FROM generate_series(1, 50000) AS g(i);


