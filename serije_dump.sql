--
-- PostgreSQL database dump
--

\restrict ipgdcSCJCXJ31dibinjsb9QolQTMS6tH7pBplLZjdaiIdtWZ3ClIzaVXnHj5xWH

-- Dumped from database version 18.4 (Homebrew)
-- Dumped by pg_dump version 18.6 (Homebrew)

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
-- Name: mreza; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mreza (
    id integer NOT NULL,
    naziv character varying(100) NOT NULL,
    vrsta character varying(50) NOT NULL,
    CONSTRAINT mreza_vrsta_check CHECK (((vrsta)::text = ANY ((ARRAY['televizijska mreža'::character varying, 'streaming servis'::character varying])::text[])))
);


ALTER TABLE public.mreza OWNER TO postgres;

--
-- Name: mreza_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mreza_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mreza_id_seq OWNER TO postgres;

--
-- Name: mreza_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mreza_id_seq OWNED BY public.mreza.id;


--
-- Name: osoba; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.osoba (
    id integer NOT NULL,
    ime character varying(100) NOT NULL,
    prezime character varying(100) NOT NULL
);


ALTER TABLE public.osoba OWNER TO postgres;

--
-- Name: osoba_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.osoba_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.osoba_id_seq OWNER TO postgres;

--
-- Name: osoba_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.osoba_id_seq OWNED BY public.osoba.id;


