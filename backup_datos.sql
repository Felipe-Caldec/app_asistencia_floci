--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

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
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.auth_user DISABLE TRIGGER ALL;

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
4	pbkdf2_sha256$600000$QWcA3FeE8Tw3x4HPxVH7GI$GlmUcjoE1TiDnjef/FEQzX1hQ52ucgOGBjdJIePGlWk=	2026-07-03 16:53:05.434714-04	f	e_jorquera	Eva	Jorquera	e_jorquera@correo.cl	f	t	2026-06-28 19:03:07.388544-04
3	pbkdf2_sha256$1000000$xMp2UX7HXl3EeZgKJrrL4j$g9fwt53wAoVjm0Lec8fc/VG5RL6PMp1mN8YgbXO1c7E=	\N	f	r_reyes	Roman	Reyes	rreyes@correo.cl	f	t	2026-06-15 21:09:05.231494-04
6	pbkdf2_sha256$600000$KUfivjmMiFvTDiLS6cPmga$5NTQAItMTuxSGnKHlw+7OirTLSyyymDjZuA45mveVUw=	\N	f	n_jorquera	Nicolas	Jorquera	n_jorquera@correo.cl	f	t	2026-07-03 16:58:04.632447-04
1	pbkdf2_sha256$600000$K5oOfmsr3K2Y423WwK5lK0$K9wSSpP4CtFF7VeGLjDASgef5eziXn0WrWVosS9ci3M=	2026-07-04 22:33:34.786327-04	t	admin			admin@correo.cl	t	t	2026-06-15 20:20:01.687206-04
2	pbkdf2_sha256$600000$WL6CHJFhUnEeki51ewxtLj$IQq4pmQ1gvVDuJY9yU3/tnOPndF9y1gOC1daK/E/4GA=	2026-07-03 16:34:13.7066-04	f	d_leiva	David	Leiva	dleiva@correo.com	f	t	2026-06-15 20:29:37.506267-04
5	pbkdf2_sha256$600000$6LibUBeUpX2mo8Pl3olIOs$0d8af5bseiNtiRbTT8S55+F2ZtiPvkdjYZNA2P+b/og=	2026-07-03 16:34:26.53206-04	f	j_urra	Jose	Urra	j_urra@correo.cl	f	t	2026-06-28 19:04:06.297508-04
\.


ALTER TABLE public.auth_user ENABLE TRIGGER ALL;

--
-- Data for Name: courses_alumno; Type: TABLE DATA; Schema: public; Owner: postgres
--

ALTER TABLE public.courses_alumno DISABLE TRIGGER ALL;

COPY public.courses_alumno (id, nombre, apellido, rut, activo, fecha_creacion, genero, correo, fecha_nacimiento, telefono, edad) FROM stdin;
4	Camila	Silva	12765836-6	t	2026-06-19 17:36:28.680831-04	F	camila_silva@correo.cl	1996-06-19	\N	30
5	Alonso	Perez	10006101-5	t	2026-06-19 17:37:17.083685-04	M	alon_perez@correo.cl	1987-05-01	\N	39
8	Camilo	Solar	16204720-5	t	2026-06-19 17:40:43.499856-04	M	cami_solar@correo.cl	1998-06-19	\N	28
9	Claudia	Vidal	14490825-2	t	2026-06-19 17:44:39.248258-04	F	clau_vidal@correo.cl	2006-06-14	\N	20
12	Carlos	Tapia	13.333.333-4	t	2026-07-03 17:24:58.041663-04	M	carlostapia@correo.cl	1983-03-05	999999999	43
7	Juan	Cruz	11959315-8	t	2026-06-19 17:39:48.47393-04	M	juan_cruz@correo.cl	1983-03-05		43
6	Rosa	Cares	11448904-2	t	2026-06-19 17:37:59.135913-04	F	rosa_cares@correo.cl	1991-10-19		34
\.


