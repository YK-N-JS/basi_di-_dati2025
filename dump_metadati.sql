--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

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
-- Name: createdefaultbachechefunction(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.createdefaultbachechefunction() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
            BEGIN
            INSERT INTO bacheca (title, description, "Owner", isDefault)
            values 
            ('Default', 'your default bacheca', new.username, true),
            ('Università', 'your university bacheca', new.username, false),
            ('Lavoro', 'your job bacheca', new.username, false),
            ('Tempo libero', 'your free time bacheca', new.username, false);
            RETURN NULL;
            END;
            $$;


ALTER FUNCTION public.createdefaultbachechefunction() OWNER TO postgres;

--
-- Name: removetodofunction(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.removetodofunction() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

            DECLARE
            temporaneo1 varchar(100);
            temporaneo2 varchar(100);

            BEGIN
            Select "Owner" into temporaneo1
            From bacheca
            where bacheca."ID" = OLD.IDBacheca;

            Select "Owner" into temporaneo2
            From todo 
            Where todo."ID" = OLD.IDToDo;

            IF temporaneo1 LIKE temporaneo2 THEN
            Delete from todo where todo."ID" = OLD.IDToDo;
            END IF;
            RETURN OLD;
            END;
            $$;


ALTER FUNCTION public.removetodofunction() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bacheca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bacheca (
    "ID" integer NOT NULL,
    title character varying(100),
    description character varying(1000),
    "Owner" character varying(100),
    isdefault boolean DEFAULT false
);


ALTER TABLE public.bacheca OWNER TO postgres;

--
-- Name: bacheca_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.bacheca ALTER COLUMN "ID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."bacheca_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: placement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.placement (
    idbacheca integer NOT NULL,
    idtodo integer NOT NULL
);


ALTER TABLE public.placement OWNER TO postgres;

--
-- Name: todo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.todo (
    "ID" integer NOT NULL,
    title character varying(100),
    url character varying(256),
    description character varying(1000),
    "Owner" character varying(100),
    icon integer DEFAULT 0,
    color integer,
    complete_by_date date,
    completed boolean
);


ALTER TABLE public.todo OWNER TO postgres;

--
-- Name: todo_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.todo ALTER COLUMN "ID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."todo_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    username character varying(100) NOT NULL,
    "Password" character varying(100) NOT NULL,
    num_max_bacheche integer DEFAULT 10
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Data for Name: bacheca; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bacheca ("ID", title, description, "Owner", isdefault) FROM stdin;
\.


--
-- Data for Name: placement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.placement (idbacheca, idtodo) FROM stdin;
\.


--
-- Data for Name: todo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.todo ("ID", title, url, description, "Owner", icon, color, complete_by_date, completed) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (username, "Password", num_max_bacheche) FROM stdin;
\.


--
-- Name: bacheca_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."bacheca_ID_seq"', 1, false);


--
-- Name: todo_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."todo_ID_seq"', 1, false);


--
-- Name: bacheca bacheca_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bacheca
    ADD CONSTRAINT bacheca_pkey PRIMARY KEY ("ID");


--
-- Name: placement placement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.placement
    ADD CONSTRAINT placement_pkey PRIMARY KEY (idbacheca, idtodo);


--
-- Name: todo todo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.todo
    ADD CONSTRAINT todo_pkey PRIMARY KEY ("ID");


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (username);


--
-- Name: user createdefaultbacheche; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER createdefaultbacheche AFTER INSERT ON public."user" FOR EACH ROW EXECUTE FUNCTION public.createdefaultbachechefunction();


--
-- Name: placement removetodo; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER removetodo AFTER DELETE ON public.placement FOR EACH ROW EXECUTE FUNCTION public.removetodofunction();


--
-- Name: bacheca bacheca_Owner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bacheca
    ADD CONSTRAINT "bacheca_Owner_fkey" FOREIGN KEY ("Owner") REFERENCES public."user"(username) ON DELETE CASCADE;


--
-- Name: placement placement_idbacheca_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.placement
    ADD CONSTRAINT placement_idbacheca_fkey FOREIGN KEY (idbacheca) REFERENCES public.bacheca("ID") ON DELETE CASCADE;


--
-- Name: placement placement_idtodo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.placement
    ADD CONSTRAINT placement_idtodo_fkey FOREIGN KEY (idtodo) REFERENCES public.todo("ID") ON DELETE CASCADE;


--
-- Name: todo todo_Owner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.todo
    ADD CONSTRAINT "todo_Owner_fkey" FOREIGN KEY ("Owner") REFERENCES public."user"(username) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