--
-- Name: serija; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.serija (
    id integer NOT NULL,
    naziv character varying(200) NOT NULL,
    ocjena numeric(3,1),
    godina_pocetka integer NOT NULL,
    godina_zavrsetka integer,
    broj_sezona integer,
    broj_epizoda integer,
    prosjecno_trajanje_epizode integer,
    zemlja character varying(100) NOT NULL,
    mreza_id integer NOT NULL,
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
-- Name: serija_kreator; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.serija_kreator (
    serija_id integer NOT NULL,
    osoba_id integer NOT NULL
);


ALTER TABLE public.serija_kreator OWNER TO postgres;

--
-- Name: serija_zanr; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.serija_zanr (
    serija_id integer NOT NULL,
    zanr_id integer NOT NULL
);


ALTER TABLE public.serija_zanr OWNER TO postgres;

--
-- Name: uloga; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.uloga (
    id integer NOT NULL,
    serija_id integer NOT NULL,
    osoba_id integer NOT NULL,
    lik character varying(200) NOT NULL,
    redoslijed integer NOT NULL,
    CONSTRAINT uloga_redoslijed_check CHECK ((redoslijed > 0))
);


ALTER TABLE public.uloga OWNER TO postgres;

--
-- Name: uloga_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.uloga_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.uloga_id_seq OWNER TO postgres;

--
-- Name: uloga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.uloga_id_seq OWNED BY public.uloga.id;


--
-- Name: zanr; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.zanr (
    id integer NOT NULL,
    naziv character varying(50) NOT NULL
);


ALTER TABLE public.zanr OWNER TO postgres;

--
-- Name: zanr_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.zanr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.zanr_id_seq OWNER TO postgres;

--
-- Name: zanr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.zanr_id_seq OWNED BY public.zanr.id;


--
-- Name: mreza id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mreza ALTER COLUMN id SET DEFAULT nextval('public.mreza_id_seq'::regclass);


--
-- Name: osoba id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.osoba ALTER COLUMN id SET DEFAULT nextval('public.osoba_id_seq'::regclass);


--
-- Name: serija id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serija ALTER COLUMN id SET DEFAULT nextval('public.serija_id_seq'::regclass);


--
-- Name: uloga id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uloga ALTER COLUMN id SET DEFAULT nextval('public.uloga_id_seq'::regclass);


--
-- Name: zanr id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zanr ALTER COLUMN id SET DEFAULT nextval('public.zanr_id_seq'::regclass);


--
-- Data for Name: mreza; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mreza (id, naziv, vrsta) FROM stdin;
1	AMC	televizijska mreža
2	CBS	televizijska mreža
3	HBO	televizijska mreža
4	BBC One	televizijska mreža
5	Apple TV	streaming servis
6	NBC	televizijska mreža
7	Showtime	televizijska mreža
\.


--
-- Data for Name: osoba; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.osoba (id, ime, prezime) FROM stdin;
1	Vince	Gilligan
2	Peter	Gould
3	Bruno	Heller
4	David	Chase
5	Mark	Gatiss
6	Steven	Moffat
7	Greg	Daniels
8	James	Manos Jr.
9	Dan	Erickson
10	Jason	Sudeikis
11	Bill	Lawrence
12	Brendan	Hunt
13	Joe	Kelly
14	Bryan	Cranston
15	Aaron	Paul
16	Anna	Gunn
17	Bob	Odenkirk
18	Rhea	Seehorn
19	Jonathan	Banks
20	Simon	Baker
21	Robin	Tunney
22	Tim	Kang
23	James	Gandolfini
24	Edie	Falco
25	Michael	Imperioli
26	Benedict	Cumberbatch
27	Martin	Freeman
28	Una	Stubbs
29	Karolina	Wydra
30	Carlos-Manuel	Vesga
31	Steve	Carell
32	Rainn	Wilson
33	John	Krasinski
34	Michael C.	Hall
35	Jennifer	Carpenter
36	David	Zayas
37	Adam	Scott
38	Britt	Lower
39	John	Turturro
41	Hannah	Waddingham
\.


--
-- Data for Name: serija; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.serija (id, naziv, ocjena, godina_pocetka, godina_zavrsetka, broj_sezona, broj_epizoda, prosjecno_trajanje_epizode, zemlja, mreza_id) FROM stdin;
2	Better Call Saul	9.0	2015	2022	6	63	45	SAD	1
1	Breaking Bad	9.5	2008	2013	5	62	48	SAD	1
3	The Mentalist	8.2	2008	2015	7	151	43	SAD	2
4	The Sopranos	9.2	1999	2007	6	86	55	SAD	3
5	Sherlock	9.0	2010	2017	4	15	90	Velika Britanija	4
10	Ted Lasso	8.7	2020	\N	4	44	30	SAD	5
9	Severance	8.6	2022	\N	2	25	50	SAD	5
6	Pluribus	7.9	2025	\N	1	10	60	SAD	5
7	The Office	9.0	2005	2013	9	191	22	SAD	6
8	Dexter	8.6	2006	2013	8	96	60	SAD	7
\.


--
-- Data for Name: serija_kreator; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.serija_kreator (serija_id, osoba_id) FROM stdin;
2	2
2	1
1	1
3	3
4	4
5	6
5	5
10	13
10	12
10	11
10	10
9	9
6	1
7	7
8	8
\.


--
-- Data for Name: serija_zanr; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.serija_zanr (serija_id, zanr_id) FROM stdin;
8	1
6	1
9	1
10	1
5	1
4	1
3	1
1	1
2	1
8	2
5	2
4	2
3	2
1	2
2	2
8	3
9	3
1	3
5	4
3	4
7	5
10	5
6	6
9	6
10	7
\.


--
-- Data for Name: uloga; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.uloga (id, serija_id, osoba_id, lik, redoslijed) FROM stdin;
1	2	19	Mike Ehrmantraut	3
2	2	18	Kim Wexler	2
3	2	17	Jimmy McGill	1
4	1	16	Skyler White	3
5	1	15	Jesse Pinkman	2
6	1	14	Walter White	1
7	3	22	Kimball Cho	3
8	3	21	Teresa Lisbon	2
9	3	20	Patrick Jane	1
10	4	25	Christopher Moltisanti	3
11	4	24	Carmela Soprano	2
12	4	23	Tony Soprano	1
13	5	28	Mrs. Hudson	3
14	5	27	John Watson	2
15	5	26	Sherlock Holmes	1
16	10	41	Rebecca Welton	2
17	10	12	Coach Beard	3
18	10	10	Ted Lasso	1
19	9	39	Irving Bailiff	3
20	9	38	Helly R.	2
21	9	37	Mark Scout	1
22	6	30	Manousos Oviedo	3
23	6	29	Zosia	2
24	6	18	Carol Sturka	1
25	7	33	Jim Halpert	3
26	7	32	Dwight Schrute	2
27	7	31	Michael Scott	1
28	8	36	Angel Batista	3
29	8	35	Debra Morgan	2
30	8	34	Dexter Morgan	1
\.


--
-- Data for Name: zanr; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.zanr (id, naziv) FROM stdin;
1	Drama
2	Krimi
3	Triler
4	Misterij
5	Komedija
6	Znanstvena fantastika
7	Sport
\.


--
-- Name: mreza_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mreza_id_seq', 7, true);


--
-- Name: osoba_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.osoba_id_seq', 42, true);


--
-- Name: serija_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.serija_id_seq', 10, true);


--
-- Name: uloga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.uloga_id_seq', 30, true);


--
-- Name: zanr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.zanr_id_seq', 7, true);


--
-- Name: mreza mreza_naziv_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mreza
    ADD CONSTRAINT mreza_naziv_key UNIQUE (naziv);


--
-- Name: mreza mreza_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mreza
    ADD CONSTRAINT mreza_pkey PRIMARY KEY (id);


--
-- Name: osoba osoba_ime_prezime_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.osoba
    ADD CONSTRAINT osoba_ime_prezime_key UNIQUE (ime, prezime);


--
-- Name: osoba osoba_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.osoba
    ADD CONSTRAINT osoba_pkey PRIMARY KEY (id);


--
-- Name: serija_kreator serija_kreator_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serija_kreator
    ADD CONSTRAINT serija_kreator_pkey PRIMARY KEY (serija_id, osoba_id);


--
-- Name: serija serija_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serija
    ADD CONSTRAINT serija_pkey PRIMARY KEY (id);


--
-- Name: serija_zanr serija_zanr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serija_zanr
    ADD CONSTRAINT serija_zanr_pkey PRIMARY KEY (serija_id, zanr_id);


--
-- Name: uloga uloga_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uloga
    ADD CONSTRAINT uloga_pkey PRIMARY KEY (id);


--
-- Name: uloga uloga_serija_id_osoba_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uloga
    ADD CONSTRAINT uloga_serija_id_osoba_id_key UNIQUE (serija_id, osoba_id);


--
-- Name: uloga uloga_serija_id_redoslijed_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uloga
    ADD CONSTRAINT uloga_serija_id_redoslijed_key UNIQUE (serija_id, redoslijed);


--
-- Name: zanr zanr_naziv_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zanr
    ADD CONSTRAINT zanr_naziv_key UNIQUE (naziv);


--
-- Name: zanr zanr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.zanr
    ADD CONSTRAINT zanr_pkey PRIMARY KEY (id);


--
-- Name: serija_kreator serija_kreator_osoba_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serija_kreator
    ADD CONSTRAINT serija_kreator_osoba_id_fkey FOREIGN KEY (osoba_id) REFERENCES public.osoba(id);


--
-- Name: serija_kreator serija_kreator_serija_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serija_kreator
    ADD CONSTRAINT serija_kreator_serija_id_fkey FOREIGN KEY (serija_id) REFERENCES public.serija(id) ON DELETE CASCADE;


--
-- Name: serija serija_mreza_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serija
    ADD CONSTRAINT serija_mreza_id_fkey FOREIGN KEY (mreza_id) REFERENCES public.mreza(id);


--
-- Name: serija_zanr serija_zanr_serija_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serija_zanr
    ADD CONSTRAINT serija_zanr_serija_id_fkey FOREIGN KEY (serija_id) REFERENCES public.serija(id) ON DELETE CASCADE;


--
-- Name: serija_zanr serija_zanr_zanr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.serija_zanr
    ADD CONSTRAINT serija_zanr_zanr_id_fkey FOREIGN KEY (zanr_id) REFERENCES public.zanr(id);


--
-- Name: uloga uloga_osoba_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uloga
    ADD CONSTRAINT uloga_osoba_id_fkey FOREIGN KEY (osoba_id) REFERENCES public.osoba(id);


--
-- Name: uloga uloga_serija_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uloga
    ADD CONSTRAINT uloga_serija_id_fkey FOREIGN KEY (serija_id) REFERENCES public.serija(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict ipgdcSCJCXJ31dibinjsb9QolQTMS6tH7pBplLZjdaiIdtWZ3ClIzaVXnHj5xWH

