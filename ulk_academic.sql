--
-- PostgreSQL database dump
--

\restrict UCxsktsgaO2VcYJnXHCs4BtPGtF7SSbQ6SZwNQHOxcdaFzknjPudZwxDEyyrCEM

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: address_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.address_type AS (
	street character varying(100),
	city character varying(50),
	country character varying(50)
);


ALTER TYPE public.address_type OWNER TO postgres;

--
-- Name: contact_info; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.contact_info AS (
	email character varying(100),
	phones text[]
);


ALTER TYPE public.contact_info OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: academic_event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.academic_event (
    event_id integer NOT NULL,
    event_name character varying(200),
    event_date date,
    location character varying(100),
    organizer_id integer
);


ALTER TABLE public.academic_event OWNER TO postgres;

--
-- Name: academic_event_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.academic_event_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.academic_event_event_id_seq OWNER TO postgres;

--
-- Name: academic_event_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.academic_event_event_id_seq OWNED BY public.academic_event.event_id;


--
-- Name: academic_space; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.academic_space (
    space_id integer NOT NULL,
    space_name character varying(100),
    capacity integer,
    space_type character varying(20)
);


ALTER TABLE public.academic_space OWNER TO postgres;

--
-- Name: academic_space_space_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.academic_space_space_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.academic_space_space_id_seq OWNER TO postgres;

--
-- Name: academic_space_space_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.academic_space_space_id_seq OWNED BY public.academic_space.space_id;


--
-- Name: attendance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attendance (
    attendance_id integer NOT NULL,
    schedule_id integer,
    student_id integer,
    attended_on date,
    status character varying(10)
);


ALTER TABLE public.attendance OWNER TO postgres;

--
-- Name: attendance_attendance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.attendance_attendance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.attendance_attendance_id_seq OWNER TO postgres;

--
-- Name: attendance_attendance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.attendance_attendance_id_seq OWNED BY public.attendance.attendance_id;


--
-- Name: course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course (
    course_id integer NOT NULL,
    course_code character varying(20) NOT NULL,
    course_name character varying(100) NOT NULL,
    credits integer,
    dept_id integer
);


ALTER TABLE public.course OWNER TO postgres;

--
-- Name: course_course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.course_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.course_course_id_seq OWNER TO postgres;

--
-- Name: course_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.course_course_id_seq OWNED BY public.course.course_id;


--
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    dept_id integer NOT NULL,
    dept_name character varying(100) NOT NULL,
    faculty_id integer
);


ALTER TABLE public.department OWNER TO postgres;

--
-- Name: department_dept_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.department_dept_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.department_dept_id_seq OWNER TO postgres;

--
-- Name: department_dept_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.department_dept_id_seq OWNED BY public.department.dept_id;


--
-- Name: enrollment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enrollment (
    enrollment_id integer NOT NULL,
    student_id integer,
    course_id integer,
    semester character varying(20),
    academic_year character varying(10),
    grade numeric(4,1),
    enrolled_on date DEFAULT CURRENT_DATE
);


ALTER TABLE public.enrollment OWNER TO postgres;

--
-- Name: enrollment_enrollment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enrollment_enrollment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.enrollment_enrollment_id_seq OWNER TO postgres;

--
-- Name: enrollment_enrollment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enrollment_enrollment_id_seq OWNED BY public.enrollment.enrollment_id;


--
-- Name: event_participant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_participant (
    participant_id integer NOT NULL,
    event_id integer,
    person_id integer,
    participant_type character varying(20),
    role character varying(50)
);


ALTER TABLE public.event_participant OWNER TO postgres;

--
-- Name: event_participant_participant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_participant_participant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.event_participant_participant_id_seq OWNER TO postgres;

--
-- Name: event_participant_participant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_participant_participant_id_seq OWNED BY public.event_participant.participant_id;


--
-- Name: faculty; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faculty (
    faculty_id integer NOT NULL,
    faculty_name character varying(100) NOT NULL,
    dean_name character varying(100)
);


ALTER TABLE public.faculty OWNER TO postgres;

--
-- Name: faculty_faculty_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.faculty_faculty_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.faculty_faculty_id_seq OWNER TO postgres;

--
-- Name: faculty_faculty_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faculty_faculty_id_seq OWNED BY public.faculty.faculty_id;


--
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    person_id integer NOT NULL,
    full_name character varying(100) NOT NULL,
    dob date,
    gender character(1),
    address public.address_type,
    contact public.contact_info,
    person_type character varying(20)
);


ALTER TABLE public.person OWNER TO postgres;

--
-- Name: person_person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.person_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.person_person_id_seq OWNER TO postgres;

--
-- Name: person_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.person_person_id_seq OWNED BY public.person.person_id;


--
-- Name: lecturer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lecturer (
    person_id integer DEFAULT nextval('public.person_person_id_seq'::regclass) NOT NULL,
    staff_id character varying(20) NOT NULL,
    dept_id integer,
    rank character varying(50),
    specialization character varying(100)
)
INHERITS (public.person);


ALTER TABLE public.lecturer OWNER TO postgres;

--
-- Name: research_project; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.research_project (
    project_id integer NOT NULL,
    title character varying(200),
    description text,
    start_date date,
    end_date date,
    metadata jsonb
);


ALTER TABLE public.research_project OWNER TO postgres;

--
-- Name: research_project_project_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.research_project_project_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.research_project_project_id_seq OWNER TO postgres;

--
-- Name: research_project_project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.research_project_project_id_seq OWNED BY public.research_project.project_id;


--
-- Name: resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource (
    resource_id integer NOT NULL,
    resource_name character varying(100),
    resource_type character varying(50),
    dept_id integer,
    quantity integer,
    condition character varying(20)
);


ALTER TABLE public.resource OWNER TO postgres;

--
-- Name: resource_resource_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.resource_resource_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.resource_resource_id_seq OWNER TO postgres;

--
-- Name: resource_resource_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.resource_resource_id_seq OWNED BY public.resource.resource_id;


--
-- Name: schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schedule (
    schedule_id integer NOT NULL,
    course_id integer,
    space_id integer,
    lecturer_id integer,
    day_of_week character varying(10),
    start_time time without time zone,
    end_time time without time zone
);


ALTER TABLE public.schedule OWNER TO postgres;

--
-- Name: schedule_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schedule_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.schedule_schedule_id_seq OWNER TO postgres;

--
-- Name: schedule_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schedule_schedule_id_seq OWNED BY public.schedule.schedule_id;


--
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student (
    person_id integer DEFAULT nextval('public.person_person_id_seq'::regclass) NOT NULL,
    reg_number character varying(20) NOT NULL,
    dept_id integer,
    year_of_study integer,
    gpa numeric(3,2)
)
INHERITS (public.person);


ALTER TABLE public.student OWNER TO postgres;

--
-- Name: supervision; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.supervision (
    supervision_id integer NOT NULL,
    lecturer_id integer,
    student_id integer,
    project_id integer,
    start_date date,
    role character varying(50)
);


ALTER TABLE public.supervision OWNER TO postgres;

--
-- Name: supervision_supervision_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.supervision_supervision_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.supervision_supervision_id_seq OWNER TO postgres;

--
-- Name: supervision_supervision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.supervision_supervision_id_seq OWNED BY public.supervision.supervision_id;


--
-- Name: academic_event event_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.academic_event ALTER COLUMN event_id SET DEFAULT nextval('public.academic_event_event_id_seq'::regclass);


--
-- Name: academic_space space_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.academic_space ALTER COLUMN space_id SET DEFAULT nextval('public.academic_space_space_id_seq'::regclass);


--
-- Name: attendance attendance_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance ALTER COLUMN attendance_id SET DEFAULT nextval('public.attendance_attendance_id_seq'::regclass);


--
-- Name: course course_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course ALTER COLUMN course_id SET DEFAULT nextval('public.course_course_id_seq'::regclass);


--
-- Name: department dept_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department ALTER COLUMN dept_id SET DEFAULT nextval('public.department_dept_id_seq'::regclass);


--
-- Name: enrollment enrollment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment ALTER COLUMN enrollment_id SET DEFAULT nextval('public.enrollment_enrollment_id_seq'::regclass);


--
-- Name: event_participant participant_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_participant ALTER COLUMN participant_id SET DEFAULT nextval('public.event_participant_participant_id_seq'::regclass);


--
-- Name: faculty faculty_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty ALTER COLUMN faculty_id SET DEFAULT nextval('public.faculty_faculty_id_seq'::regclass);


--
-- Name: person person_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person ALTER COLUMN person_id SET DEFAULT nextval('public.person_person_id_seq'::regclass);


--
-- Name: research_project project_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_project ALTER COLUMN project_id SET DEFAULT nextval('public.research_project_project_id_seq'::regclass);


--
-- Name: resource resource_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource ALTER COLUMN resource_id SET DEFAULT nextval('public.resource_resource_id_seq'::regclass);


--
-- Name: schedule schedule_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule ALTER COLUMN schedule_id SET DEFAULT nextval('public.schedule_schedule_id_seq'::regclass);


--
-- Name: supervision supervision_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supervision ALTER COLUMN supervision_id SET DEFAULT nextval('public.supervision_supervision_id_seq'::regclass);