ALTER TABLE public.courses_alumno ENABLE TRIGGER ALL;

--
-- Data for Name: courses_curso; Type: TABLE DATA; Schema: public; Owner: postgres
--

ALTER TABLE public.courses_curso DISABLE TRIGGER ALL;

COPY public.courses_curso (id, nombre, descripcion, activo, fecha_creacion) FROM stdin;
1	Natacion		t	2026-06-15 20:21:20.449287-04
2	Boxeo		t	2026-06-15 20:24:37.927125-04
3	Voley		t	2026-06-15 20:24:45.07216-04
4	Bicicleta		t	2026-06-15 20:24:54.67642-04
\.


ALTER TABLE public.courses_curso ENABLE TRIGGER ALL;

--
-- Data for Name: courses_horario; Type: TABLE DATA; Schema: public; Owner: postgres
--

ALTER TABLE public.courses_horario DISABLE TRIGGER ALL;

COPY public.courses_horario (id, dia_semana, hora_inicio, hora_fin, sala, activo, curso_id, profesor_id) FROM stdin;
1	LUN	10:00:00	11:30:00	Piscina	t	1	2
2	LUN	12:00:00	13:30:00	Piscina	t	1	2
3	MIE	10:00:00	11:30:00	Gimnasio	t	3	4
4	JUE	18:00:00	17:30:00	Gimnasio	t	3	4
5	LUN	16:00:00	17:30:00	Gimnasio	t	4	5
6	MAR	12:00:00	13:30:00	Gimnasio	t	2	3
7	SAB	10:00:00	11:30:00	Gimnasio	t	2	3
8	JUE	10:00:00	11:30:00	Gimnasio	t	4	5
9	VIE	10:00:00	11:30:00	Gimnasio	t	3	4
10	MAR	16:00:00	17:30:00	Gimnasio	t	3	4
11	LUN	12:00:00	13:30:00	Gimnasio	t	3	4
12	SAB	11:00:00	12:30:00	Gimnasio	t	3	4
13	JUE	11:00:00	12:30:00	Gimnasio	t	3	4
14	SAB	10:00:00	11:30:00	Piscina	t	1	2
15	LUN	15:00:00	16:30:00	Gimnasio	t	4	2
16	LUN	16:00:00	17:30:00	Gimnasio	t	2	5
\.


ALTER TABLE public.courses_horario ENABLE TRIGGER ALL;

--
-- Data for Name: attendance_asistencia; Type: TABLE DATA; Schema: public; Owner: postgres
--

ALTER TABLE public.attendance_asistencia DISABLE TRIGGER ALL;

COPY public.attendance_asistencia (id, fecha, estado, fecha_registro, alumno_id, horario_id, profesor_registro_id) FROM stdin;
2	2026-06-28	P	2026-06-28 19:06:58.842367-04	6	4	1
3	2026-06-28	P	2026-06-28 19:06:58.865267-04	4	4	1
4	2026-06-28	P	2026-06-28 19:07:31.068798-04	6	3	1
5	2026-06-28	P	2026-06-28 19:07:31.080097-04	4	3	1
6	2026-06-28	P	2026-06-28 19:08:28.211481-04	7	1	1
7	2026-06-28	P	2026-06-28 19:08:28.230646-04	8	1	1
8	2026-06-28	P	2026-06-28 21:54:09.559555-04	7	6	1
9	2026-06-29	P	2026-06-29 10:40:35.439107-04	6	11	4
10	2026-06-29	P	2026-06-29 10:40:35.454465-04	4	11	4
11	2026-07-03	A	2026-07-03 16:32:21.869255-04	7	1	1
12	2026-07-03	A	2026-07-03 16:32:21.912643-04	8	1	1
13	2026-07-03	P	2026-07-03 16:34:45.964196-04	6	9	4
14	2026-07-03	P	2026-07-03 16:34:45.986257-04	4	9	4
\.


