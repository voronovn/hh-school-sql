

CREATE TABLE users(
	user_id serial PRIMARY KEY,
	photo_id integer,
	last_name varchar(200) NOT NULL,
	first_name varchar(200) NOT NULL,
	middle_name varchar(200),
	birth_date date,
	gender_id integer,
	area_id integer NOT NULL,
	has_vehicle boolean DEFAULT false,
	driver_license_types varchar(5)[],
	citizenship_ids integer[],
	work_ticket_ids integer[]
);

CREATE TABLE specializations(
	specialization_id serial PRIMARY KEY,
	name varchar(200) NOT NULL,
	laboring boolean DEFAULT false NOT NULL,
	root_specialization integer NOT NULL
);
CREATE TABLE users_cv (
	cv_id serial PRIMARY KEY,
	creation_time timestamp NOT NULL,

	user_id integer not null, --REFERENCES users,

	relocation_id integer[] DEFAULT NULL,
	business_trip_readiness_id integer,
	contact_ids integer[],
	portfolio_ids integer[],
	site_ids integer[],
	
	title varchar(150) NOT NULL,
	specialization_ids integer[],
	salary bigint DEFAULT 0,
	employments_ids integer[] NOT NULL,
	schedules_ids integer[] NOT NULL,
	education_ids integer[] NOT NULL,
	language_ids integer[] NOT NULL,
	experience_ids integer[] NOT NULL,
	skills text,
	skill_set integer[] NOT NULL,

	travel_time integer DEFAULT 0,
	recommendation_ids integer[],
	resume_locale integer,
	certificate_ids integer[],

	
	access_id integer DEFAULT 0 NOT NULL,
	CONSTRAINT access_validate CHECK ((access_id = ANY (ARRAY[0, 1, 2, 3, 4]))),
	is_finished boolean DEFAULT false NOT NULL,
	is_blocked boolean DEFAULT false NOT NULL,
	cv_status_id integer
);
CREATE TABLE vacancy_body (
    vacancy_body_id serial PRIMARY KEY,
    company_name varchar(150) DEFAULT ''::varchar NOT NULL,
    name varchar(220) DEFAULT ''::varchar NOT NULL,
    text text,
    area_id integer,
    address_id integer,
    work_experience integer DEFAULT 0 NOT NULL,
    compensation_from bigint DEFAULT 0,
    compensation_to bigint DEFAULT 0,
    test_solution_required boolean DEFAULT false NOT NULL,
    work_schedule_type integer DEFAULT 0 NOT NULL,
    employment_type integer DEFAULT 0 NOT NULL,
    compensation_gross boolean,
    CONSTRAINT vacancy_body_work_employment_type_validate CHECK ((employment_type = ANY (ARRAY[0, 1, 2, 3, 4]))),
    CONSTRAINT vacancy_body_work_schedule_type_validate CHECK ((work_schedule_type = ANY (ARRAY[0, 1, 2, 3, 4])))
);

CREATE TABLE vacancy (
    vacancy_id serial PRIMARY KEY,
    creation_time timestamp NOT NULL,
    expire_time timestamp NOT NULL,
    employer_id integer DEFAULT 0 NOT NULL,    
    disabled boolean DEFAULT false NOT NULL,
    visible boolean DEFAULT true NOT NULL,
    vacancy_body_id integer,-- REFERENCES vacancy_body,
    area_id integer
);

CREATE TABLE vacancy_body_specialization (
    vacancy_body_specialization_id serial PRIMARY KEY,
    vacancy_body_id integer,-- REFERENCES vacancy_body,
    specialization_id integer REFERENCES specializations
);

CREATE TABLE replies(
	vacancy_id integer, --REFERENCES vacancy,
	cv_id integer,
	reply_time timestamp NOT NULL

);