--
-- Data for Name: academic_event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.academic_event (event_id, event_name, event_date, location, organizer_id) FROM stdin;
1	Annual Science Fair	2024-01-31	Main Campus	4
2	Tech Innovation Summit	2024-03-01	Main Campus	4
3	Business Case Competition	2024-03-31	Main Campus	4
4	Research Symposium	2024-04-30	Main Campus	4
5	Graduation Ceremony	2024-05-30	Main Campus	4
6	Open Day 2024	2024-06-29	Main Campus	4
7	Sports Gala	2024-07-29	Main Campus	4
8	Cultural Night	2024-08-28	Main Campus	4
9	Career Fair	2024-09-27	Main Campus	4
10	Debate Championship	2024-10-27	Main Campus	4
\.


--
-- Data for Name: academic_space; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.academic_space (space_id, space_name, capacity, space_type) FROM stdin;
1	Room A1	50	classroom
2	Room A2	60	classroom
3	Room B1	40	classroom
4	Room B2	80	classroom
5	Lab CS1	30	laboratory
6	Lab CS2	30	laboratory
7	Lab IS1	25	laboratory
8	Science Lab	20	laboratory
9	Hall 1	200	classroom
10	Seminar Room	20	classroom
\.


--
-- Data for Name: attendance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attendance (attendance_id, schedule_id, student_id, attended_on, status) FROM stdin;
1	30	21	2026-06-16	present
2	29	21	2026-06-16	present
3	20	21	2026-06-16	present
4	19	21	2026-06-16	present
5	18	21	2026-06-16	present
6	17	21	2026-06-16	present
7	12	21	2026-06-16	present
8	11	21	2026-06-16	present
9	10	21	2026-06-16	present
10	9	21	2026-06-16	present
11	8	21	2026-06-16	present
12	7	21	2026-06-16	present
13	6	21	2026-06-16	present
14	5	21	2026-06-16	present
15	4	22	2026-06-16	present
16	3	22	2026-06-16	present
17	2	22	2026-06-16	present
18	1	22	2026-06-16	present
19	8	22	2026-06-16	present
20	7	22	2026-06-16	present
21	6	22	2026-06-16	present
22	5	22	2026-06-16	present
23	30	22	2026-06-16	present
24	29	22	2026-06-16	present
25	24	22	2026-06-16	present
26	23	22	2026-06-16	present
27	22	22	2026-06-16	present
28	21	22	2026-06-16	present
29	4	23	2026-06-16	present
30	3	23	2026-06-16	present
31	2	23	2026-06-16	present
32	1	23	2026-06-16	present
33	12	23	2026-06-16	present
34	11	23	2026-06-16	present
35	10	23	2026-06-16	present
36	9	23	2026-06-16	present
37	16	23	2026-06-16	present
38	15	23	2026-06-16	present
39	14	23	2026-06-16	present
40	13	23	2026-06-16	present
41	30	23	2026-06-16	present
42	29	23	2026-06-16	present
43	4	31	2026-06-16	present
44	3	31	2026-06-16	present
45	2	31	2026-06-16	present
46	1	31	2026-06-16	present
47	20	31	2026-06-16	present
48	19	31	2026-06-16	present
49	18	31	2026-06-16	present
50	17	31	2026-06-16	present
\.


--
-- Data for Name: course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course (course_id, course_code, course_name, credits, dept_id) FROM stdin;
1	CS101	Introduction to Programming	3	1
2	CS102	Data Structures	3	1
3	CS201	Database Systems	4	1
4	CS202	Operating Systems	3	1
5	CS301	Artificial Intelligence	4	1
6	CS302	Software Engineering	3	1
7	CS401	Machine Learning	4	1
8	CS402	Computer Networks	3	1
9	IS101	Information Systems Fundamentals	3	2
10	IS102	Systems Analysis & Design	3	2
11	IS201	Cloud Computing	4	2
12	IS202	Cybersecurity Fundamentals	3	2
13	IS301	Data Mining	4	2
14	IS302	IT Project Management	3	2
15	IS401	Big Data Analytics	4	2
16	BA101	Principles of Management	3	3
17	BA102	Business Communication	3	3
18	BA201	Marketing Management	3	3
19	BA202	Organizational Behavior	3	3
20	BA301	Strategic Management	4	3
21	BA302	Human Resource Management	3	3
22	AC101	Financial Accounting	3	4
23	AC102	Cost Accounting	3	4
24	AC201	Auditing	4	4
25	AC202	Taxation	3	4
26	AC301	Corporate Finance	4	4
27	ED101	Introduction to Education	3	5
28	ED102	Curriculum Development	3	5
29	ED201	Educational Psychology	3	5
30	ED202	Assessment & Evaluation	3	5
\.


--
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.department (dept_id, dept_name, faculty_id) FROM stdin;
1	Computer Science	1
2	Information Systems	1
3	Business Administration	2
4	Accounting	2
5	Education Sciences	3
\.