ALTER TABLE public.attendance_asistencia ENABLE TRIGGER ALL;

--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_group DISABLE TRIGGER ALL;

COPY public.auth_group (id, name) FROM stdin;
\.


ALTER TABLE public.auth_group ENABLE TRIGGER ALL;

--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

ALTER TABLE public.django_content_type DISABLE TRIGGER ALL;

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	users	profesorprofile
8	courses	alumno
9	courses	curso
10	courses	horario
11	courses	asignacionalumno
12	attendance	asistencia
\.


ALTER TABLE public.django_content_type ENABLE TRIGGER ALL;

--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_permission DISABLE TRIGGER ALL;

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add Perfil de Profesor	7	add_profesorprofile
26	Can change Perfil de Profesor	7	change_profesorprofile
27	Can delete Perfil de Profesor	7	delete_profesorprofile
28	Can view Perfil de Profesor	7	view_profesorprofile
29	Can add Alumno	8	add_alumno
30	Can change Alumno	8	change_alumno
31	Can delete Alumno	8	delete_alumno
32	Can view Alumno	8	view_alumno
33	Can add Curso	9	add_curso
34	Can change Curso	9	change_curso
35	Can delete Curso	9	delete_curso
36	Can view Curso	9	view_curso
37	Can add Horario	10	add_horario
38	Can change Horario	10	change_horario
39	Can delete Horario	10	delete_horario
40	Can view Horario	10	view_horario
41	Can add Asignación de Alumno	11	add_asignacionalumno
42	Can change Asignación de Alumno	11	change_asignacionalumno
43	Can delete Asignación de Alumno	11	delete_asignacionalumno
44	Can view Asignación de Alumno	11	view_asignacionalumno
45	Can add Asistencia	12	add_asistencia
46	Can change Asistencia	12	change_asistencia
47	Can delete Asistencia	12	delete_asistencia
48	Can view Asistencia	12	view_asistencia
\.


ALTER TABLE public.auth_permission ENABLE TRIGGER ALL;

--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_group_permissions DISABLE TRIGGER ALL;

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


ALTER TABLE public.auth_group_permissions ENABLE TRIGGER ALL;

--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user_groups DISABLE TRIGGER ALL;

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


ALTER TABLE public.auth_user_groups ENABLE TRIGGER ALL;

--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user_user_permissions DISABLE TRIGGER ALL;

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


ALTER TABLE public.auth_user_user_permissions ENABLE TRIGGER ALL;

--
-- Data for Name: courses_asignacionalumno; Type: TABLE DATA; Schema: public; Owner: postgres
--

ALTER TABLE public.courses_asignacionalumno DISABLE TRIGGER ALL;

COPY public.courses_asignacionalumno (id, fecha_asignacion, alumno_id, curso_id, horario_id) FROM stdin;
7	2026-06-28	6	3	4
8	2026-06-28	4	3	4
9	2026-06-28	7	1	1
10	2026-06-28	8	1	1
11	2026-06-28	7	2	6
12	2026-06-29	5	4	15
\.


ALTER TABLE public.courses_asignacionalumno ENABLE TRIGGER ALL;

--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

