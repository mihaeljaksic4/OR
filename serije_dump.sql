--
-- PostgreSQL database dump
--

\restrict mZL9a8mVMaLvDBhtRdyIuXgjDeiyQKS72ltBNZtpySy05dUkiKoWjLXtk2UhvvW

-- Dumped from database version 18.4 (Homebrew)
-- Dumped by pg_dump version 18.4 (Homebrew)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: glavna_uloga; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.glavna_uloga (
    id integer NOT NULL,
    serija_id integer NOT NULL,
    glumac character varying(200) NOT NULL
);


ALTER TABLE public.glavna_uloga OWNER TO postgres;

--
-- Name: glavna_uloga_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.glavna_uloga_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.glavna_uloga_id_seq OWNER TO postgres;

--
-- Name: glavna_uloga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.glavna_uloga_id_seq OWNED BY public.glavna_uloga.id;


--
-- Name: serija; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.serija (
    id integer NOT NULL,
    naziv character varying(200) NOT NULL,
    kreator character varying(200) NOT NULL,
    zanr character varying(50) NOT NULL,
    ocjena numeric(3,1),
    godina_pocetka integer NOT NULL,
    godina_zavrsetka integer,
    broj_sezona integer,
    broj_epizoda integer,
    prosjecno_trajanje_epizode integer,
    zemlja character varying(100) NOT NULL,
    CONSTRAINT serija_ocjena_check CHECK (((ocjena >= (0)::numeric) AND (ocjena <= (10)::numeric)))
);


ALTER TABLE public.serija OWNER TO postgres;

--
-- Name: serija_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.serija_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.serija_id_seq OWNER TO postgres;

--
-- Name: serija_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.serija_id_seq OWNED BY public.serija.id;


--
-- Name: glavna_uloga id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.glavna_uloga ALTER COLUMN id SET DEFAULT nextval('public.glavna_uloga_id_seq'::regclass);


--
-- Name: serija id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serija ALTER COLUMN id SET DEFAULT nextval('public.serija_id_seq'::regclass);


--
-- Data for Name: glavna_uloga; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.glavna_uloga (id, serija_id, glumac) FROM stdin;
1	1	Bryan Cranston
2	2	Bob Odenkirk
3	3	Simon Baker
4	4	James Gandolfini
5	5	Benedict Cumberbatch
6	6	Rhea Seehorn
7	7	Steve Carell
8	8	Michael C. Hall
9	9	Adam Scott
10	10	Jason Sudeikis
\.


--
-- Data for Name: serija; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.serija (id, naziv, kreator, zanr, ocjena, godina_pocetka, godina_zavrsetka, broj_sezona, broj_epizoda, prosjecno_trajanje_epizode, zemlja) FROM stdin;
1	Breaking Bad	Vince Gilligan	Drama	9.5	2008	2013	5	62	48	SAD
2	Better Call Saul	Vince Gilligan	Drama	9.0	2015	2022	6	63	45	SAD
3	The Mentalist	Bruno Heller	Krimi	8.2	2008	2015	7	151	43	SAD
4	The Sopranos	David Chase	Krimi	9.2	1999	2007	6	86	55	SAD
5	Sherlock	Mark Gatiss	Krimi	9.0	2010	2017	4	15	90	Velika Britanija
6	Pluribus	Vince Gilligan	Znanstvena fantastika	7.9	2025	\N	1	10	60	SAD
7	The Office	Greg Daniels	Komedija	9.0	2005	2013	9	191	22	SAD
8	Dexter	James Manos Jr.	Krimi	8.6	2006	2013	8	96	60	SAD
9	Severance	Dan Erickson	Znanstvena fantastika	8.6	2022	\N	2	25	50	SAD
10	Ted Lasso	Brendan Hunt	Komedija	8.7	2020	\N	4	44	30	SAD
\.


--
-- Name: glavna_uloga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.glavna_uloga_id_seq', 10, true);


--
-- Name: serija_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.serija_id_seq', 10, true);


--
-- Name: glavna_uloga glavna_uloga_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.glavna_uloga
    ADD CONSTRAINT glavna_uloga_pkey PRIMARY KEY (id);


--
-- Name: serija serija_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serija
    ADD CONSTRAINT serija_pkey PRIMARY KEY (id);


--
-- Name: glavna_uloga glavna_uloga_serija_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.glavna_uloga
    ADD CONSTRAINT glavna_uloga_serija_id_fkey FOREIGN KEY (serija_id) REFERENCES public.serija(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict mZL9a8mVMaLvDBhtRdyIuXgjDeiyQKS72ltBNZtpySy05dUkiKoWjLXtk2UhvvW