--
-- Data for Name: enrollment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enrollment (enrollment_id, student_id, course_id, semester, academic_year, grade, enrolled_on) FROM stdin;
1	21	8	Semester 1	2024/2025	94.1	2026-06-16
2	21	5	Semester 1	2024/2025	85.7	2026-06-16
3	21	3	Semester 2	2024/2025	56.3	2026-06-16
4	21	2	Semester 2	2024/2025	97.2	2026-06-16
5	22	1	Semester 2	2024/2025	93.3	2026-06-16
6	22	2	Semester 2	2024/2025	78.1	2026-06-16
7	22	8	Semester 1	2024/2025	92.5	2026-06-16
8	22	6	Semester 2	2024/2025	93.5	2026-06-16
9	23	1	Semester 1	2024/2025	90.0	2026-06-16
10	23	3	Semester 2	2024/2025	89.0	2026-06-16
11	23	4	Semester 2	2024/2025	84.0	2026-06-16
12	23	8	Semester 1	2024/2025	89.6	2026-06-16
13	24	10	Semester 2	2024/2025	82.3	2026-06-16
14	24	12	Semester 1	2024/2025	57.5	2026-06-16
15	24	13	Semester 1	2024/2025	89.8	2026-06-16
16	24	14	Semester 1	2024/2025	61.8	2026-06-16
17	25	12	Semester 2	2024/2025	54.3	2026-06-16
18	25	15	Semester 1	2024/2025	97.6	2026-06-16
19	25	11	Semester 1	2024/2025	66.0	2026-06-16
20	25	10	Semester 1	2024/2025	80.9	2026-06-16
21	26	21	Semester 1	2024/2025	97.9	2026-06-16
22	26	18	Semester 1	2024/2025	53.6	2026-06-16
23	26	17	Semester 2	2024/2025	99.5	2026-06-16
24	26	19	Semester 1	2024/2025	69.0	2026-06-16
25	27	19	Semester 2	2024/2025	95.0	2026-06-16
26	27	21	Semester 1	2024/2025	84.0	2026-06-16
27	27	20	Semester 1	2024/2025	78.5	2026-06-16
28	27	17	Semester 2	2024/2025	53.1	2026-06-16
29	28	22	Semester 1	2024/2025	78.4	2026-06-16
30	28	25	Semester 2	2024/2025	83.8	2026-06-16
31	28	23	Semester 1	2024/2025	65.2	2026-06-16
32	28	24	Semester 2	2024/2025	50.4	2026-06-16
33	29	22	Semester 1	2024/2025	91.2	2026-06-16
34	29	25	Semester 2	2024/2025	89.6	2026-06-16
35	29	23	Semester 1	2024/2025	76.1	2026-06-16
36	29	26	Semester 1	2024/2025	70.7	2026-06-16
37	30	27	Semester 1	2024/2025	66.2	2026-06-16
38	30	29	Semester 1	2024/2025	96.1	2026-06-16
39	30	30	Semester 2	2024/2025	60.2	2026-06-16
40	30	28	Semester 1	2024/2025	76.4	2026-06-16
41	31	1	Semester 2	2024/2025	54.3	2026-06-16
42	31	5	Semester 1	2024/2025	50.0	2026-06-16
43	31	4	Semester 1	2024/2025	78.2	2026-06-16
44	31	8	Semester 1	2024/2025	63.6	2026-06-16
45	32	2	Semester 2	2024/2025	84.2	2026-06-16
46	32	5	Semester 1	2024/2025	51.5	2026-06-16
47	32	3	Semester 1	2024/2025	78.3	2026-06-16
48	32	6	Semester 2	2024/2025	87.8	2026-06-16
49	33	4	Semester 2	2024/2025	93.0	2026-06-16
50	33	2	Semester 2	2024/2025	77.9	2026-06-16
51	33	6	Semester 2	2024/2025	68.2	2026-06-16
52	33	5	Semester 1	2024/2025	73.2	2026-06-16
53	34	11	Semester 2	2024/2025	86.8	2026-06-16
54	34	13	Semester 1	2024/2025	59.6	2026-06-16
55	34	14	Semester 2	2024/2025	70.6	2026-06-16
56	34	10	Semester 2	2024/2025	96.7	2026-06-16
57	35	15	Semester 2	2024/2025	57.0	2026-06-16
58	35	10	Semester 2	2024/2025	96.2	2026-06-16
59	35	11	Semester 2	2024/2025	57.9	2026-06-16
60	35	13	Semester 1	2024/2025	64.0	2026-06-16
61	36	20	Semester 1	2024/2025	60.6	2026-06-16
62	36	19	Semester 2	2024/2025	81.4	2026-06-16
63	36	17	Semester 1	2024/2025	76.4	2026-06-16
64	36	21	Semester 2	2024/2025	67.3	2026-06-16
65	37	19	Semester 2	2024/2025	73.1	2026-06-16
66	37	18	Semester 2	2024/2025	69.2	2026-06-16
67	37	20	Semester 2	2024/2025	54.8	2026-06-16
68	37	21	Semester 1	2024/2025	75.3	2026-06-16
69	38	26	Semester 1	2024/2025	94.0	2026-06-16
70	38	22	Semester 2	2024/2025	96.2	2026-06-16
71	38	24	Semester 1	2024/2025	68.9	2026-06-16
72	38	25	Semester 2	2024/2025	65.0	2026-06-16
73	39	22	Semester 1	2024/2025	55.1	2026-06-16
74	39	24	Semester 1	2024/2025	50.4	2026-06-16
75	39	25	Semester 2	2024/2025	70.0	2026-06-16
76	39	23	Semester 2	2024/2025	80.7	2026-06-16
77	40	27	Semester 1	2024/2025	77.4	2026-06-16
78	40	28	Semester 2	2024/2025	62.8	2026-06-16
79	40	29	Semester 2	2024/2025	75.0	2026-06-16
80	40	30	Semester 2	2024/2025	60.9	2026-06-16
81	41	4	Semester 1	2024/2025	88.1	2026-06-16
82	41	7	Semester 1	2024/2025	70.3	2026-06-16
83	41	5	Semester 1	2024/2025	99.0	2026-06-16
84	41	3	Semester 2	2024/2025	92.1	2026-06-16
85	42	8	Semester 2	2024/2025	63.0	2026-06-16
86	42	6	Semester 1	2024/2025	54.5	2026-06-16
87	42	7	Semester 2	2024/2025	88.5	2026-06-16
88	42	3	Semester 2	2024/2025	76.3	2026-06-16
89	43	3	Semester 2	2024/2025	53.6	2026-06-16
90	43	7	Semester 2	2024/2025	66.7	2026-06-16
91	43	8	Semester 1	2024/2025	90.2	2026-06-16
92	43	1	Semester 1	2024/2025	94.7	2026-06-16
93	44	14	Semester 1	2024/2025	86.8	2026-06-16
94	44	10	Semester 1	2024/2025	87.0	2026-06-16
95	44	13	Semester 1	2024/2025	63.7	2026-06-16
96	44	9	Semester 1	2024/2025	72.5	2026-06-16
97	45	10	Semester 1	2024/2025	76.2	2026-06-16
98	45	13	Semester 2	2024/2025	89.8	2026-06-16
99	45	9	Semester 1	2024/2025	77.5	2026-06-16
100	45	14	Semester 1	2024/2025	62.2	2026-06-16
101	46	19	Semester 1	2024/2025	72.9	2026-06-16
102	46	20	Semester 1	2024/2025	84.4	2026-06-16
103	46	16	Semester 1	2024/2025	62.3	2026-06-16
104	46	21	Semester 1	2024/2025	73.3	2026-06-16
105	47	21	Semester 2	2024/2025	67.0	2026-06-16
106	47	18	Semester 2	2024/2025	79.1	2026-06-16
107	47	16	Semester 2	2024/2025	56.1	2026-06-16
108	47	20	Semester 2	2024/2025	57.2	2026-06-16
109	48	24	Semester 1	2024/2025	52.0	2026-06-16
110	48	22	Semester 2	2024/2025	55.5	2026-06-16
111	48	25	Semester 2	2024/2025	77.4	2026-06-16
112	48	23	Semester 1	2024/2025	98.6	2026-06-16
113	49	24	Semester 2	2024/2025	58.1	2026-06-16
114	49	25	Semester 1	2024/2025	61.1	2026-06-16
115	49	26	Semester 1	2024/2025	54.5	2026-06-16
116	49	23	Semester 1	2024/2025	69.0	2026-06-16
117	50	30	Semester 1	2024/2025	62.0	2026-06-16
118	50	27	Semester 1	2024/2025	59.7	2026-06-16
119	50	29	Semester 2	2024/2025	58.0	2026-06-16
120	50	28	Semester 2	2024/2025	70.4	2026-06-16
121	51	3	Semester 1	2024/2025	67.4	2026-06-16
122	51	5	Semester 2	2024/2025	55.7	2026-06-16
123	51	4	Semester 1	2024/2025	93.1	2026-06-16
124	51	2	Semester 2	2024/2025	80.6	2026-06-16
125	52	4	Semester 2	2024/2025	71.9	2026-06-16
126	52	6	Semester 1	2024/2025	89.1	2026-06-16
127	52	5	Semester 2	2024/2025	54.6	2026-06-16
128	52	1	Semester 1	2024/2025	65.1	2026-06-16
129	53	4	Semester 2	2024/2025	95.3	2026-06-16
130	53	6	Semester 2	2024/2025	68.2	2026-06-16
131	53	3	Semester 1	2024/2025	68.5	2026-06-16
132	53	8	Semester 2	2024/2025	89.6	2026-06-16
133	54	14	Semester 1	2024/2025	68.5	2026-06-16
134	54	12	Semester 2	2024/2025	70.5	2026-06-16
135	54	13	Semester 2	2024/2025	71.5	2026-06-16
136	54	10	Semester 2	2024/2025	75.6	2026-06-16
137	55	11	Semester 2	2024/2025	89.6	2026-06-16
138	55	10	Semester 2	2024/2025	62.4	2026-06-16
139	55	12	Semester 1	2024/2025	67.3	2026-06-16
140	55	9	Semester 2	2024/2025	80.1	2026-06-16
141	56	18	Semester 2	2024/2025	57.7	2026-06-16
142	56	17	Semester 2	2024/2025	78.5	2026-06-16
143	56	16	Semester 2	2024/2025	51.1	2026-06-16
144	56	19	Semester 1	2024/2025	96.7	2026-06-16
145	57	17	Semester 2	2024/2025	52.6	2026-06-16
146	57	20	Semester 2	2024/2025	64.3	2026-06-16
147	57	18	Semester 1	2024/2025	92.8	2026-06-16
148	57	21	Semester 2	2024/2025	90.9	2026-06-16
149	58	24	Semester 2	2024/2025	75.0	2026-06-16
150	58	26	Semester 2	2024/2025	86.3	2026-06-16
151	58	23	Semester 2	2024/2025	91.6	2026-06-16
152	58	22	Semester 1	2024/2025	72.8	2026-06-16
153	59	26	Semester 1	2024/2025	90.5	2026-06-16
154	59	24	Semester 1	2024/2025	69.4	2026-06-16
155	59	22	Semester 1	2024/2025	70.8	2026-06-16
156	59	25	Semester 1	2024/2025	69.2	2026-06-16
157	60	28	Semester 2	2024/2025	52.8	2026-06-16
158	60	27	Semester 1	2024/2025	78.8	2026-06-16
159	60	30	Semester 2	2024/2025	66.0	2026-06-16
160	60	29	Semester 2	2024/2025	68.8	2026-06-16
161	61	8	Semester 2	2024/2025	51.2	2026-06-16
162	61	6	Semester 1	2024/2025	50.6	2026-06-16
163	61	4	Semester 1	2024/2025	62.6	2026-06-16
164	61	5	Semester 1	2024/2025	56.4	2026-06-16
165	62	7	Semester 1	2024/2025	62.5	2026-06-16
166	62	6	Semester 2	2024/2025	53.5	2026-06-16
167	62	3	Semester 1	2024/2025	74.0	2026-06-16
168	62	4	Semester 1	2024/2025	73.2	2026-06-16
169	63	6	Semester 2	2024/2025	68.9	2026-06-16
170	63	2	Semester 2	2024/2025	56.5	2026-06-16
171	63	3	Semester 2	2024/2025	71.8	2026-06-16
172	63	8	Semester 2	2024/2025	77.2	2026-06-16
173	64	9	Semester 1	2024/2025	98.8	2026-06-16
174	64	15	Semester 1	2024/2025	53.3	2026-06-16
175	64	13	Semester 1	2024/2025	97.7	2026-06-16
176	64	10	Semester 2	2024/2025	62.5	2026-06-16
177	65	9	Semester 2	2024/2025	88.3	2026-06-16
178	65	10	Semester 2	2024/2025	56.9	2026-06-16
179	65	14	Semester 2	2024/2025	54.3	2026-06-16
180	65	12	Semester 1	2024/2025	56.1	2026-06-16
181	66	17	Semester 1	2024/2025	62.0	2026-06-16
182	66	21	Semester 1	2024/2025	74.3	2026-06-16
183	66	16	Semester 2	2024/2025	72.2	2026-06-16
184	66	19	Semester 1	2024/2025	94.3	2026-06-16
185	67	20	Semester 1	2024/2025	97.5	2026-06-16
186	67	21	Semester 1	2024/2025	80.3	2026-06-16
187	67	16	Semester 2	2024/2025	88.5	2026-06-16
188	67	19	Semester 2	2024/2025	80.3	2026-06-16
189	68	26	Semester 2	2024/2025	66.2	2026-06-16
190	68	23	Semester 2	2024/2025	81.1	2026-06-16
191	68	24	Semester 2	2024/2025	78.1	2026-06-16
192	68	25	Semester 2	2024/2025	79.5	2026-06-16
193	69	24	Semester 2	2024/2025	56.0	2026-06-16
194	69	26	Semester 1	2024/2025	94.8	2026-06-16
195	69	23	Semester 2	2024/2025	50.7	2026-06-16
196	69	25	Semester 2	2024/2025	92.4	2026-06-16
197	70	28	Semester 1	2024/2025	76.9	2026-06-16
198	70	30	Semester 2	2024/2025	63.3	2026-06-16
199	70	27	Semester 2	2024/2025	99.1	2026-06-16
200	70	29	Semester 2	2024/2025	63.4	2026-06-16
201	71	1	Semester 2	2024/2025	92.2	2026-06-16
202	71	2	Semester 2	2024/2025	93.2	2026-06-16
203	71	7	Semester 2	2024/2025	98.7	2026-06-16
204	71	4	Semester 1	2024/2025	83.2	2026-06-16
205	72	3	Semester 2	2024/2025	75.2	2026-06-16
206	72	7	Semester 1	2024/2025	93.4	2026-06-16
207	72	8	Semester 1	2024/2025	98.1	2026-06-16
208	72	4	Semester 2	2024/2025	58.1	2026-06-16
209	73	5	Semester 2	2024/2025	79.4	2026-06-16
210	73	8	Semester 2	2024/2025	56.8	2026-06-16
211	73	2	Semester 1	2024/2025	54.0	2026-06-16
212	73	3	Semester 1	2024/2025	65.6	2026-06-16
213	74	13	Semester 1	2024/2025	51.7	2026-06-16
214	74	12	Semester 1	2024/2025	59.3	2026-06-16
215	74	9	Semester 2	2024/2025	92.3	2026-06-16
216	74	11	Semester 1	2024/2025	76.1	2026-06-16
217	75	13	Semester 1	2024/2025	55.1	2026-06-16
218	75	9	Semester 2	2024/2025	89.6	2026-06-16
219	75	11	Semester 2	2024/2025	66.6	2026-06-16
220	75	14	Semester 1	2024/2025	83.5	2026-06-16
221	76	19	Semester 1	2024/2025	64.2	2026-06-16
222	76	21	Semester 1	2024/2025	99.9	2026-06-16
223	76	20	Semester 2	2024/2025	97.7	2026-06-16
224	76	17	Semester 2	2024/2025	91.9	2026-06-16
225	77	17	Semester 2	2024/2025	96.2	2026-06-16
226	77	19	Semester 1	2024/2025	61.5	2026-06-16
227	77	18	Semester 2	2024/2025	76.0	2026-06-16
228	77	16	Semester 1	2024/2025	53.5	2026-06-16
229	78	26	Semester 1	2024/2025	71.5	2026-06-16
230	78	25	Semester 2	2024/2025	84.0	2026-06-16
231	78	23	Semester 1	2024/2025	53.0	2026-06-16
232	78	22	Semester 2	2024/2025	59.6	2026-06-16
233	79	22	Semester 2	2024/2025	71.9	2026-06-16
234	79	26	Semester 2	2024/2025	97.8	2026-06-16
235	79	25	Semester 2	2024/2025	64.2	2026-06-16
236	79	24	Semester 1	2024/2025	64.0	2026-06-16
237	80	28	Semester 2	2024/2025	69.8	2026-06-16
238	80	29	Semester 2	2024/2025	66.6	2026-06-16
239	80	27	Semester 1	2024/2025	66.4	2026-06-16
240	80	30	Semester 2	2024/2025	56.8	2026-06-16
241	81	5	Semester 2	2024/2025	96.9	2026-06-16
242	81	6	Semester 1	2024/2025	50.6	2026-06-16
243	81	8	Semester 2	2024/2025	94.5	2026-06-16
244	81	4	Semester 2	2024/2025	50.2	2026-06-16
245	82	1	Semester 1	2024/2025	96.9	2026-06-16
246	82	5	Semester 1	2024/2025	74.9	2026-06-16
247	82	6	Semester 1	2024/2025	75.7	2026-06-16
248	82	3	Semester 2	2024/2025	88.2	2026-06-16
249	83	4	Semester 1	2024/2025	79.5	2026-06-16
250	83	5	Semester 1	2024/2025	74.5	2026-06-16
251	83	3	Semester 1	2024/2025	71.6	2026-06-16
252	83	1	Semester 1	2024/2025	69.2	2026-06-16
253	84	11	Semester 2	2024/2025	95.8	2026-06-16
254	84	10	Semester 1	2024/2025	97.4	2026-06-16
255	84	9	Semester 2	2024/2025	70.9	2026-06-16
256	84	15	Semester 1	2024/2025	54.4	2026-06-16
257	85	13	Semester 1	2024/2025	78.7	2026-06-16
258	85	10	Semester 1	2024/2025	83.0	2026-06-16
259	85	12	Semester 2	2024/2025	99.7	2026-06-16
260	85	11	Semester 2	2024/2025	90.1	2026-06-16
261	86	16	Semester 1	2024/2025	53.8	2026-06-16
262	86	19	Semester 2	2024/2025	77.0	2026-06-16
263	86	21	Semester 1	2024/2025	51.4	2026-06-16
264	86	18	Semester 1	2024/2025	53.2	2026-06-16
265	87	20	Semester 2	2024/2025	67.8	2026-06-16
266	87	18	Semester 2	2024/2025	83.9	2026-06-16
267	87	16	Semester 2	2024/2025	73.0	2026-06-16
268	87	21	Semester 1	2024/2025	68.8	2026-06-16
269	88	25	Semester 1	2024/2025	70.9	2026-06-16
270	88	22	Semester 1	2024/2025	88.7	2026-06-16
271	88	24	Semester 1	2024/2025	93.6	2026-06-16
272	88	26	Semester 1	2024/2025	75.2	2026-06-16
273	89	22	Semester 1	2024/2025	74.7	2026-06-16
274	89	25	Semester 1	2024/2025	85.8	2026-06-16
275	89	23	Semester 1	2024/2025	95.1	2026-06-16
276	89	26	Semester 1	2024/2025	91.3	2026-06-16
277	90	30	Semester 2	2024/2025	54.7	2026-06-16
278	90	27	Semester 1	2024/2025	84.4	2026-06-16
279	90	29	Semester 2	2024/2025	59.5	2026-06-16
280	90	28	Semester 2	2024/2025	82.5	2026-06-16
281	91	5	Semester 2	2024/2025	80.3	2026-06-16
282	91	8	Semester 2	2024/2025	73.0	2026-06-16
283	91	4	Semester 2	2024/2025	89.5	2026-06-16
284	91	2	Semester 1	2024/2025	99.5	2026-06-16
285	92	2	Semester 1	2024/2025	94.5	2026-06-16
286	92	4	Semester 2	2024/2025	88.8	2026-06-16
287	92	8	Semester 2	2024/2025	78.9	2026-06-16
288	92	6	Semester 1	2024/2025	65.2	2026-06-16
289	93	7	Semester 1	2024/2025	82.9	2026-06-16
290	93	1	Semester 2	2024/2025	56.3	2026-06-16
291	93	5	Semester 2	2024/2025	81.0	2026-06-16
292	93	6	Semester 1	2024/2025	61.6	2026-06-16
293	94	14	Semester 1	2024/2025	86.1	2026-06-16
294	94	13	Semester 2	2024/2025	73.1	2026-06-16
295	94	12	Semester 1	2024/2025	76.6	2026-06-16
296	94	9	Semester 1	2024/2025	98.2	2026-06-16
297	95	15	Semester 2	2024/2025	84.0	2026-06-16
298	95	13	Semester 1	2024/2025	97.1	2026-06-16
299	95	9	Semester 2	2024/2025	88.6	2026-06-16
300	95	11	Semester 1	2024/2025	97.9	2026-06-16
301	96	18	Semester 1	2024/2025	66.8	2026-06-16
302	96	21	Semester 2	2024/2025	90.7	2026-06-16
303	96	16	Semester 1	2024/2025	73.2	2026-06-16
304	96	17	Semester 2	2024/2025	71.5	2026-06-16
305	97	19	Semester 2	2024/2025	80.6	2026-06-16
306	97	21	Semester 1	2024/2025	64.6	2026-06-16
307	97	17	Semester 1	2024/2025	83.9	2026-06-16
308	97	18	Semester 2	2024/2025	63.9	2026-06-16
309	98	22	Semester 2	2024/2025	54.5	2026-06-16
310	98	25	Semester 1	2024/2025	64.9	2026-06-16
311	98	26	Semester 1	2024/2025	59.1	2026-06-16
312	98	23	Semester 2	2024/2025	85.2	2026-06-16
313	99	26	Semester 1	2024/2025	66.6	2026-06-16
314	99	24	Semester 1	2024/2025	71.3	2026-06-16
315	99	25	Semester 1	2024/2025	77.2	2026-06-16
316	99	23	Semester 2	2024/2025	59.0	2026-06-16
317	100	29	Semester 1	2024/2025	97.0	2026-06-16
318	100	28	Semester 2	2024/2025	65.9	2026-06-16
319	100	30	Semester 1	2024/2025	53.0	2026-06-16
320	100	27	Semester 2	2024/2025	70.1	2026-06-16
321	101	2	Semester 1	2024/2025	75.1	2026-06-16
322	101	8	Semester 1	2024/2025	68.2	2026-06-16
323	101	3	Semester 1	2024/2025	65.1	2026-06-16
324	101	1	Semester 1	2024/2025	89.5	2026-06-16
325	102	3	Semester 2	2024/2025	98.3	2026-06-16
326	102	2	Semester 1	2024/2025	66.2	2026-06-16
327	102	8	Semester 2	2024/2025	58.9	2026-06-16
328	102	4	Semester 1	2024/2025	67.7	2026-06-16
329	103	8	Semester 2	2024/2025	81.7	2026-06-16
330	103	7	Semester 1	2024/2025	83.0	2026-06-16
331	103	3	Semester 2	2024/2025	52.2	2026-06-16
332	103	6	Semester 1	2024/2025	88.5	2026-06-16
333	104	14	Semester 2	2024/2025	76.1	2026-06-16
334	104	11	Semester 1	2024/2025	72.7	2026-06-16
335	104	13	Semester 2	2024/2025	52.4	2026-06-16
336	104	12	Semester 2	2024/2025	52.4	2026-06-16
337	105	12	Semester 1	2024/2025	70.5	2026-06-16
338	105	11	Semester 1	2024/2025	88.5	2026-06-16
339	105	10	Semester 1	2024/2025	74.4	2026-06-16
340	105	9	Semester 1	2024/2025	79.3	2026-06-16
341	106	18	Semester 2	2024/2025	83.8	2026-06-16
342	106	21	Semester 1	2024/2025	78.1	2026-06-16
343	106	17	Semester 2	2024/2025	79.0	2026-06-16
344	106	19	Semester 2	2024/2025	91.1	2026-06-16
345	107	18	Semester 2	2024/2025	74.0	2026-06-16
346	107	19	Semester 2	2024/2025	96.6	2026-06-16
347	107	16	Semester 1	2024/2025	83.7	2026-06-16
348	107	20	Semester 1	2024/2025	92.4	2026-06-16
349	108	23	Semester 1	2024/2025	89.5	2026-06-16
350	108	26	Semester 2	2024/2025	91.7	2026-06-16
351	108	22	Semester 2	2024/2025	80.4	2026-06-16
352	108	25	Semester 2	2024/2025	88.7	2026-06-16
353	109	25	Semester 2	2024/2025	96.4	2026-06-16
354	109	24	Semester 2	2024/2025	83.1	2026-06-16
355	109	23	Semester 2	2024/2025	76.2	2026-06-16
356	109	22	Semester 1	2024/2025	90.0	2026-06-16
357	110	28	Semester 1	2024/2025	54.8	2026-06-16
358	110	27	Semester 1	2024/2025	81.6	2026-06-16
359	110	30	Semester 2	2024/2025	98.2	2026-06-16
360	110	29	Semester 1	2024/2025	97.5	2026-06-16
361	111	5	Semester 1	2024/2025	65.1	2026-06-16
362	111	8	Semester 1	2024/2025	84.4	2026-06-16
363	111	2	Semester 1	2024/2025	84.1	2026-06-16
364	111	6	Semester 1	2024/2025	67.7	2026-06-16
365	112	3	Semester 2	2024/2025	97.1	2026-06-16
366	112	4	Semester 2	2024/2025	52.8	2026-06-16
367	112	1	Semester 2	2024/2025	87.3	2026-06-16
368	112	6	Semester 2	2024/2025	89.0	2026-06-16
369	113	4	Semester 1	2024/2025	87.6	2026-06-16
370	113	2	Semester 1	2024/2025	63.5	2026-06-16
371	113	6	Semester 1	2024/2025	65.0	2026-06-16
372	113	1	Semester 1	2024/2025	69.2	2026-06-16
373	114	15	Semester 2	2024/2025	73.5	2026-06-16
374	114	10	Semester 1	2024/2025	78.4	2026-06-16
375	114	11	Semester 2	2024/2025	79.2	2026-06-16
376	114	14	Semester 2	2024/2025	65.1	2026-06-16
377	115	13	Semester 1	2024/2025	86.9	2026-06-16
378	115	10	Semester 1	2024/2025	59.9	2026-06-16
379	115	11	Semester 2	2024/2025	95.5	2026-06-16
380	115	9	Semester 1	2024/2025	56.2	2026-06-16
381	116	21	Semester 2	2024/2025	98.2	2026-06-16
382	116	17	Semester 2	2024/2025	67.5	2026-06-16
383	116	20	Semester 2	2024/2025	88.4	2026-06-16
384	116	18	Semester 2	2024/2025	61.2	2026-06-16
385	117	16	Semester 2	2024/2025	51.5	2026-06-16
386	117	20	Semester 2	2024/2025	53.0	2026-06-16
387	117	17	Semester 1	2024/2025	76.3	2026-06-16
388	117	18	Semester 2	2024/2025	94.7	2026-06-16
389	118	26	Semester 1	2024/2025	70.2	2026-06-16
390	118	23	Semester 2	2024/2025	72.2	2026-06-16
391	118	22	Semester 2	2024/2025	90.8	2026-06-16
392	118	25	Semester 1	2024/2025	90.7	2026-06-16
393	119	24	Semester 1	2024/2025	65.5	2026-06-16
394	119	26	Semester 2	2024/2025	64.3	2026-06-16
395	119	22	Semester 1	2024/2025	50.5	2026-06-16
396	119	23	Semester 1	2024/2025	79.6	2026-06-16
397	120	28	Semester 1	2024/2025	52.6	2026-06-16
398	120	29	Semester 2	2024/2025	78.5	2026-06-16
399	120	30	Semester 2	2024/2025	98.8	2026-06-16
400	120	27	Semester 2	2024/2025	83.5	2026-06-16
\.