ALTER TABLE public.django_admin_log DISABLE TRIGGER ALL;

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2026-06-15 20:21:20.453505-04	1	Natacion	1	[{"added": {}}]	9	1
2	2026-06-15 20:24:37.93046-04	2	Boxeo	1	[{"added": {}}]	9	1
3	2026-06-15 20:24:45.075766-04	3	Voley	1	[{"added": {}}]	9	1
4	2026-06-15 20:24:54.68024-04	4	Bicicleta	1	[{"added": {}}]	9	1
5	2026-06-15 20:56:41.830779-04	2	Diaz, Cristina (13442345-8) → Natacion	3		11	1
6	2026-06-15 20:56:45.328582-04	1	Cordero, Diego (12345596-0) → Natacion	3		11	1
7	2026-06-15 20:59:18.70411-04	4	Diaz, Cristina (13442345-8) → Natacion	2	[{"changed": {"fields": ["Horario espec\\u00edfico"]}}]	11	1
8	2026-06-15 20:59:23.957564-04	4	Diaz, Cristina (13442345-8) → Natacion	2	[]	11	1
9	2026-06-15 20:59:28.174175-04	3	Cordero, Diego (12345596-0) → Natacion	2	[{"changed": {"fields": ["Horario espec\\u00edfico"]}}]	11	1
10	2026-06-15 21:00:16.612257-04	4	Diaz, Cristina (13442345-8) → Natacion	2	[]	11	1
11	2026-06-15 21:00:20.828794-04	3	Cordero, Diego (12345596-0) → Natacion	2	[]	11	1
12	2026-06-15 21:30:56.474079-04	5	Reyes, Camilo (12409088-0) → Natacion	3		11	1
13	2026-06-15 21:30:56.474236-04	4	Diaz, Cristina (13442345-8) → Natacion	3		11	1
14	2026-06-15 21:30:56.474315-04	3	Cordero, Diego (12345596-0) → Natacion	3		11	1
15	2026-06-28 18:57:31.558843-04	2	Perfil de Roman Reyes	2	[]	7	1
16	2026-06-28 18:57:46.820507-04	2	Perfil de Roman Reyes	2	[]	7	1
17	2026-07-03 17:57:24.198814-04	7	Cruz, Juan (11959315-8)	2	[{"changed": {"fields": ["Activo"]}}]	8	1
18	2026-07-03 17:57:28.304761-04	6	Cares, Rosa (11448904-2)	2	[{"changed": {"fields": ["Activo"]}}]	8	1
\.


ALTER TABLE public.django_admin_log ENABLE TRIGGER ALL;

--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

ALTER TABLE public.django_migrations DISABLE TRIGGER ALL;

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2026-06-15 20:18:12.452349-04
2	auth	0001_initial	2026-06-15 20:18:12.57483-04
3	admin	0001_initial	2026-06-15 20:18:12.610701-04
4	admin	0002_logentry_remove_auto_add	2026-06-15 20:18:12.62226-04
5	admin	0003_logentry_add_action_flag_choices	2026-06-15 20:18:12.637072-04
6	courses	0001_initial	2026-06-15 20:18:12.714682-04
7	attendance	0001_initial	2026-06-15 20:18:12.763771-04
8	contenttypes	0002_remove_content_type_name	2026-06-15 20:18:12.788458-04
9	auth	0002_alter_permission_name_max_length	2026-06-15 20:18:12.805313-04
10	auth	0003_alter_user_email_max_length	2026-06-15 20:18:12.820767-04
11	auth	0004_alter_user_username_opts	2026-06-15 20:18:12.832986-04
12	auth	0005_alter_user_last_login_null	2026-06-15 20:18:12.847309-04
13	auth	0006_require_contenttypes_0002	2026-06-15 20:18:12.849722-04
14	auth	0007_alter_validators_add_error_messages	2026-06-15 20:18:12.871004-04
15	auth	0008_alter_user_username_max_length	2026-06-15 20:18:12.890719-04
16	auth	0009_alter_user_last_name_max_length	2026-06-15 20:18:12.903754-04
17	auth	0010_alter_group_name_max_length	2026-06-15 20:18:12.923232-04
18	auth	0011_update_proxy_permissions	2026-06-15 20:18:12.940082-04
19	auth	0012_alter_user_first_name_max_length	2026-06-15 20:18:12.955839-04
20	sessions	0001_initial	2026-06-15 20:18:12.974173-04
21	users	0001_initial	2026-06-15 20:18:13.002531-04
22	courses	0002_asignacionalumno_horario	2026-06-15 20:55:18.277455-04
23	courses	0003_alter_asignacionalumno_curso_and_more	2026-06-15 21:16:34.212924-04
24	courses	0004_alter_asignacionalumno_unique_together	2026-06-15 21:25:22.562745-04
25	courses	0005_alumno_genero	2026-06-16 21:59:51.622278-04
26	courses	0006_alumno_correo_alumno_fecha_nacimiento	2026-06-16 22:49:14.600882-04
27	courses	0002_edad_alumno	2026-07-03 17:45:25.497025-04
\.