--
-- Data for Name: event_participant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_participant (participant_id, event_id, person_id, participant_type, role) FROM stdin;
1	1	52	student	Attendee
2	1	33	student	Attendee
3	1	37	student	Attendee
4	1	101	student	Attendee
5	1	21	student	Attendee
6	2	52	student	Attendee
7	2	33	student	Attendee
8	2	37	student	Attendee
9	2	101	student	Attendee
10	2	21	student	Attendee
11	3	52	student	Attendee
12	3	33	student	Attendee
13	3	37	student	Attendee
14	3	101	student	Attendee
15	3	21	student	Attendee
16	4	52	student	Attendee
17	4	33	student	Attendee
18	4	37	student	Attendee
19	4	101	student	Attendee
20	4	21	student	Attendee
21	5	52	student	Attendee
22	5	33	student	Attendee
23	5	37	student	Attendee
24	5	101	student	Attendee
25	5	21	student	Attendee
26	6	52	student	Attendee
27	6	33	student	Attendee
28	6	37	student	Attendee
29	6	101	student	Attendee
30	6	21	student	Attendee
31	7	52	student	Attendee
32	7	33	student	Attendee
33	7	37	student	Attendee
34	7	101	student	Attendee
35	7	21	student	Attendee
36	8	52	student	Attendee
37	8	33	student	Attendee
38	8	37	student	Attendee
39	8	101	student	Attendee
40	8	21	student	Attendee
41	9	52	student	Attendee
42	9	33	student	Attendee
43	9	37	student	Attendee
44	9	101	student	Attendee
45	9	21	student	Attendee
46	10	52	student	Attendee
47	10	33	student	Attendee
48	10	37	student	Attendee
49	10	101	student	Attendee
50	10	21	student	Attendee
\.


--
-- Data for Name: faculty; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faculty (faculty_id, faculty_name, dean_name) FROM stdin;
1	Faculty of Science & Technology	Dr. Mugisha
2	Faculty of Business	Dr. Uwase
3	Faculty of Education	Dr. Habimana
\.


--
-- Data for Name: lecturer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lecturer (person_id, full_name, dob, gender, address, contact, person_type, staff_id, dept_id, rank, specialization) FROM stdin;
1	Dr. Jean Paul Nkurunziza	1975-03-10	M	\N	(jp@ulk.ac.rw,{+250788001001})	\N	LEC001	1	Senior Lecturer	Database Systems
2	Dr. Marie Claire Uwimana	1980-06-15	F	\N	(mc@ulk.ac.rw,{+250788001002})	\N	LEC002	1	Lecturer	Networks
3	Prof. Eric Habimana	1968-11-20	M	\N	(eh@ulk.ac.rw,{+250788001003})	\N	LEC003	2	Professor	Information Systems
4	Dr. Alice Mukamana	1982-02-28	F	\N	(am@ulk.ac.rw,{+250788001004})	\N	LEC004	2	Lecturer	Data Mining
5	Dr. Robert Niyonzima	1979-07-05	M	\N	(rn@ulk.ac.rw,{+250788001005})	\N	LEC005	3	Senior Lecturer	Finance
6	Dr. Solange Ingabire	1983-09-12	F	\N	(si@ulk.ac.rw,{+250788001006})	\N	LEC006	3	Lecturer	Marketing
7	Dr. Patrick Bizimana	1977-04-18	M	\N	(pb@ulk.ac.rw,{+250788001007})	\N	LEC007	4	Senior Lecturer	Auditing
8	Dr. Diane Umurerwa	1985-01-25	F	\N	(du@ulk.ac.rw,{+250788001008})	\N	LEC008	4	Lecturer	Taxation
9	Dr. Frank Nshimiyimana	1971-08-30	M	\N	(fn@ulk.ac.rw,{+250788001009})	\N	LEC009	5	Professor	Pedagogy
10	Dr. Grace Mutesi	1986-05-14	F	\N	(gm@ulk.ac.rw,{+250788001010})	\N	LEC010	5	Lecturer	Curriculum
11	Dr. Claude Ndayishimiye	1978-12-01	M	\N	(cn@ulk.ac.rw,{+250788001011})	\N	LEC011	1	Lecturer	AI & ML
12	Dr. Hope Kayitesi	1981-03-22	F	\N	(hk@ulk.ac.rw,{+250788001012})	\N	LEC012	1	Lecturer	Software Engineering
13	Dr. Bruno Hakizimana	1976-10-07	M	\N	(bh@ulk.ac.rw,{+250788001013})	\N	LEC013	2	Senior Lecturer	Cloud Computing
14	Dr. Yvette Nyiransabimana	1984-06-19	F	\N	(yn@ulk.ac.rw,{+250788001014})	\N	LEC014	2	Lecturer	Cybersecurity
15	Dr. Simon Rugamba	1973-02-14	M	\N	(sr@ulk.ac.rw,{+250788001015})	\N	LEC015	3	Professor	Economics
16	Dr. Odette Mukamurenzi	1987-09-03	F	\N	(om@ulk.ac.rw,{+250788001016})	\N	LEC016	3	Lecturer	HRM
17	Dr. Jules Nzeyimana	1980-11-28	M	\N	(jn@ulk.ac.rw,{+250788001017})	\N	LEC017	4	Lecturer	Corporate Finance
18	Dr. Angelique Uwera	1982-07-16	F	\N	(au@ulk.ac.rw,{+250788001018})	\N	LEC018	4	Lecturer	Financial Reporting
19	Dr. Leon Habiyaremye	1975-04-09	M	\N	(lh@ulk.ac.rw,{+250788001019})	\N	LEC019	5	Senior Lecturer	Educational Psychology
20	Dr. Chantal Mukandori	1988-01-31	F	\N	(chm@ulk.ac.rw,{+250788001020})	\N	LEC020	5	Lecturer	Assessment Methods
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.person (person_id, full_name, dob, gender, address, contact, person_type) FROM stdin;
\.