ALTER TABLE public.django_migrations ENABLE TRIGGER ALL;

--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

ALTER TABLE public.django_session DISABLE TRIGGER ALL;

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
oe0p4xvli5p80nmprqmvxmfy22jvvin4	.eJxVjEsOwjAMBe-SNYr6cWOHJfueIXJsQwqolfpZIe4OlbqA7ZuZ93KJt7WkbbE5DerOrnan3y2zPGzcgd55vE1epnGdh-x3xR908f2k9rwc7t9B4aV8a2oVgUWMuFLEhrDD2gwQse0yRKqqQHBtYhbQEKJQUGGIMWJrkMm9P9B6N0g:1wZIdv:6dFAw_slWi0cOrMLHz94DOO1YzriWMwFcNXjyVFlgfY	2026-06-29 21:31:07.639676-04
hrxrn9ijz6u0yuxzxukfkf4vf10sl6uy	.eJxVjEEOwiAQRe_C2hAGcBCX7nsGMjAgVUOT0q6Md7dNutDtf-_9twi0LjWsPc9hZHEVIE6_W6T0zG0H_KB2n2Sa2jKPUe6KPGiXw8T5dTvcv4NKvW71GSLxpegCaFxSNhWwaDU7bR0ZkzF7ZzI4Dxp88kgcS9xcpYxFRhSfL9ClNw8:1wflt9:OpGDWqW0zOxOBC6lKj5Uji-5Dbu9nHPaqju_HVwybgE	2026-07-17 17:57:35.24147-04
tu4i19lnv57rud0jrlboqat73dyle9rl	.eJxVjEEOwiAQRe_C2hAGcBCX7nsGMjAgVUOT0q6Md7dNutDtf-_9twi0LjWsPc9hZHEVIE6_W6T0zG0H_KB2n2Sa2jKPUe6KPGiXw8T5dTvcv4NKvW71GSLxpegCaFxSNhWwaDU7bR0ZkzF7ZzI4Dxp88kgcS9xcpYxFRhSfL9ClNw8:1wgCfm:qeqmz_mUQ0I5y-abWbgh_tUOwkedsUC1IK01ya3wRBY	2026-07-18 22:33:34.794534-04
\.


ALTER TABLE public.django_session ENABLE TRIGGER ALL;

--
-- Data for Name: users_profesorprofile; Type: TABLE DATA; Schema: public; Owner: postgres
--

ALTER TABLE public.users_profesorprofile DISABLE TRIGGER ALL;

COPY public.users_profesorprofile (id, telefono, departamento, user_id) FROM stdin;
1	987654321	Deportes	2
2	99999999	Boxeo	3
3	99999999	Gimnasia	4
4	987654321	Tenis	5
5	999999999	Boxeo	6
\.


ALTER TABLE public.users_profesorprofile ENABLE TRIGGER ALL;

--
-- Name: attendance_asistencia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attendance_asistencia_id_seq', 14, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 48, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 6, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: courses_alumno_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.courses_alumno_id_seq', 12, true);


--
-- Name: courses_asignacionalumno_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.courses_asignacionalumno_id_seq', 12, true);


--
-- Name: courses_curso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.courses_curso_id_seq', 4, true);


--
-- Name: courses_horario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.courses_horario_id_seq', 16, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 18, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 12, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 27, true);


--
-- Name: users_profesorprofile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_profesorprofile_id_seq', 5, true);


--
-- PostgreSQL database dump complete
--