--
-- Data for Name: research_project; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.research_project (project_id, title, description, start_date, end_date, metadata) FROM stdin;
1	AI in Education	Applying ML to personalize learning	2024-01-15	2025-01-14	{"tags": ["AI", "education"], "status": "active", "funding": "MINEDUC"}
2	Smart Agriculture	IoT sensors for crop monitoring	2024-03-01	2025-02-28	{"tags": ["IoT", "agriculture"], "status": "active", "funding": "RAB"}
3	Blockchain Finance	Decentralized payment systems	2024-02-10	2025-02-09	{"tags": ["blockchain", "fintech"], "status": "active", "funding": "BNR"}
4	E-Health Records	Electronic patient management	2024-04-01	2025-03-31	{"tags": ["health", "database"], "status": "active", "funding": "MOH"}
5	Cybersecurity Rwanda	Threat analysis for SMEs	2024-05-01	2025-04-30	{"tags": ["security", "SME"], "status": "active", "funding": "RISA"}
\.


--
-- Data for Name: resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource (resource_id, resource_name, resource_type, dept_id, quantity, condition) FROM stdin;
1	Dell Laptop	Equipment	1	20	Good
2	Projector	Equipment	1	5	Good
3	3D Printer	Equipment	1	2	Fair
4	Network Switch	Equipment	2	10	Good
5	Server Rack	Equipment	2	3	Good
6	Financial Calculator	Equipment	4	30	Good
7	Microscope	Equipment	5	10	Good
8	Whiteboard	Furniture	3	15	Good
9	Library Books	Books	1	200	Good
10	Science Journal	Books	5	50	Good
\.


--
-- Data for Name: schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schedule (schedule_id, course_id, space_id, lecturer_id, day_of_week, start_time, end_time) FROM stdin;
1	1	2	12	Tuesday	10:00:00	12:00:00
2	1	2	11	Tuesday	10:00:00	12:00:00
3	1	2	2	Tuesday	10:00:00	12:00:00
4	1	2	1	Tuesday	10:00:00	12:00:00
5	2	3	12	Wednesday	12:00:00	14:00:00
6	2	3	11	Wednesday	12:00:00	14:00:00
7	2	3	2	Wednesday	12:00:00	14:00:00
8	2	3	1	Wednesday	12:00:00	14:00:00
9	3	4	12	Thursday	14:00:00	16:00:00
10	3	4	11	Thursday	14:00:00	16:00:00
11	3	4	2	Thursday	14:00:00	16:00:00
12	3	4	1	Thursday	14:00:00	16:00:00
13	4	5	12	Friday	08:00:00	10:00:00
14	4	5	11	Friday	08:00:00	10:00:00
15	4	5	2	Friday	08:00:00	10:00:00
16	4	5	1	Friday	08:00:00	10:00:00
17	5	6	12	Monday	10:00:00	12:00:00
18	5	6	11	Monday	10:00:00	12:00:00
19	5	6	2	Monday	10:00:00	12:00:00
20	5	6	1	Monday	10:00:00	12:00:00
21	6	7	12	Tuesday	12:00:00	14:00:00
22	6	7	11	Tuesday	12:00:00	14:00:00
23	6	7	2	Tuesday	12:00:00	14:00:00
24	6	7	1	Tuesday	12:00:00	14:00:00
25	7	8	12	Wednesday	14:00:00	16:00:00
26	7	8	11	Wednesday	14:00:00	16:00:00
27	7	8	2	Wednesday	14:00:00	16:00:00
28	7	8	1	Wednesday	14:00:00	16:00:00
29	8	9	12	Thursday	08:00:00	10:00:00
30	8	9	11	Thursday	08:00:00	10:00:00
\.


--
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student (person_id, full_name, dob, gender, address, contact, person_type, reg_number, dept_id, year_of_study, gpa) FROM stdin;
21	Alice Uwase	2000-01-31	M	\N	(student1@ulk.ac.rw,{+250789000001})	\N	ULK20240001	1	2	3.67
22	Bob Nkusi	2000-03-01	F	\N	(student2@ulk.ac.rw,{+250789000002})	\N	ULK20240002	1	3	3.85
23	Claire Mugabo	2000-03-31	M	\N	(student3@ulk.ac.rw,{+250789000003})	\N	ULK20240003	1	4	2.44
24	David Habimana	2000-04-30	F	\N	(student4@ulk.ac.rw,{+250789000004})	\N	ULK20240004	2	1	2.14
25	Eve Nzeyimana	2000-05-30	M	\N	(student5@ulk.ac.rw,{+250789000005})	\N	ULK20240005	2	2	3.22
26	Frank Kayitesi	2000-06-29	F	\N	(student6@ulk.ac.rw,{+250789000006})	\N	ULK20240006	3	3	3.34
27	Grace Bizimana	2000-07-29	M	\N	(student7@ulk.ac.rw,{+250789000007})	\N	ULK20240007	3	4	3.41
28	Henry Mukamana	2000-08-28	F	\N	(student8@ulk.ac.rw,{+250789000008})	\N	ULK20240008	4	1	2.30
29	Irene Ndayisenga	2000-09-27	M	\N	(student9@ulk.ac.rw,{+250789000009})	\N	ULK20240009	4	2	3.99
30	James Ingabire	2000-10-27	F	\N	(student10@ulk.ac.rw,{+250789000010})	\N	ULK20240010	5	3	2.12
31	Karen Gasana	2000-11-26	M	\N	(student11@ulk.ac.rw,{+250789000011})	\N	ULK20240011	1	4	2.64
32	Leo Umurerwa	2000-12-26	F	\N	(student12@ulk.ac.rw,{+250789000012})	\N	ULK20240012	1	1	3.01
33	Mary Hakizimana	2001-01-25	M	\N	(student13@ulk.ac.rw,{+250789000013})	\N	ULK20240013	1	2	3.86
34	Noel Uwimana	2001-02-24	F	\N	(student14@ulk.ac.rw,{+250789000014})	\N	ULK20240014	2	3	3.66
35	Olivia Nshimiyimana	2001-03-26	M	\N	(student15@ulk.ac.rw,{+250789000015})	\N	ULK20240015	2	4	2.18
36	Paul Mutesi	2001-04-25	F	\N	(student16@ulk.ac.rw,{+250789000016})	\N	ULK20240016	3	1	3.37
37	Quinn Ruhumuliza	2001-05-25	M	\N	(student17@ulk.ac.rw,{+250789000017})	\N	ULK20240017	3	2	3.69
38	Rose Kabera	2001-06-24	F	\N	(student18@ulk.ac.rw,{+250789000018})	\N	ULK20240018	4	3	2.44
39	Sam Rugamba	2001-07-24	M	\N	(student19@ulk.ac.rw,{+250789000019})	\N	ULK20240019	4	4	2.34
40	Tina Dushimire	2001-08-23	F	\N	(student20@ulk.ac.rw,{+250789000020})	\N	ULK20240020	5	1	3.17
41	Umar Giramata	2001-09-22	M	\N	(student21@ulk.ac.rw,{+250789000021})	\N	ULK20240021	1	2	3.98
42	Vera Tugiramahoro	2001-10-22	F	\N	(student22@ulk.ac.rw,{+250789000022})	\N	ULK20240022	1	3	2.46
43	Will Nsengimana	2001-11-21	M	\N	(student23@ulk.ac.rw,{+250789000023})	\N	ULK20240023	1	4	2.36
44	Xena Hirwa	2001-12-21	F	\N	(student24@ulk.ac.rw,{+250789000024})	\N	ULK20240024	2	1	2.42
45	Yves Mpayimana	2002-01-20	M	\N	(student25@ulk.ac.rw,{+250789000025})	\N	ULK20240025	2	2	3.04
46	Zoe Niyonzima	2002-02-19	F	\N	(student26@ulk.ac.rw,{+250789000026})	\N	ULK20240026	3	3	2.18
47	Amina Byiringiro	2002-03-21	M	\N	(student27@ulk.ac.rw,{+250789000027})	\N	ULK20240027	3	4	2.65
48	Brian Nkurunziza	2002-04-20	F	\N	(student28@ulk.ac.rw,{+250789000028})	\N	ULK20240028	4	1	3.92
49	Chloe Rurangwa	2002-05-20	M	\N	(student29@ulk.ac.rw,{+250789000029})	\N	ULK20240029	4	2	3.24
50	Denis Uwera	2002-06-19	F	\N	(student30@ulk.ac.rw,{+250789000030})	\N	ULK20240030	5	3	3.61
51	Elena Uwase	2002-07-19	M	\N	(student31@ulk.ac.rw,{+250789000031})	\N	ULK20240031	1	4	2.50
52	Felix Nkusi	2002-08-18	F	\N	(student32@ulk.ac.rw,{+250789000032})	\N	ULK20240032	1	1	2.39
53	Gina Mugabo	2002-09-17	M	\N	(student33@ulk.ac.rw,{+250789000033})	\N	ULK20240033	1	2	2.20
54	Hugo Habimana	2002-10-17	F	\N	(student34@ulk.ac.rw,{+250789000034})	\N	ULK20240034	2	3	2.37
55	Ivy Nzeyimana	2002-11-16	M	\N	(student35@ulk.ac.rw,{+250789000035})	\N	ULK20240035	2	4	2.40
56	Joel Kayitesi	2002-12-16	F	\N	(student36@ulk.ac.rw,{+250789000036})	\N	ULK20240036	3	1	2.71
57	Kira Bizimana	2003-01-15	M	\N	(student37@ulk.ac.rw,{+250789000037})	\N	ULK20240037	3	2	3.91
58	Liam Mukamana	2003-02-14	F	\N	(student38@ulk.ac.rw,{+250789000038})	\N	ULK20240038	4	3	2.97
59	Mia Ndayisenga	2003-03-16	M	\N	(student39@ulk.ac.rw,{+250789000039})	\N	ULK20240039	4	4	3.87
60	Nina Ingabire	2003-04-15	F	\N	(student40@ulk.ac.rw,{+250789000040})	\N	ULK20240040	5	1	2.71
61	Owen Gasana	2003-05-15	M	\N	(student41@ulk.ac.rw,{+250789000041})	\N	ULK20240041	1	2	2.71
62	Pia Umurerwa	2003-06-14	F	\N	(student42@ulk.ac.rw,{+250789000042})	\N	ULK20240042	1	3	3.38
63	Remy Hakizimana	2003-07-14	M	\N	(student43@ulk.ac.rw,{+250789000043})	\N	ULK20240043	1	4	2.02
64	Sara Uwimana	2003-08-13	F	\N	(student44@ulk.ac.rw,{+250789000044})	\N	ULK20240044	2	1	3.21
65	Tom Nshimiyimana	2003-09-12	M	\N	(student45@ulk.ac.rw,{+250789000045})	\N	ULK20240045	2	2	2.39
66	Uma Mutesi	2003-10-12	F	\N	(student46@ulk.ac.rw,{+250789000046})	\N	ULK20240046	3	3	3.42
67	Victor Ruhumuliza	2003-11-11	M	\N	(student47@ulk.ac.rw,{+250789000047})	\N	ULK20240047	3	4	3.03
68	Wendy Kabera	2003-12-11	F	\N	(student48@ulk.ac.rw,{+250789000048})	\N	ULK20240048	4	1	3.73
69	Xara Rugamba	2004-01-10	M	\N	(student49@ulk.ac.rw,{+250789000049})	\N	ULK20240049	4	2	3.35
70	Yolanda Dushimire	2004-02-09	F	\N	(student50@ulk.ac.rw,{+250789000050})	\N	ULK20240050	5	3	2.02
71	Zara Giramata	2004-03-10	M	\N	(student51@ulk.ac.rw,{+250789000051})	\N	ULK20240051	1	4	3.61
72	Aaron Tugiramahoro	2004-04-09	F	\N	(student52@ulk.ac.rw,{+250789000052})	\N	ULK20240052	1	1	3.17
73	Bella Nsengimana	2004-05-09	M	\N	(student53@ulk.ac.rw,{+250789000053})	\N	ULK20240053	1	2	2.80
74	Carlos Hirwa	2004-06-08	F	\N	(student54@ulk.ac.rw,{+250789000054})	\N	ULK20240054	2	3	3.26
75	Diana Mpayimana	2004-07-08	M	\N	(student55@ulk.ac.rw,{+250789000055})	\N	ULK20240055	2	4	3.67
76	Evan Niyonzima	2004-08-07	F	\N	(student56@ulk.ac.rw,{+250789000056})	\N	ULK20240056	3	1	3.91
77	Fiona Byiringiro	2004-09-06	M	\N	(student57@ulk.ac.rw,{+250789000057})	\N	ULK20240057	3	2	3.90
78	George Nkurunziza	2004-10-06	F	\N	(student58@ulk.ac.rw,{+250789000058})	\N	ULK20240058	4	3	3.75
79	Hannah Rurangwa	2004-11-05	M	\N	(student59@ulk.ac.rw,{+250789000059})	\N	ULK20240059	4	4	2.23
80	Isaac Uwera	2004-12-05	F	\N	(student60@ulk.ac.rw,{+250789000060})	\N	ULK20240060	5	1	3.81
81	Julia Uwase	2005-01-04	M	\N	(student61@ulk.ac.rw,{+250789000061})	\N	ULK20240061	1	2	3.78
82	Kevin Nkusi	2005-02-03	F	\N	(student62@ulk.ac.rw,{+250789000062})	\N	ULK20240062	1	3	2.45
83	Laura Mugabo	2005-03-05	M	\N	(student63@ulk.ac.rw,{+250789000063})	\N	ULK20240063	1	4	3.16
84	Mark Habimana	2005-04-04	F	\N	(student64@ulk.ac.rw,{+250789000064})	\N	ULK20240064	2	1	3.18
85	Nadia Nzeyimana	2005-05-04	M	\N	(student65@ulk.ac.rw,{+250789000065})	\N	ULK20240065	2	2	2.04
86	Oscar Kayitesi	2005-06-03	F	\N	(student66@ulk.ac.rw,{+250789000066})	\N	ULK20240066	3	3	3.93
87	Priya Bizimana	2005-07-03	M	\N	(student67@ulk.ac.rw,{+250789000067})	\N	ULK20240067	3	4	3.46
88	Quentin Mukamana	2005-08-02	F	\N	(student68@ulk.ac.rw,{+250789000068})	\N	ULK20240068	4	1	2.38
89	Rachel Ndayisenga	2005-09-01	M	\N	(student69@ulk.ac.rw,{+250789000069})	\N	ULK20240069	4	2	2.55
90	Steve Ingabire	2005-10-01	F	\N	(student70@ulk.ac.rw,{+250789000070})	\N	ULK20240070	5	3	3.90
91	Tara Gasana	2005-10-31	M	\N	(student71@ulk.ac.rw,{+250789000071})	\N	ULK20240071	1	4	2.41
92	Ulrich Umurerwa	2005-11-30	F	\N	(student72@ulk.ac.rw,{+250789000072})	\N	ULK20240072	1	1	2.32
93	Vicky Hakizimana	2005-12-30	M	\N	(student73@ulk.ac.rw,{+250789000073})	\N	ULK20240073	1	2	3.84
94	Walter Uwimana	2006-01-29	F	\N	(student74@ulk.ac.rw,{+250789000074})	\N	ULK20240074	2	3	3.97
95	Xena2 Nshimiyimana	2006-02-28	M	\N	(student75@ulk.ac.rw,{+250789000075})	\N	ULK20240075	2	4	2.55
96	Yasmin Mutesi	2006-03-30	F	\N	(student76@ulk.ac.rw,{+250789000076})	\N	ULK20240076	3	1	2.67
97	Zion Ruhumuliza	2006-04-29	M	\N	(student77@ulk.ac.rw,{+250789000077})	\N	ULK20240077	3	2	2.81
98	Andre Kabera	2006-05-29	F	\N	(student78@ulk.ac.rw,{+250789000078})	\N	ULK20240078	4	3	2.14
99	Blessing Rugamba	2006-06-28	M	\N	(student79@ulk.ac.rw,{+250789000079})	\N	ULK20240079	4	4	3.80
100	Cedric Dushimire	2006-07-28	F	\N	(student80@ulk.ac.rw,{+250789000080})	\N	ULK20240080	5	1	3.38
101	Dalia Giramata	2006-08-27	M	\N	(student81@ulk.ac.rw,{+250789000081})	\N	ULK20240081	1	2	3.21
102	Emeka Tugiramahoro	2006-09-26	F	\N	(student82@ulk.ac.rw,{+250789000082})	\N	ULK20240082	1	3	2.16
103	Fatou Nsengimana	2006-10-26	M	\N	(student83@ulk.ac.rw,{+250789000083})	\N	ULK20240083	1	4	4.00
104	Gael Hirwa	2006-11-25	F	\N	(student84@ulk.ac.rw,{+250789000084})	\N	ULK20240084	2	1	3.88
105	Hadiya Mpayimana	2006-12-25	M	\N	(student85@ulk.ac.rw,{+250789000085})	\N	ULK20240085	2	2	2.80
106	Ibrahim Niyonzima	2007-01-24	F	\N	(student86@ulk.ac.rw,{+250789000086})	\N	ULK20240086	3	3	2.92
107	Jasmine Byiringiro	2007-02-23	M	\N	(student87@ulk.ac.rw,{+250789000087})	\N	ULK20240087	3	4	2.83
108	Kwame Nkurunziza	2007-03-25	F	\N	(student88@ulk.ac.rw,{+250789000088})	\N	ULK20240088	4	1	3.45
109	Leila Rurangwa	2007-04-24	M	\N	(student89@ulk.ac.rw,{+250789000089})	\N	ULK20240089	4	2	3.28
110	Moses Uwera	2007-05-24	F	\N	(student90@ulk.ac.rw,{+250789000090})	\N	ULK20240090	5	3	2.93
111	Naomi Uwase	2007-06-23	M	\N	(student91@ulk.ac.rw,{+250789000091})	\N	ULK20240091	1	4	2.49
112	Obinna Nkusi	2007-07-23	F	\N	(student92@ulk.ac.rw,{+250789000092})	\N	ULK20240092	1	1	2.85
113	Precious Mugabo	2007-08-22	M	\N	(student93@ulk.ac.rw,{+250789000093})	\N	ULK20240093	1	2	3.27
114	Rania Habimana	2007-09-21	F	\N	(student94@ulk.ac.rw,{+250789000094})	\N	ULK20240094	2	3	3.36
115	Seun Nzeyimana	2007-10-21	M	\N	(student95@ulk.ac.rw,{+250789000095})	\N	ULK20240095	2	4	2.71
116	Tariq Kayitesi	2007-11-20	F	\N	(student96@ulk.ac.rw,{+250789000096})	\N	ULK20240096	3	1	2.78
117	Ursula Bizimana	2007-12-20	M	\N	(student97@ulk.ac.rw,{+250789000097})	\N	ULK20240097	3	2	2.37
118	Valentine Mukamana	2008-01-19	F	\N	(student98@ulk.ac.rw,{+250789000098})	\N	ULK20240098	4	3	3.82
119	Wanjiku Ndayisenga	2008-02-18	M	\N	(student99@ulk.ac.rw,{+250789000099})	\N	ULK20240099	4	4	2.51
120	Alice Ingabire	2008-03-19	F	\N	(student100@ulk.ac.rw,{+250789000100})	\N	ULK20240100	5	1	3.06
\.


--
-- Data for Name: supervision; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.supervision (supervision_id, lecturer_id, student_id, project_id, start_date, role) FROM stdin;
1	1	75	1	2024-02-01	Researcher
2	1	30	1	2024-02-01	Researcher
3	1	64	1	2024-02-01	Researcher
4	1	85	1	2024-02-01	Researcher
5	1	59	1	2024-02-01	Researcher
6	2	75	1	2024-02-01	Researcher
7	2	30	1	2024-02-01	Researcher
8	2	64	1	2024-02-01	Researcher
9	2	85	1	2024-02-01	Researcher
10	2	59	1	2024-02-01	Researcher
11	3	75	1	2024-02-01	Researcher
12	3	30	1	2024-02-01	Researcher
13	3	64	1	2024-02-01	Researcher
14	3	85	1	2024-02-01	Researcher
15	3	59	1	2024-02-01	Researcher
16	4	75	1	2024-02-01	Researcher
17	4	30	1	2024-02-01	Researcher
18	4	64	1	2024-02-01	Researcher
19	4	85	1	2024-02-01	Researcher
20	4	59	1	2024-02-01	Researcher
21	5	75	1	2024-02-01	Researcher
22	5	30	1	2024-02-01	Researcher
23	5	64	1	2024-02-01	Researcher
24	5	85	1	2024-02-01	Researcher
25	5	59	1	2024-02-01	Researcher
26	6	75	1	2024-02-01	Researcher
27	6	30	1	2024-02-01	Researcher
28	6	64	1	2024-02-01	Researcher
29	6	85	1	2024-02-01	Researcher
30	6	59	1	2024-02-01	Researcher
\.


--
-- Name: academic_event_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.academic_event_event_id_seq', 10, true);


--
-- Name: academic_space_space_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.academic_space_space_id_seq', 10, true);


--
-- Name: attendance_attendance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attendance_attendance_id_seq', 50, true);


--
-- Name: course_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_course_id_seq', 30, true);


--
-- Name: department_dept_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.department_dept_id_seq', 5, true);


--
-- Name: enrollment_enrollment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enrollment_enrollment_id_seq', 400, true);


--
-- Name: event_participant_participant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_participant_participant_id_seq', 50, true);


--
-- Name: faculty_faculty_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faculty_faculty_id_seq', 3, true);


--
-- Name: person_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.person_person_id_seq', 120, true);


--
-- Name: research_project_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.research_project_project_id_seq', 5, true);


--
-- Name: resource_resource_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.resource_resource_id_seq', 10, true);


--
-- Name: schedule_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schedule_schedule_id_seq', 30, true);


--
-- Name: supervision_supervision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.supervision_supervision_id_seq', 30, true);


--
-- Name: academic_event academic_event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.academic_event
    ADD CONSTRAINT academic_event_pkey PRIMARY KEY (event_id);


--
-- Name: academic_space academic_space_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.academic_space
    ADD CONSTRAINT academic_space_pkey PRIMARY KEY (space_id);


--
-- Name: attendance attendance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_pkey PRIMARY KEY (attendance_id);


--
-- Name: course course_course_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_course_code_key UNIQUE (course_code);


--
-- Name: course course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (course_id);


--
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (dept_id);


--
-- Name: enrollment enrollment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_pkey PRIMARY KEY (enrollment_id);


--
-- Name: event_participant event_participant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_participant
    ADD CONSTRAINT event_participant_pkey PRIMARY KEY (participant_id);


--
-- Name: faculty faculty_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty
    ADD CONSTRAINT faculty_pkey PRIMARY KEY (faculty_id);


--
-- Name: lecturer lecturer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecturer
    ADD CONSTRAINT lecturer_pkey PRIMARY KEY (person_id);


--
-- Name: lecturer lecturer_staff_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecturer
    ADD CONSTRAINT lecturer_staff_id_key UNIQUE (staff_id);


--
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (person_id);


--
-- Name: research_project research_project_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_project
    ADD CONSTRAINT research_project_pkey PRIMARY KEY (project_id);


--
-- Name: resource resource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource
    ADD CONSTRAINT resource_pkey PRIMARY KEY (resource_id);


--
-- Name: schedule schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (schedule_id);


--
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (person_id);


--
-- Name: student student_reg_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_reg_number_key UNIQUE (reg_number);


--
-- Name: supervision supervision_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supervision
    ADD CONSTRAINT supervision_pkey PRIMARY KEY (supervision_id);


--
-- Name: idx_enrollment_course; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_enrollment_course ON public.enrollment USING btree (course_id);


--
-- Name: idx_schedule_lecturer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_schedule_lecturer ON public.schedule USING btree (lecturer_id);


--
-- Name: idx_student_dept; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_student_dept ON public.student USING btree (dept_id);


--
-- Name: academic_event academic_event_organizer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.academic_event
    ADD CONSTRAINT academic_event_organizer_id_fkey FOREIGN KEY (organizer_id) REFERENCES public.lecturer(person_id);


--
-- Name: attendance attendance_schedule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_schedule_id_fkey FOREIGN KEY (schedule_id) REFERENCES public.schedule(schedule_id);


--
-- Name: attendance attendance_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(person_id);


--
-- Name: course course_dept_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_dept_id_fkey FOREIGN KEY (dept_id) REFERENCES public.department(dept_id);


--
-- Name: department department_faculty_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_faculty_id_fkey FOREIGN KEY (faculty_id) REFERENCES public.faculty(faculty_id);


--
-- Name: enrollment enrollment_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.course(course_id);


--
-- Name: enrollment enrollment_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(person_id);


--
-- Name: event_participant event_participant_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_participant
    ADD CONSTRAINT event_participant_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.academic_event(event_id);


--
-- Name: lecturer lecturer_dept_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecturer
    ADD CONSTRAINT lecturer_dept_id_fkey FOREIGN KEY (dept_id) REFERENCES public.department(dept_id);


--
-- Name: resource resource_dept_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource
    ADD CONSTRAINT resource_dept_id_fkey FOREIGN KEY (dept_id) REFERENCES public.department(dept_id);


--
-- Name: schedule schedule_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.course(course_id);


--
-- Name: schedule schedule_lecturer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_lecturer_id_fkey FOREIGN KEY (lecturer_id) REFERENCES public.lecturer(person_id);


--
-- Name: schedule schedule_space_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_space_id_fkey FOREIGN KEY (space_id) REFERENCES public.academic_space(space_id);


--
-- Name: student student_dept_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_dept_id_fkey FOREIGN KEY (dept_id) REFERENCES public.department(dept_id);


--
-- Name: supervision supervision_lecturer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supervision
    ADD CONSTRAINT supervision_lecturer_id_fkey FOREIGN KEY (lecturer_id) REFERENCES public.lecturer(person_id);


--
-- Name: supervision supervision_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supervision
    ADD CONSTRAINT supervision_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.research_project(project_id);


--
-- Name: supervision supervision_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supervision
    ADD CONSTRAINT supervision_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(person_id);


--
-- PostgreSQL database dump complete
--

\unrestrict UCxsktsgaO2VcYJnXHCs4BtPGtF7SSbQ6SZwNQHOxcdaFzknjPudZwxDEyyrCEM

