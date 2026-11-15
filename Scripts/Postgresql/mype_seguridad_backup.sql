--
-- PostgreSQL database dump
--

\restrict GaMTFqbPNCQc5EZVGzvc8RSmU2etZnjLrSsWh18eWyAaXTPP2vVKIG35bMXL34C

-- Dumped from database version 17.11
-- Dumped by pg_dump version 17.11

-- Started on 2026-11-03 09:05:09

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
-- TOC entry 233 (class 1255 OID 24782)
-- Name: fn_evaluar_dias_restantes_suscripcion(integer); Type: FUNCTION; Schema: public; Owner: zorrilla
--

CREATE FUNCTION public.fn_evaluar_dias_restantes_suscripcion(p_id_suscripcion integer, OUT dias_restantes integer, OUT estado_alerta text) RETURNS record
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_fecha_fin TIMESTAMP;
    v_estado VARCHAR(20);
BEGIN
    SELECT fecha_fin, estado_pago
    INTO v_fecha_fin, v_estado
    FROM public.suscripcion
    WHERE id_suscripcion = p_id_suscripcion;
 
    IF NOT FOUND THEN
        RAISE EXCEPTION 'La suscripción con ID % no existe.', p_id_suscripcion;
    END IF;
 
    dias_restantes := DATE_PART('day', v_fecha_fin - CURRENT_TIMESTAMP)::INT;
 
    IF dias_restantes < 0 THEN
        estado_alerta := 'CRÍTICO: Suscripción vencida (Corte de servicio)';
    ELSIF dias_restantes <= 7 THEN
        estado_alerta := 'URGENTE: Próximo a vencer (Renovación requerida)';
    ELSIF dias_restantes <= 15 THEN
        estado_alerta := 'ADVERTENCIA: Renovar próximamente';
    ELSE
        estado_alerta := 'COBERTURA VIGENTE';
    END IF;
END;
$$;


ALTER FUNCTION public.fn_evaluar_dias_restantes_suscripcion(p_id_suscripcion integer, OUT dias_restantes integer, OUT estado_alerta text) OWNER TO zorrilla;

--
-- TOC entry 232 (class 1255 OID 24779)
-- Name: fn_obtener_igv_comerciante(integer); Type: FUNCTION; Schema: public; Owner: romero
--

CREATE FUNCTION public.fn_obtener_igv_comerciante(p_id_comerciante integer) RETURNS numeric
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
    c_igv_contingencia CONSTANT NUMERIC(4,2) := 18.00;
    v_igv NUMERIC(4,2);
BEGIN
    IF p_id_comerciante IS NULL THEN
        RETURN c_igv_contingencia;
    END IF;

    SELECT igv_porcentaje
    INTO v_igv
    FROM public.configuracion
    WHERE comerciante_id_comerciante = p_id_comerciante;

    
    IF NOT FOUND OR v_igv IS NULL THEN
        RETURN c_igv_contingencia;
    END IF;

    RETURN v_igv;
END;
$$;


ALTER FUNCTION public.fn_obtener_igv_comerciante(p_id_comerciante integer) OWNER TO romero;

--
-- TOC entry 231 (class 1255 OID 24777)
-- Name: fn_registrar_acceso_llanos(integer, character varying); Type: FUNCTION; Schema: public; Owner: llanos
--

CREATE FUNCTION public.fn_registrar_acceso_llanos(p_id_empleado integer, p_dispositivo character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Validar la integridad referencial antes de auditar el acceso
    IF EXISTS (SELECT 1 FROM public.empleado WHERE id_empleado = p_id_empleado) THEN
        INSERT INTO public.historial_login (dispositivo, empleado_id_empleado) 
        VALUES (p_dispositivo, p_id_empleado);
    ELSE
        RAISE EXCEPTION 'Error de seguridad: El ID de empleado % no existe.', p_id_empleado;
    END IF;
END;
$$;


ALTER FUNCTION public.fn_registrar_acceso_llanos(p_id_empleado integer, p_dispositivo character varying) OWNER TO llanos;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 24668)
-- Name: comerciante; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comerciante (
    id_comerciante integer NOT NULL,
    ruc character varying(11) NOT NULL,
    nombre_comcercial character varying(150) NOT NULL,
    razon_social character varying(150) NOT NULL,
    telefono character varying(9) NOT NULL,
    fecha_registro timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.comerciante OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24667)
-- Name: comerciante_id_comerciante_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.comerciante ALTER COLUMN id_comerciante ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.comerciante_id_comerciante_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 24679)
-- Name: configuracion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.configuracion (
    id_configuracion integer NOT NULL,
    moneda character varying(3) DEFAULT 'PEN'::character varying NOT NULL,
    igv_porcentaje numeric(4,2) DEFAULT 18.00 NOT NULL,
    comerciante_id_comerciante integer NOT NULL
);


ALTER TABLE public.configuracion OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24678)
-- Name: configuracion_id_configuracion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.configuracion ALTER COLUMN id_configuracion ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.configuracion_id_configuracion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 24688)
-- Name: empleado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empleado (
    id_empleado integer NOT NULL,
    dni character varying(8) NOT NULL,
    nombres character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    correo character varying(100) NOT NULL,
    clave character varying(255) NOT NULL,
    estado boolean NOT NULL,
    rol_id_rol integer NOT NULL,
    sucursal_id_sucursal integer NOT NULL
);


ALTER TABLE public.empleado OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24687)
-- Name: empleado_id_empleado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.empleado ALTER COLUMN id_empleado ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.empleado_id_empleado_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 230 (class 1259 OID 24715)
-- Name: historial_login; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historial_login (
    id_log integer NOT NULL,
    fecha_hora timestamp without time zone DEFAULT now() NOT NULL,
    dispositivo character varying(150) NOT NULL,
    empleado_id_empleado integer NOT NULL
);


ALTER TABLE public.historial_login OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 24714)
-- Name: historial_login_id_log_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.historial_login ALTER COLUMN id_log ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.historial_login_id_log_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 24658)
-- Name: rol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rol (
    id_rol integer NOT NULL,
    nombre_rol character varying(50) NOT NULL,
    descripcion text NOT NULL
);


ALTER TABLE public.rol OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24657)
-- Name: rol_id_rol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.rol ALTER COLUMN id_rol ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.rol_id_rol_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 24700)
-- Name: sucursal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sucursal (
    id_sucursal integer NOT NULL,
    nombre_sucursal character varying(100) NOT NULL,
    direccion character varying(250) NOT NULL,
    comerciante_id_comerciante integer NOT NULL
);


ALTER TABLE public.sucursal OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24699)
-- Name: sucursal_id_sucursal_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.sucursal ALTER COLUMN id_sucursal ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.sucursal_id_sucursal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 24708)
-- Name: suscripcion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suscripcion (
    id_suscripcion integer NOT NULL,
    tipo_plan character varying(50) NOT NULL,
    fecha_inicio date DEFAULT now() NOT NULL,
    fecha_fin date NOT NULL,
    estado_pago character varying(20) NOT NULL,
    comerciante_id_comerciante integer NOT NULL
);


ALTER TABLE public.suscripcion OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 24707)
-- Name: suscripcion_id_suscripcion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.suscripcion ALTER COLUMN id_suscripcion ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.suscripcion_id_suscripcion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 4967 (class 0 OID 24668)
-- Dependencies: 220
-- Data for Name: comerciante; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comerciante (id_comerciante, ruc, nombre_comcercial, razon_social, telefono, fecha_registro) FROM stdin;
1	20601234561	Minimarket Don Lucho	Inversiones Comerciales Lucho S.A.C.	912345678	2026-09-19 16:12:53.042136
2	20559876542	Boutique Mía	Corporación Textil Moda del Perú E.I.R.L.	987654321	2026-09-19 16:12:53.042136
3	20441122333	TecnoWilson	Importaciones Tecnológicas del Centro S.A.	944556677	2026-09-19 16:12:53.042136
11	20010000001	Comercio Romero 1	Romero Inversiones S.A.C. 1	900000001	2026-11-02 08:35:01.485496
12	20010000002	Comercio Romero 2	Romero Inversiones S.A.C. 2	900000002	2026-11-01 08:35:01.485496
13	20010000003	Comercio Romero 3	Romero Inversiones S.A.C. 3	900000003	2026-10-31 08:35:01.485496
14	20010000004	Comercio Romero 4	Romero Inversiones S.A.C. 4	900000004	2026-10-30 08:35:01.485496
15	20010000005	Comercio Romero 5	Romero Inversiones S.A.C. 5	900000005	2026-10-29 08:35:01.485496
16	20010000006	Comercio Romero 6	Romero Inversiones S.A.C. 6	900000006	2026-10-28 08:35:01.485496
17	20010000007	Comercio Romero 7	Romero Inversiones S.A.C. 7	900000007	2026-10-27 08:35:01.485496
18	20010000008	Comercio Romero 8	Romero Inversiones S.A.C. 8	900000008	2026-10-26 08:35:01.485496
19	20010000009	Comercio Romero 9	Romero Inversiones S.A.C. 9	900000009	2026-10-25 08:35:01.485496
20	20010000010	Comercio Romero 10	Romero Inversiones S.A.C. 10	900000010	2026-10-24 08:35:01.485496
21	20010000011	Comercio Romero 11	Romero Inversiones S.A.C. 11	900000011	2026-10-23 08:35:01.485496
22	20010000012	Comercio Romero 12	Romero Inversiones S.A.C. 12	900000012	2026-10-22 08:35:01.485496
23	20010000013	Comercio Romero 13	Romero Inversiones S.A.C. 13	900000013	2026-10-21 08:35:01.485496
24	20010000014	Comercio Romero 14	Romero Inversiones S.A.C. 14	900000014	2026-10-20 08:35:01.485496
25	20010000015	Comercio Romero 15	Romero Inversiones S.A.C. 15	900000015	2026-10-19 08:35:01.485496
26	20010000016	Comercio Romero 16	Romero Inversiones S.A.C. 16	900000016	2026-10-18 08:35:01.485496
27	20010000017	Comercio Romero 17	Romero Inversiones S.A.C. 17	900000017	2026-10-17 08:35:01.485496
28	20010000018	Comercio Romero 18	Romero Inversiones S.A.C. 18	900000018	2026-10-16 08:35:01.485496
29	20010000019	Comercio Romero 19	Romero Inversiones S.A.C. 19	900000019	2026-10-15 08:35:01.485496
30	20010000020	Comercio Romero 20	Romero Inversiones S.A.C. 20	900000020	2026-10-14 08:35:01.485496
31	20010000021	Comercio Romero 21	Romero Inversiones S.A.C. 21	900000021	2026-10-13 08:35:01.485496
32	20010000022	Comercio Romero 22	Romero Inversiones S.A.C. 22	900000022	2026-10-12 08:35:01.485496
33	20010000023	Comercio Romero 23	Romero Inversiones S.A.C. 23	900000023	2026-10-11 08:35:01.485496
34	20010000024	Comercio Romero 24	Romero Inversiones S.A.C. 24	900000024	2026-10-10 08:35:01.485496
35	20010000025	Comercio Romero 25	Romero Inversiones S.A.C. 25	900000025	2026-10-09 08:35:01.485496
36	20010000026	Comercio Romero 26	Romero Inversiones S.A.C. 26	900000026	2026-10-08 08:35:01.485496
37	20010000027	Comercio Romero 27	Romero Inversiones S.A.C. 27	900000027	2026-10-07 08:35:01.485496
38	20010000028	Comercio Romero 28	Romero Inversiones S.A.C. 28	900000028	2026-10-06 08:35:01.485496
39	20010000029	Comercio Romero 29	Romero Inversiones S.A.C. 29	900000029	2026-10-05 08:35:01.485496
40	20010000030	Comercio Romero 30	Romero Inversiones S.A.C. 30	900000030	2026-10-04 08:35:01.485496
41	20010000031	Comercio Romero 31	Romero Inversiones S.A.C. 31	900000031	2026-10-03 08:35:01.485496
42	20010000032	Comercio Romero 32	Romero Inversiones S.A.C. 32	900000032	2026-10-02 08:35:01.485496
43	20010000033	Comercio Romero 33	Romero Inversiones S.A.C. 33	900000033	2026-10-01 08:35:01.485496
44	20010000034	Comercio Romero 34	Romero Inversiones S.A.C. 34	900000034	2026-09-30 08:35:01.485496
45	20010000035	Comercio Romero 35	Romero Inversiones S.A.C. 35	900000035	2026-09-29 08:35:01.485496
46	20010000036	Comercio Romero 36	Romero Inversiones S.A.C. 36	900000036	2026-09-28 08:35:01.485496
47	20010000037	Comercio Romero 37	Romero Inversiones S.A.C. 37	900000037	2026-09-27 08:35:01.485496
48	20010000038	Comercio Romero 38	Romero Inversiones S.A.C. 38	900000038	2026-09-26 08:35:01.485496
49	20010000039	Comercio Romero 39	Romero Inversiones S.A.C. 39	900000039	2026-09-25 08:35:01.485496
50	20010000040	Comercio Romero 40	Romero Inversiones S.A.C. 40	900000040	2026-09-24 08:35:01.485496
51	20010000041	Comercio Romero 41	Romero Inversiones S.A.C. 41	900000041	2026-09-23 08:35:01.485496
52	20010000042	Comercio Romero 42	Romero Inversiones S.A.C. 42	900000042	2026-09-22 08:35:01.485496
53	20010000043	Comercio Romero 43	Romero Inversiones S.A.C. 43	900000043	2026-09-21 08:35:01.485496
54	20010000044	Comercio Romero 44	Romero Inversiones S.A.C. 44	900000044	2026-09-20 08:35:01.485496
55	20010000045	Comercio Romero 45	Romero Inversiones S.A.C. 45	900000045	2026-09-19 08:35:01.485496
56	20010000046	Comercio Romero 46	Romero Inversiones S.A.C. 46	900000046	2026-09-18 08:35:01.485496
57	20010000047	Comercio Romero 47	Romero Inversiones S.A.C. 47	900000047	2026-09-17 08:35:01.485496
58	20010000048	Comercio Romero 48	Romero Inversiones S.A.C. 48	900000048	2026-09-16 08:35:01.485496
59	20010000049	Comercio Romero 49	Romero Inversiones S.A.C. 49	900000049	2026-09-15 08:35:01.485496
60	20010000050	Comercio Romero 50	Romero Inversiones S.A.C. 50	900000050	2026-09-14 08:35:01.485496
61	20010000051	Comercio Romero 51	Romero Inversiones S.A.C. 51	900000051	2026-09-13 08:35:01.485496
62	20010000052	Comercio Romero 52	Romero Inversiones S.A.C. 52	900000052	2026-09-12 08:35:01.485496
63	20010000053	Comercio Romero 53	Romero Inversiones S.A.C. 53	900000053	2026-09-11 08:35:01.485496
64	20010000054	Comercio Romero 54	Romero Inversiones S.A.C. 54	900000054	2026-09-10 08:35:01.485496
65	20010000055	Comercio Romero 55	Romero Inversiones S.A.C. 55	900000055	2026-09-09 08:35:01.485496
66	20010000056	Comercio Romero 56	Romero Inversiones S.A.C. 56	900000056	2026-09-08 08:35:01.485496
67	20010000057	Comercio Romero 57	Romero Inversiones S.A.C. 57	900000057	2026-09-07 08:35:01.485496
68	20010000058	Comercio Romero 58	Romero Inversiones S.A.C. 58	900000058	2026-09-06 08:35:01.485496
69	20010000059	Comercio Romero 59	Romero Inversiones S.A.C. 59	900000059	2026-09-05 08:35:01.485496
70	20010000060	Comercio Romero 60	Romero Inversiones S.A.C. 60	900000060	2026-09-04 08:35:01.485496
71	20010000061	Comercio Romero 61	Romero Inversiones S.A.C. 61	900000061	2026-09-03 08:35:01.485496
72	20010000062	Comercio Romero 62	Romero Inversiones S.A.C. 62	900000062	2026-09-02 08:35:01.485496
73	20010000063	Comercio Romero 63	Romero Inversiones S.A.C. 63	900000063	2026-09-01 08:35:01.485496
74	20010000064	Comercio Romero 64	Romero Inversiones S.A.C. 64	900000064	2026-08-31 08:35:01.485496
75	20010000065	Comercio Romero 65	Romero Inversiones S.A.C. 65	900000065	2026-08-30 08:35:01.485496
76	20010000066	Comercio Romero 66	Romero Inversiones S.A.C. 66	900000066	2026-08-29 08:35:01.485496
77	20010000067	Comercio Romero 67	Romero Inversiones S.A.C. 67	900000067	2026-08-28 08:35:01.485496
78	20010000068	Comercio Romero 68	Romero Inversiones S.A.C. 68	900000068	2026-08-27 08:35:01.485496
79	20010000069	Comercio Romero 69	Romero Inversiones S.A.C. 69	900000069	2026-08-26 08:35:01.485496
80	20010000070	Comercio Romero 70	Romero Inversiones S.A.C. 70	900000070	2026-08-25 08:35:01.485496
81	20010000071	Comercio Romero 71	Romero Inversiones S.A.C. 71	900000071	2026-08-24 08:35:01.485496
82	20010000072	Comercio Romero 72	Romero Inversiones S.A.C. 72	900000072	2026-08-23 08:35:01.485496
83	20010000073	Comercio Romero 73	Romero Inversiones S.A.C. 73	900000073	2026-08-22 08:35:01.485496
84	20010000074	Comercio Romero 74	Romero Inversiones S.A.C. 74	900000074	2026-08-21 08:35:01.485496
85	20010000075	Comercio Romero 75	Romero Inversiones S.A.C. 75	900000075	2026-08-20 08:35:01.485496
86	20010000076	Comercio Romero 76	Romero Inversiones S.A.C. 76	900000076	2026-08-19 08:35:01.485496
87	20010000077	Comercio Romero 77	Romero Inversiones S.A.C. 77	900000077	2026-08-18 08:35:01.485496
88	20010000078	Comercio Romero 78	Romero Inversiones S.A.C. 78	900000078	2026-08-17 08:35:01.485496
89	20010000079	Comercio Romero 79	Romero Inversiones S.A.C. 79	900000079	2026-08-16 08:35:01.485496
90	20010000080	Comercio Romero 80	Romero Inversiones S.A.C. 80	900000080	2026-08-15 08:35:01.485496
91	20010000081	Comercio Romero 81	Romero Inversiones S.A.C. 81	900000081	2026-08-14 08:35:01.485496
92	20010000082	Comercio Romero 82	Romero Inversiones S.A.C. 82	900000082	2026-08-13 08:35:01.485496
93	20010000083	Comercio Romero 83	Romero Inversiones S.A.C. 83	900000083	2026-08-12 08:35:01.485496
94	20010000084	Comercio Romero 84	Romero Inversiones S.A.C. 84	900000084	2026-08-11 08:35:01.485496
95	20010000085	Comercio Romero 85	Romero Inversiones S.A.C. 85	900000085	2026-08-10 08:35:01.485496
96	20010000086	Comercio Romero 86	Romero Inversiones S.A.C. 86	900000086	2026-08-09 08:35:01.485496
97	20010000087	Comercio Romero 87	Romero Inversiones S.A.C. 87	900000087	2026-08-08 08:35:01.485496
98	20010000088	Comercio Romero 88	Romero Inversiones S.A.C. 88	900000088	2026-08-07 08:35:01.485496
99	20010000089	Comercio Romero 89	Romero Inversiones S.A.C. 89	900000089	2026-08-06 08:35:01.485496
100	20010000090	Comercio Romero 90	Romero Inversiones S.A.C. 90	900000090	2026-08-05 08:35:01.485496
101	20010000091	Comercio Romero 91	Romero Inversiones S.A.C. 91	900000091	2026-08-04 08:35:01.485496
102	20010000092	Comercio Romero 92	Romero Inversiones S.A.C. 92	900000092	2026-08-03 08:35:01.485496
103	20010000093	Comercio Romero 93	Romero Inversiones S.A.C. 93	900000093	2026-08-02 08:35:01.485496
104	20010000094	Comercio Romero 94	Romero Inversiones S.A.C. 94	900000094	2026-08-01 08:35:01.485496
105	20010000095	Comercio Romero 95	Romero Inversiones S.A.C. 95	900000095	2026-07-31 08:35:01.485496
106	20010000096	Comercio Romero 96	Romero Inversiones S.A.C. 96	900000096	2026-07-30 08:35:01.485496
107	20010000097	Comercio Romero 97	Romero Inversiones S.A.C. 97	900000097	2026-07-29 08:35:01.485496
108	20010000098	Comercio Romero 98	Romero Inversiones S.A.C. 98	900000098	2026-07-28 08:35:01.485496
109	20010000099	Comercio Romero 99	Romero Inversiones S.A.C. 99	900000099	2026-07-27 08:35:01.485496
110	20010000100	Comercio Romero 100	Romero Inversiones S.A.C. 100	900000100	2026-07-26 08:35:01.485496
\.


--
-- TOC entry 4969 (class 0 OID 24679)
-- Dependencies: 222
-- Data for Name: configuracion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.configuracion (id_configuracion, moneda, igv_porcentaje, comerciante_id_comerciante) FROM stdin;
1	PEN	18.00	1
2	PEN	18.00	2
3	USD	18.00	3
11	PEN	18.00	11
12	PEN	18.00	12
13	PEN	18.00	13
14	PEN	18.00	14
15	PEN	18.00	15
16	PEN	18.00	16
17	PEN	18.00	17
18	PEN	18.00	18
19	PEN	18.00	19
20	USD	18.00	20
21	PEN	18.00	21
22	PEN	18.00	22
23	PEN	18.00	23
24	PEN	18.00	24
25	PEN	18.00	25
26	PEN	18.00	26
27	PEN	18.00	27
28	PEN	18.00	28
29	PEN	18.00	29
30	USD	18.00	30
31	PEN	18.00	31
32	PEN	18.00	32
33	PEN	18.00	33
34	PEN	18.00	34
35	PEN	18.00	35
36	PEN	18.00	36
37	PEN	18.00	37
38	PEN	18.00	38
39	PEN	18.00	39
40	USD	18.00	40
41	PEN	18.00	41
42	PEN	18.00	42
43	PEN	18.00	43
44	PEN	18.00	44
45	PEN	18.00	45
46	PEN	18.00	46
47	PEN	18.00	47
48	PEN	18.00	48
49	PEN	18.00	49
50	USD	18.00	50
51	PEN	18.00	51
52	PEN	18.00	52
53	PEN	18.00	53
54	PEN	18.00	54
55	PEN	18.00	55
56	PEN	18.00	56
57	PEN	18.00	57
58	PEN	18.00	58
59	PEN	18.00	59
60	USD	18.00	60
61	PEN	18.00	61
62	PEN	18.00	62
63	PEN	18.00	63
64	PEN	18.00	64
65	PEN	18.00	65
66	PEN	18.00	66
67	PEN	18.00	67
68	PEN	18.00	68
69	PEN	18.00	69
70	USD	18.00	70
71	PEN	18.00	71
72	PEN	18.00	72
73	PEN	18.00	73
74	PEN	18.00	74
75	PEN	18.00	75
76	PEN	18.00	76
77	PEN	18.00	77
78	PEN	18.00	78
79	PEN	18.00	79
80	USD	18.00	80
81	PEN	18.00	81
82	PEN	18.00	82
83	PEN	18.00	83
84	PEN	18.00	84
85	PEN	18.00	85
86	PEN	18.00	86
87	PEN	18.00	87
88	PEN	18.00	88
89	PEN	18.00	89
90	USD	18.00	90
91	PEN	18.00	91
92	PEN	18.00	92
93	PEN	18.00	93
94	PEN	18.00	94
95	PEN	18.00	95
96	PEN	18.00	96
97	PEN	18.00	97
98	PEN	18.00	98
99	PEN	18.00	99
100	USD	18.00	100
101	PEN	18.00	101
102	PEN	18.00	102
103	PEN	18.00	103
104	PEN	18.00	104
105	PEN	18.00	105
106	PEN	18.00	106
107	PEN	18.00	107
108	PEN	18.00	108
109	PEN	18.00	109
110	USD	18.00	110
\.


--
-- TOC entry 4971 (class 0 OID 24688)
-- Dependencies: 224
-- Data for Name: empleado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.empleado (id_empleado, dni, nombres, apellidos, correo, clave, estado, rol_id_rol, sucursal_id_sucursal) FROM stdin;
1	45678901	Luis Alberto	Mendoza Castro	luis.mendoza@donlucho.com	hash_secure_password_1	t	1	1
2	71234567	Carlos Ivan	Gomez Rivas	carlos.gomez@donlucho.com	hash_secure_password_2	t	2	2
3	72345678	Ana Maria	Palacios Quispe	ana.palacios@donlucho.com	hash_secure_password_3	t	3	1
4	73456789	Pedro Jose	Huaman Ortiz	pedro.huaman@donlucho.com	hash_secure_password_4	t	3	2
5	40112233	Milagros Elena	Salazar Paz	m.salazar@boutiquemia.pe	hash_secure_password_5	t	1	3
6	41223344	Sofia Belen	Díaz Torres	s.diaz@boutiquemia.pe	hash_secure_password_6	t	2	4
7	42334455	Jorge Luis	Guerrero Flores	j.guerrero@boutiquemia.pe	hash_secure_password_7	t	3	3
8	43445566	Elena Maria	Benites Soto	e.benites@boutiquemia.pe	hash_secure_password_8	f	3	4
9	46556677	Ricardo Alfonzo	Vargas Luna	rvargas@tecnowilson.com	hash_secure_password_9	t	1	5
10	47667788	Christian David	Zegarra Rios	czegarra@tecnowilson.com	hash_secure_password_10	t	3	5
\.


--
-- TOC entry 4977 (class 0 OID 24715)
-- Dependencies: 230
-- Data for Name: historial_login; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historial_login (id_log, fecha_hora, dispositivo, empleado_id_empleado) FROM stdin;
1	2026-09-19 08:00:23	Windows 11 - Chrome V120	1
2	2026-09-19 08:15:10	Android 14 - App Mobile	2
3	2026-09-19 08:30:00	Windows 10 - Edge V119	3
4	2026-09-19 08:45:12	Windows 11 - Chrome V120	4
5	2026-09-19 09:00:05	macOS Sonoma - Safari V17	5
6	2026-09-19 09:05:44	iOS 17 - App Mobile	6
7	2026-09-19 09:15:30	Windows 10 - Chrome V120	7
8	2026-09-19 09:30:18	Windows 11 - Firefox V121	9
9	2026-09-19 09:45:00	Windows 11 - Chrome V120	10
10	2026-09-19 14:22:15	Windows 11 - Chrome V120	1
11	2026-09-22 17:52:21.197757	Android App - Xiaomi Redmi Note 13	1
12	2026-11-03 06:35:01.485496	Android 15 - App Mobile llanos	2
13	2026-11-03 04:35:01.485496	Windows 11 - Chrome V126	3
14	2026-11-03 02:35:01.485496	Android 15 - App Mobile llanos	4
15	2026-11-03 00:35:01.485496	Windows 11 - Chrome V126	5
16	2026-11-02 22:35:01.485496	Android 15 - App Mobile llanos	6
17	2026-11-02 20:35:01.485496	Windows 11 - Chrome V126	7
18	2026-11-02 18:35:01.485496	Android 15 - App Mobile llanos	8
19	2026-11-02 16:35:01.485496	Windows 11 - Chrome V126	9
20	2026-11-02 14:35:01.485496	Android 15 - App Mobile llanos	10
21	2026-11-02 12:35:01.485496	Windows 11 - Chrome V126	1
22	2026-11-02 10:35:01.485496	Android 15 - App Mobile llanos	2
23	2026-11-02 08:35:01.485496	Windows 11 - Chrome V126	3
24	2026-11-02 06:35:01.485496	Android 15 - App Mobile llanos	4
25	2026-11-02 04:35:01.485496	Windows 11 - Chrome V126	5
26	2026-11-02 02:35:01.485496	Android 15 - App Mobile llanos	6
27	2026-11-02 00:35:01.485496	Windows 11 - Chrome V126	7
28	2026-11-01 22:35:01.485496	Android 15 - App Mobile llanos	8
29	2026-11-01 20:35:01.485496	Windows 11 - Chrome V126	9
30	2026-11-01 18:35:01.485496	Android 15 - App Mobile llanos	10
31	2026-11-01 16:35:01.485496	Windows 11 - Chrome V126	1
32	2026-11-01 14:35:01.485496	Android 15 - App Mobile llanos	2
33	2026-11-01 12:35:01.485496	Windows 11 - Chrome V126	3
34	2026-11-01 10:35:01.485496	Android 15 - App Mobile llanos	4
35	2026-11-01 08:35:01.485496	Windows 11 - Chrome V126	5
36	2026-11-01 06:35:01.485496	Android 15 - App Mobile llanos	6
37	2026-11-01 04:35:01.485496	Windows 11 - Chrome V126	7
38	2026-11-01 02:35:01.485496	Android 15 - App Mobile llanos	8
39	2026-11-01 00:35:01.485496	Windows 11 - Chrome V126	9
40	2026-10-31 22:35:01.485496	Android 15 - App Mobile llanos	10
41	2026-10-31 20:35:01.485496	Windows 11 - Chrome V126	1
42	2026-10-31 18:35:01.485496	Android 15 - App Mobile llanos	2
43	2026-10-31 16:35:01.485496	Windows 11 - Chrome V126	3
44	2026-10-31 14:35:01.485496	Android 15 - App Mobile llanos	4
45	2026-10-31 12:35:01.485496	Windows 11 - Chrome V126	5
46	2026-10-31 10:35:01.485496	Android 15 - App Mobile llanos	6
47	2026-10-31 08:35:01.485496	Windows 11 - Chrome V126	7
48	2026-10-31 06:35:01.485496	Android 15 - App Mobile llanos	8
49	2026-10-31 04:35:01.485496	Windows 11 - Chrome V126	9
50	2026-10-31 02:35:01.485496	Android 15 - App Mobile llanos	10
51	2026-10-31 00:35:01.485496	Windows 11 - Chrome V126	1
52	2026-10-30 22:35:01.485496	Android 15 - App Mobile llanos	2
53	2026-10-30 20:35:01.485496	Windows 11 - Chrome V126	3
54	2026-10-30 18:35:01.485496	Android 15 - App Mobile llanos	4
55	2026-10-30 16:35:01.485496	Windows 11 - Chrome V126	5
56	2026-10-30 14:35:01.485496	Android 15 - App Mobile llanos	6
57	2026-10-30 12:35:01.485496	Windows 11 - Chrome V126	7
58	2026-10-30 10:35:01.485496	Android 15 - App Mobile llanos	8
59	2026-10-30 08:35:01.485496	Windows 11 - Chrome V126	9
60	2026-10-30 06:35:01.485496	Android 15 - App Mobile llanos	10
61	2026-10-30 04:35:01.485496	Windows 11 - Chrome V126	1
62	2026-10-30 02:35:01.485496	Android 15 - App Mobile llanos	2
63	2026-10-30 00:35:01.485496	Windows 11 - Chrome V126	3
64	2026-10-29 22:35:01.485496	Android 15 - App Mobile llanos	4
65	2026-10-29 20:35:01.485496	Windows 11 - Chrome V126	5
66	2026-10-29 18:35:01.485496	Android 15 - App Mobile llanos	6
67	2026-10-29 16:35:01.485496	Windows 11 - Chrome V126	7
68	2026-10-29 14:35:01.485496	Android 15 - App Mobile llanos	8
69	2026-10-29 12:35:01.485496	Windows 11 - Chrome V126	9
70	2026-10-29 10:35:01.485496	Android 15 - App Mobile llanos	10
71	2026-10-29 08:35:01.485496	Windows 11 - Chrome V126	1
72	2026-10-29 06:35:01.485496	Android 15 - App Mobile llanos	2
73	2026-10-29 04:35:01.485496	Windows 11 - Chrome V126	3
74	2026-10-29 02:35:01.485496	Android 15 - App Mobile llanos	4
75	2026-10-29 00:35:01.485496	Windows 11 - Chrome V126	5
76	2026-10-28 22:35:01.485496	Android 15 - App Mobile llanos	6
77	2026-10-28 20:35:01.485496	Windows 11 - Chrome V126	7
78	2026-10-28 18:35:01.485496	Android 15 - App Mobile llanos	8
79	2026-10-28 16:35:01.485496	Windows 11 - Chrome V126	9
80	2026-10-28 14:35:01.485496	Android 15 - App Mobile llanos	10
81	2026-10-28 12:35:01.485496	Windows 11 - Chrome V126	1
82	2026-10-28 10:35:01.485496	Android 15 - App Mobile llanos	2
83	2026-10-28 08:35:01.485496	Windows 11 - Chrome V126	3
84	2026-10-28 06:35:01.485496	Android 15 - App Mobile llanos	4
85	2026-10-28 04:35:01.485496	Windows 11 - Chrome V126	5
86	2026-10-28 02:35:01.485496	Android 15 - App Mobile llanos	6
87	2026-10-28 00:35:01.485496	Windows 11 - Chrome V126	7
88	2026-10-27 22:35:01.485496	Android 15 - App Mobile llanos	8
89	2026-10-27 20:35:01.485496	Windows 11 - Chrome V126	9
90	2026-10-27 18:35:01.485496	Android 15 - App Mobile llanos	10
91	2026-10-27 16:35:01.485496	Windows 11 - Chrome V126	1
92	2026-10-27 14:35:01.485496	Android 15 - App Mobile llanos	2
93	2026-10-27 12:35:01.485496	Windows 11 - Chrome V126	3
94	2026-10-27 10:35:01.485496	Android 15 - App Mobile llanos	4
95	2026-10-27 08:35:01.485496	Windows 11 - Chrome V126	5
96	2026-10-27 06:35:01.485496	Android 15 - App Mobile llanos	6
97	2026-10-27 04:35:01.485496	Windows 11 - Chrome V126	7
98	2026-10-27 02:35:01.485496	Android 15 - App Mobile llanos	8
99	2026-10-27 00:35:01.485496	Windows 11 - Chrome V126	9
100	2026-10-26 22:35:01.485496	Android 15 - App Mobile llanos	10
101	2026-10-26 20:35:01.485496	Windows 11 - Chrome V126	1
102	2026-10-26 18:35:01.485496	Android 15 - App Mobile llanos	2
103	2026-10-26 16:35:01.485496	Windows 11 - Chrome V126	3
104	2026-10-26 14:35:01.485496	Android 15 - App Mobile llanos	4
105	2026-10-26 12:35:01.485496	Windows 11 - Chrome V126	5
106	2026-10-26 10:35:01.485496	Android 15 - App Mobile llanos	6
107	2026-10-26 08:35:01.485496	Windows 11 - Chrome V126	7
108	2026-10-26 06:35:01.485496	Android 15 - App Mobile llanos	8
109	2026-10-26 04:35:01.485496	Windows 11 - Chrome V126	9
110	2026-10-26 02:35:01.485496	Android 15 - App Mobile llanos	10
111	2026-10-26 00:35:01.485496	Windows 11 - Chrome V126	1
\.


--
-- TOC entry 4965 (class 0 OID 24658)
-- Dependencies: 218
-- Data for Name: rol; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rol (id_rol, nombre_rol, descripcion) FROM stdin;
1	Administrador	Acceso total al sistema, configuraciones globales y gestión de sucursales.
2	Supervisor	Gestión operativa de la sucursal asignada, reportes y control de personal.
3	Cajero	Operaciones exclusivas del punto de venta, apertura, facturación y cierre de caja.
\.


--
-- TOC entry 4973 (class 0 OID 24700)
-- Dependencies: 226
-- Data for Name: sucursal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sucursal (id_sucursal, nombre_sucursal, direccion, comerciante_id_comerciante) FROM stdin;
1	Don Lucho - Sede Principal Los Olivos	Av. Las Palmeras 1420, Los Olivos, Lima	1
2	Don Lucho - Express San Juan	Av. Chimú 455, San Juan de Lurigancho, Lima	1
3	Boutique Mía - Real Plaza Salaverry	Av. Salaverry 2370, Jesús María, Lima	2
4	Boutique Mía - Jockey Plaza	Av. Javier Prado Este 4200, Santiago de Surco, Lima	2
5	TecnoWilson - Principal Cercado	Av. Garcilaso de la Vega 1250, Cercado de Lima	3
21	Sucursal Mescua - Sede 1	Av. Principal Mescua Nro 101, Lima	2
22	Sucursal Mescua - Sede 2	Av. Principal Mescua Nro 102, Lima	3
23	Sucursal Mescua - Sede 3	Av. Principal Mescua Nro 103, Lima	1
24	Sucursal Mescua - Sede 4	Av. Principal Mescua Nro 104, Lima	2
25	Sucursal Mescua - Sede 5	Av. Principal Mescua Nro 105, Lima	3
26	Sucursal Mescua - Sede 6	Av. Principal Mescua Nro 106, Lima	1
27	Sucursal Mescua - Sede 7	Av. Principal Mescua Nro 107, Lima	2
28	Sucursal Mescua - Sede 8	Av. Principal Mescua Nro 108, Lima	3
29	Sucursal Mescua - Sede 9	Av. Principal Mescua Nro 109, Lima	1
30	Sucursal Mescua - Sede 10	Av. Principal Mescua Nro 110, Lima	2
31	Sucursal Mescua - Sede 11	Av. Principal Mescua Nro 111, Lima	3
32	Sucursal Mescua - Sede 12	Av. Principal Mescua Nro 112, Lima	1
33	Sucursal Mescua - Sede 13	Av. Principal Mescua Nro 113, Lima	2
34	Sucursal Mescua - Sede 14	Av. Principal Mescua Nro 114, Lima	3
35	Sucursal Mescua - Sede 15	Av. Principal Mescua Nro 115, Lima	1
36	Sucursal Mescua - Sede 16	Av. Principal Mescua Nro 116, Lima	2
37	Sucursal Mescua - Sede 17	Av. Principal Mescua Nro 117, Lima	3
38	Sucursal Mescua - Sede 18	Av. Principal Mescua Nro 118, Lima	1
39	Sucursal Mescua - Sede 19	Av. Principal Mescua Nro 119, Lima	2
40	Sucursal Mescua - Sede 20	Av. Principal Mescua Nro 120, Lima	3
41	Sucursal Mescua - Sede 21	Av. Principal Mescua Nro 121, Lima	1
42	Sucursal Mescua - Sede 22	Av. Principal Mescua Nro 122, Lima	2
43	Sucursal Mescua - Sede 23	Av. Principal Mescua Nro 123, Lima	3
44	Sucursal Mescua - Sede 24	Av. Principal Mescua Nro 124, Lima	1
45	Sucursal Mescua - Sede 25	Av. Principal Mescua Nro 125, Lima	2
46	Sucursal Mescua - Sede 26	Av. Principal Mescua Nro 126, Lima	3
47	Sucursal Mescua - Sede 27	Av. Principal Mescua Nro 127, Lima	1
48	Sucursal Mescua - Sede 28	Av. Principal Mescua Nro 128, Lima	2
49	Sucursal Mescua - Sede 29	Av. Principal Mescua Nro 129, Lima	3
50	Sucursal Mescua - Sede 30	Av. Principal Mescua Nro 130, Lima	1
51	Sucursal Mescua - Sede 31	Av. Principal Mescua Nro 131, Lima	2
52	Sucursal Mescua - Sede 32	Av. Principal Mescua Nro 132, Lima	3
53	Sucursal Mescua - Sede 33	Av. Principal Mescua Nro 133, Lima	1
54	Sucursal Mescua - Sede 34	Av. Principal Mescua Nro 134, Lima	2
55	Sucursal Mescua - Sede 35	Av. Principal Mescua Nro 135, Lima	3
56	Sucursal Mescua - Sede 36	Av. Principal Mescua Nro 136, Lima	1
57	Sucursal Mescua - Sede 37	Av. Principal Mescua Nro 137, Lima	2
58	Sucursal Mescua - Sede 38	Av. Principal Mescua Nro 138, Lima	3
59	Sucursal Mescua - Sede 39	Av. Principal Mescua Nro 139, Lima	1
60	Sucursal Mescua - Sede 40	Av. Principal Mescua Nro 140, Lima	2
61	Sucursal Mescua - Sede 41	Av. Principal Mescua Nro 141, Lima	3
62	Sucursal Mescua - Sede 42	Av. Principal Mescua Nro 142, Lima	1
63	Sucursal Mescua - Sede 43	Av. Principal Mescua Nro 143, Lima	2
64	Sucursal Mescua - Sede 44	Av. Principal Mescua Nro 144, Lima	3
65	Sucursal Mescua - Sede 45	Av. Principal Mescua Nro 145, Lima	1
66	Sucursal Mescua - Sede 46	Av. Principal Mescua Nro 146, Lima	2
67	Sucursal Mescua - Sede 47	Av. Principal Mescua Nro 147, Lima	3
68	Sucursal Mescua - Sede 48	Av. Principal Mescua Nro 148, Lima	1
69	Sucursal Mescua - Sede 49	Av. Principal Mescua Nro 149, Lima	2
70	Sucursal Mescua - Sede 50	Av. Principal Mescua Nro 150, Lima	3
71	Sucursal Mescua - Sede 51	Av. Principal Mescua Nro 151, Lima	1
72	Sucursal Mescua - Sede 52	Av. Principal Mescua Nro 152, Lima	2
73	Sucursal Mescua - Sede 53	Av. Principal Mescua Nro 153, Lima	3
74	Sucursal Mescua - Sede 54	Av. Principal Mescua Nro 154, Lima	1
75	Sucursal Mescua - Sede 55	Av. Principal Mescua Nro 155, Lima	2
76	Sucursal Mescua - Sede 56	Av. Principal Mescua Nro 156, Lima	3
77	Sucursal Mescua - Sede 57	Av. Principal Mescua Nro 157, Lima	1
78	Sucursal Mescua - Sede 58	Av. Principal Mescua Nro 158, Lima	2
79	Sucursal Mescua - Sede 59	Av. Principal Mescua Nro 159, Lima	3
80	Sucursal Mescua - Sede 60	Av. Principal Mescua Nro 160, Lima	1
81	Sucursal Mescua - Sede 61	Av. Principal Mescua Nro 161, Lima	2
82	Sucursal Mescua - Sede 62	Av. Principal Mescua Nro 162, Lima	3
83	Sucursal Mescua - Sede 63	Av. Principal Mescua Nro 163, Lima	1
84	Sucursal Mescua - Sede 64	Av. Principal Mescua Nro 164, Lima	2
85	Sucursal Mescua - Sede 65	Av. Principal Mescua Nro 165, Lima	3
86	Sucursal Mescua - Sede 66	Av. Principal Mescua Nro 166, Lima	1
87	Sucursal Mescua - Sede 67	Av. Principal Mescua Nro 167, Lima	2
88	Sucursal Mescua - Sede 68	Av. Principal Mescua Nro 168, Lima	3
89	Sucursal Mescua - Sede 69	Av. Principal Mescua Nro 169, Lima	1
90	Sucursal Mescua - Sede 70	Av. Principal Mescua Nro 170, Lima	2
91	Sucursal Mescua - Sede 71	Av. Principal Mescua Nro 171, Lima	3
92	Sucursal Mescua - Sede 72	Av. Principal Mescua Nro 172, Lima	1
93	Sucursal Mescua - Sede 73	Av. Principal Mescua Nro 173, Lima	2
94	Sucursal Mescua - Sede 74	Av. Principal Mescua Nro 174, Lima	3
95	Sucursal Mescua - Sede 75	Av. Principal Mescua Nro 175, Lima	1
96	Sucursal Mescua - Sede 76	Av. Principal Mescua Nro 176, Lima	2
97	Sucursal Mescua - Sede 77	Av. Principal Mescua Nro 177, Lima	3
98	Sucursal Mescua - Sede 78	Av. Principal Mescua Nro 178, Lima	1
99	Sucursal Mescua - Sede 79	Av. Principal Mescua Nro 179, Lima	2
100	Sucursal Mescua - Sede 80	Av. Principal Mescua Nro 180, Lima	3
101	Sucursal Mescua - Sede 81	Av. Principal Mescua Nro 181, Lima	1
102	Sucursal Mescua - Sede 82	Av. Principal Mescua Nro 182, Lima	2
103	Sucursal Mescua - Sede 83	Av. Principal Mescua Nro 183, Lima	3
104	Sucursal Mescua - Sede 84	Av. Principal Mescua Nro 184, Lima	1
105	Sucursal Mescua - Sede 85	Av. Principal Mescua Nro 185, Lima	2
106	Sucursal Mescua - Sede 86	Av. Principal Mescua Nro 186, Lima	3
107	Sucursal Mescua - Sede 87	Av. Principal Mescua Nro 187, Lima	1
108	Sucursal Mescua - Sede 88	Av. Principal Mescua Nro 188, Lima	2
109	Sucursal Mescua - Sede 89	Av. Principal Mescua Nro 189, Lima	3
110	Sucursal Mescua - Sede 90	Av. Principal Mescua Nro 190, Lima	1
111	Sucursal Mescua - Sede 91	Av. Principal Mescua Nro 191, Lima	2
112	Sucursal Mescua - Sede 92	Av. Principal Mescua Nro 192, Lima	3
113	Sucursal Mescua - Sede 93	Av. Principal Mescua Nro 193, Lima	1
114	Sucursal Mescua - Sede 94	Av. Principal Mescua Nro 194, Lima	2
115	Sucursal Mescua - Sede 95	Av. Principal Mescua Nro 195, Lima	3
116	Sucursal Mescua - Sede 96	Av. Principal Mescua Nro 196, Lima	1
117	Sucursal Mescua - Sede 97	Av. Principal Mescua Nro 197, Lima	2
118	Sucursal Mescua - Sede 98	Av. Principal Mescua Nro 198, Lima	3
119	Sucursal Mescua - Sede 99	Av. Principal Mescua Nro 199, Lima	1
120	Sucursal Mescua - Sede 100	Av. Principal Mescua Nro 200, Lima	2
\.


--
-- TOC entry 4975 (class 0 OID 24708)
-- Dependencies: 228
-- Data for Name: suscripcion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.suscripcion (id_suscripcion, tipo_plan, fecha_inicio, fecha_fin, estado_pago, comerciante_id_comerciante) FROM stdin;
1	Plan Emprende Mensual	2026-09-01	2026-10-01	Activo	1
2	Plan Corporativo Anual	2026-01-15	2027-01-15	Activo	2
3	Plan Emprende Mensual	2026-09-10	2026-10-10	Activo	3
4	Plan Emprende Mensual	2026-10-04	2026-10-20	Vencido	2
5	Plan Emprende Mensual	2026-10-04	2026-10-21	Vencido	3
6	Plan Premium	2026-10-04	2026-10-22	Vencido	1
7	Plan Emprende Mensual	2026-10-04	2026-10-23	Vencido	2
8	Plan Emprende Mensual	2026-10-04	2026-10-24	Vencido	3
9	Plan Premium	2026-10-04	2026-10-25	Vencido	1
10	Plan Emprende Mensual	2026-10-04	2026-10-26	Vencido	2
11	Plan Emprende Mensual	2026-10-04	2026-10-27	Vencido	3
12	Plan Premium	2026-10-04	2026-10-28	Vencido	1
13	Plan Emprende Mensual	2026-10-04	2026-10-29	Vencido	2
14	Plan Emprende Mensual	2026-10-04	2026-10-30	Vencido	3
15	Plan Premium	2026-10-04	2026-10-31	Vencido	1
16	Plan Emprende Mensual	2026-10-04	2026-11-01	Vencido	2
17	Plan Emprende Mensual	2026-10-04	2026-11-02	Vencido	3
18	Plan Premium	2026-10-04	2026-11-03	Activo	1
19	Plan Emprende Mensual	2026-10-04	2026-11-04	Activo	2
20	Plan Emprende Mensual	2026-10-04	2026-11-05	Activo	3
21	Plan Premium	2026-10-04	2026-11-06	Activo	1
22	Plan Emprende Mensual	2026-10-04	2026-11-07	Activo	2
23	Plan Emprende Mensual	2026-10-04	2026-11-08	Activo	3
24	Plan Premium	2026-10-04	2026-11-09	Activo	1
25	Plan Emprende Mensual	2026-10-04	2026-11-10	Activo	2
26	Plan Emprende Mensual	2026-10-04	2026-11-11	Activo	3
27	Plan Premium	2026-10-04	2026-11-12	Activo	1
28	Plan Emprende Mensual	2026-10-04	2026-11-13	Activo	2
29	Plan Emprende Mensual	2026-10-04	2026-11-14	Activo	3
30	Plan Premium	2026-10-04	2026-11-15	Activo	1
31	Plan Emprende Mensual	2026-10-04	2026-11-16	Activo	2
32	Plan Emprende Mensual	2026-10-04	2026-11-17	Activo	3
33	Plan Premium	2026-10-04	2026-11-18	Activo	1
34	Plan Emprende Mensual	2026-10-04	2026-11-19	Activo	2
35	Plan Emprende Mensual	2026-10-04	2026-11-20	Activo	3
36	Plan Premium	2026-10-04	2026-11-21	Activo	1
37	Plan Emprende Mensual	2026-10-04	2026-11-22	Activo	2
38	Plan Emprende Mensual	2026-10-04	2026-11-23	Activo	3
39	Plan Premium	2026-10-04	2026-11-24	Activo	1
40	Plan Emprende Mensual	2026-10-04	2026-11-25	Activo	2
41	Plan Emprende Mensual	2026-10-04	2026-11-26	Activo	3
42	Plan Premium	2026-10-04	2026-11-27	Activo	1
43	Plan Emprende Mensual	2026-10-04	2026-11-28	Activo	2
44	Plan Emprende Mensual	2026-10-04	2026-11-29	Activo	3
45	Plan Premium	2026-10-04	2026-11-30	Activo	1
46	Plan Emprende Mensual	2026-10-04	2026-12-01	Activo	2
47	Plan Emprende Mensual	2026-10-04	2026-12-02	Activo	3
48	Plan Premium	2026-10-04	2026-12-03	Activo	1
49	Plan Emprende Mensual	2026-10-04	2026-12-04	Activo	2
50	Plan Emprende Mensual	2026-10-04	2026-12-05	Activo	3
51	Plan Premium	2026-10-04	2026-12-06	Activo	1
52	Plan Emprende Mensual	2026-10-04	2026-12-07	Activo	2
53	Plan Emprende Mensual	2026-10-04	2026-12-08	Activo	3
54	Plan Premium	2026-10-04	2026-12-09	Activo	1
55	Plan Emprende Mensual	2026-10-04	2026-12-10	Activo	2
56	Plan Emprende Mensual	2026-10-04	2026-12-11	Activo	3
57	Plan Premium	2026-10-04	2026-12-12	Activo	1
58	Plan Emprende Mensual	2026-10-04	2026-12-13	Activo	2
59	Plan Emprende Mensual	2026-10-04	2026-12-14	Activo	3
60	Plan Premium	2026-10-04	2026-12-15	Activo	1
61	Plan Emprende Mensual	2026-10-04	2026-12-16	Activo	2
62	Plan Emprende Mensual	2026-10-04	2026-12-17	Activo	3
63	Plan Premium	2026-10-04	2026-12-18	Activo	1
64	Plan Emprende Mensual	2026-10-04	2026-12-19	Activo	2
65	Plan Emprende Mensual	2026-10-04	2026-12-20	Activo	3
66	Plan Premium	2026-10-04	2026-12-21	Activo	1
67	Plan Emprende Mensual	2026-10-04	2026-12-22	Activo	2
68	Plan Emprende Mensual	2026-10-04	2026-12-23	Activo	3
69	Plan Premium	2026-10-04	2026-12-24	Activo	1
70	Plan Emprende Mensual	2026-10-04	2026-12-25	Activo	2
71	Plan Emprende Mensual	2026-10-04	2026-12-26	Activo	3
72	Plan Premium	2026-10-04	2026-12-27	Activo	1
73	Plan Emprende Mensual	2026-10-04	2026-12-28	Activo	2
74	Plan Emprende Mensual	2026-10-04	2026-12-29	Activo	3
75	Plan Premium	2026-10-04	2026-12-30	Activo	1
76	Plan Emprende Mensual	2026-10-04	2026-12-31	Activo	2
77	Plan Emprende Mensual	2026-10-04	2027-01-01	Activo	3
78	Plan Premium	2026-10-04	2027-01-02	Activo	1
79	Plan Emprende Mensual	2026-10-04	2027-01-03	Activo	2
80	Plan Emprende Mensual	2026-10-04	2027-01-04	Activo	3
81	Plan Premium	2026-10-04	2027-01-05	Activo	1
82	Plan Emprende Mensual	2026-10-04	2027-01-06	Activo	2
83	Plan Emprende Mensual	2026-10-04	2027-01-07	Activo	3
84	Plan Premium	2026-10-04	2027-01-08	Activo	1
85	Plan Emprende Mensual	2026-10-04	2027-01-09	Activo	2
86	Plan Emprende Mensual	2026-10-04	2027-01-10	Activo	3
87	Plan Premium	2026-10-04	2027-01-11	Activo	1
88	Plan Emprende Mensual	2026-10-04	2027-01-12	Activo	2
89	Plan Emprende Mensual	2026-10-04	2027-01-13	Activo	3
90	Plan Premium	2026-10-04	2027-01-14	Activo	1
91	Plan Emprende Mensual	2026-10-04	2027-01-15	Activo	2
92	Plan Emprende Mensual	2026-10-04	2027-01-16	Activo	3
93	Plan Premium	2026-10-04	2027-01-17	Activo	1
94	Plan Emprende Mensual	2026-10-04	2027-01-18	Activo	2
95	Plan Emprende Mensual	2026-10-04	2027-01-19	Activo	3
96	Plan Premium	2026-10-04	2027-01-20	Activo	1
97	Plan Emprende Mensual	2026-10-04	2027-01-21	Activo	2
98	Plan Emprende Mensual	2026-10-04	2027-01-22	Activo	3
99	Plan Premium	2026-10-04	2027-01-23	Activo	1
100	Plan Emprende Mensual	2026-10-04	2027-01-24	Activo	2
101	Plan Emprende Mensual	2026-10-04	2027-01-25	Activo	3
102	Plan Premium	2026-10-04	2027-01-26	Activo	1
103	Plan Emprende Mensual	2026-10-04	2027-01-27	Activo	2
\.


--
-- TOC entry 4997 (class 0 OID 0)
-- Dependencies: 219
-- Name: comerciante_id_comerciante_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comerciante_id_comerciante_seq', 110, true);


--
-- TOC entry 4998 (class 0 OID 0)
-- Dependencies: 221
-- Name: configuracion_id_configuracion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.configuracion_id_configuracion_seq', 110, true);


--
-- TOC entry 4999 (class 0 OID 0)
-- Dependencies: 223
-- Name: empleado_id_empleado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empleado_id_empleado_seq', 10, true);


--
-- TOC entry 5000 (class 0 OID 0)
-- Dependencies: 229
-- Name: historial_login_id_log_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historial_login_id_log_seq', 111, true);


--
-- TOC entry 5001 (class 0 OID 0)
-- Dependencies: 217
-- Name: rol_id_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rol_id_rol_seq', 3, true);


--
-- TOC entry 5002 (class 0 OID 0)
-- Dependencies: 225
-- Name: sucursal_id_sucursal_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sucursal_id_sucursal_seq', 120, true);


--
-- TOC entry 5003 (class 0 OID 0)
-- Dependencies: 227
-- Name: suscripcion_id_suscripcion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.suscripcion_id_suscripcion_seq', 103, true);


--
-- TOC entry 4785 (class 2606 OID 24673)
-- Name: comerciante comerciante_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comerciante
    ADD CONSTRAINT comerciante_pkey PRIMARY KEY (id_comerciante);


--
-- TOC entry 4794 (class 2606 OID 24686)
-- Name: configuracion configuracion_comerciante_id_comerciante_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configuracion
    ADD CONSTRAINT configuracion_comerciante_id_comerciante_key UNIQUE (comerciante_id_comerciante);


--
-- TOC entry 4796 (class 2606 OID 24684)
-- Name: configuracion configuracion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configuracion
    ADD CONSTRAINT configuracion_pkey PRIMARY KEY (id_configuracion);


--
-- TOC entry 4798 (class 2606 OID 24698)
-- Name: empleado correo_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT correo_uq UNIQUE (correo);


--
-- TOC entry 4800 (class 2606 OID 24696)
-- Name: empleado dni_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT dni_uq UNIQUE (dni);


--
-- TOC entry 4802 (class 2606 OID 24694)
-- Name: empleado empleado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_pkey PRIMARY KEY (id_empleado);


--
-- TOC entry 4812 (class 2606 OID 24720)
-- Name: historial_login historial_login_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_login
    ADD CONSTRAINT historial_login_pkey PRIMARY KEY (id_log);


--
-- TOC entry 4781 (class 2606 OID 24666)
-- Name: rol nom_rol_UQ; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rol
    ADD CONSTRAINT "nom_rol_UQ" UNIQUE (nombre_rol);


--
-- TOC entry 4805 (class 2606 OID 24706)
-- Name: sucursal nom_sucursal_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sucursal
    ADD CONSTRAINT nom_sucursal_uq UNIQUE (nombre_sucursal);


--
-- TOC entry 4788 (class 2606 OID 24677)
-- Name: comerciante razon_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comerciante
    ADD CONSTRAINT razon_uq UNIQUE (razon_social);


--
-- TOC entry 4783 (class 2606 OID 24664)
-- Name: rol rol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rol
    ADD CONSTRAINT rol_pkey PRIMARY KEY (id_rol);


--
-- TOC entry 4790 (class 2606 OID 24752)
-- Name: comerciante ruc_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comerciante
    ADD CONSTRAINT ruc_uq UNIQUE (ruc);


--
-- TOC entry 4807 (class 2606 OID 24704)
-- Name: sucursal sucursal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sucursal
    ADD CONSTRAINT sucursal_pkey PRIMARY KEY (id_sucursal);


--
-- TOC entry 4810 (class 2606 OID 24713)
-- Name: suscripcion suscripcion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suscripcion
    ADD CONSTRAINT suscripcion_pkey PRIMARY KEY (id_suscripcion);


--
-- TOC entry 4792 (class 2606 OID 24675)
-- Name: comerciante telefono_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comerciante
    ADD CONSTRAINT telefono_uq UNIQUE (telefono);


--
-- TOC entry 4786 (class 1259 OID 24780)
-- Name: idx_comerciante_ruc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_comerciante_ruc ON public.comerciante USING btree (ruc);


--
-- TOC entry 4803 (class 1259 OID 24778)
-- Name: idx_empleado_estado_llanos; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_empleado_estado_llanos ON public.empleado USING btree (estado);


--
-- TOC entry 4808 (class 1259 OID 24783)
-- Name: idx_suscripcion_vencimiento_zorrilla; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_suscripcion_vencimiento_zorrilla ON public.suscripcion USING btree (fecha_fin, estado_pago);


--
-- TOC entry 4813 (class 2606 OID 24721)
-- Name: configuracion configuracion_comerciante_id_comerciante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configuracion
    ADD CONSTRAINT configuracion_comerciante_id_comerciante_fkey FOREIGN KEY (comerciante_id_comerciante) REFERENCES public.comerciante(id_comerciante) NOT VALID;


--
-- TOC entry 4814 (class 2606 OID 24726)
-- Name: empleado empleado_rol_id_rol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_rol_id_rol_fkey FOREIGN KEY (rol_id_rol) REFERENCES public.rol(id_rol) NOT VALID;


--
-- TOC entry 4815 (class 2606 OID 24731)
-- Name: empleado empleado_sucursal_id_sucursal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_sucursal_id_sucursal_fkey FOREIGN KEY (sucursal_id_sucursal) REFERENCES public.sucursal(id_sucursal) NOT VALID;


--
-- TOC entry 4818 (class 2606 OID 24746)
-- Name: historial_login historial_login_empleado_id_empleado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_login
    ADD CONSTRAINT historial_login_empleado_id_empleado_fkey FOREIGN KEY (empleado_id_empleado) REFERENCES public.empleado(id_empleado) NOT VALID;


--
-- TOC entry 4816 (class 2606 OID 24736)
-- Name: sucursal sucursal_comerciante_id_comerciante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sucursal
    ADD CONSTRAINT sucursal_comerciante_id_comerciante_fkey FOREIGN KEY (comerciante_id_comerciante) REFERENCES public.comerciante(id_comerciante) NOT VALID;


--
-- TOC entry 4817 (class 2606 OID 24741)
-- Name: suscripcion suscripcion_comerciante_id_comerciante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suscripcion
    ADD CONSTRAINT suscripcion_comerciante_id_comerciante_fkey FOREIGN KEY (comerciante_id_comerciante) REFERENCES public.comerciante(id_comerciante) NOT VALID;


--
-- TOC entry 4983 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT CREATE ON SCHEMA public TO llanos;
GRANT CREATE ON SCHEMA public TO romero;
GRANT CREATE ON SCHEMA public TO mescua;
GRANT CREATE ON SCHEMA public TO zorrilla;


--
-- TOC entry 4984 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE comerciante; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.comerciante TO rol_configuracion_pg;
GRANT SELECT ON TABLE public.comerciante TO rol_sucursales_pg;
GRANT SELECT ON TABLE public.comerciante TO rol_analista_pg;


--
-- TOC entry 4985 (class 0 OID 0)
-- Dependencies: 219
-- Name: SEQUENCE comerciante_id_comerciante_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.comerciante_id_comerciante_seq TO rol_seguridad_pg;
GRANT SELECT,USAGE ON SEQUENCE public.comerciante_id_comerciante_seq TO rol_configuracion_pg;
GRANT SELECT,USAGE ON SEQUENCE public.comerciante_id_comerciante_seq TO rol_sucursales_pg;


--
-- TOC entry 4986 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE configuracion; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.configuracion TO rol_configuracion_pg;


--
-- TOC entry 4987 (class 0 OID 0)
-- Dependencies: 221
-- Name: SEQUENCE configuracion_id_configuracion_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.configuracion_id_configuracion_seq TO rol_seguridad_pg;
GRANT SELECT,USAGE ON SEQUENCE public.configuracion_id_configuracion_seq TO rol_configuracion_pg;
GRANT SELECT,USAGE ON SEQUENCE public.configuracion_id_configuracion_seq TO rol_sucursales_pg;


--
-- TOC entry 4988 (class 0 OID 0)
-- Dependencies: 223
-- Name: SEQUENCE empleado_id_empleado_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.empleado_id_empleado_seq TO rol_configuracion_pg;
GRANT SELECT,USAGE ON SEQUENCE public.empleado_id_empleado_seq TO rol_sucursales_pg;


--
-- TOC entry 4989 (class 0 OID 0)
-- Dependencies: 230
-- Name: TABLE historial_login; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.historial_login TO rol_seguridad_pg;


--
-- TOC entry 4990 (class 0 OID 0)
-- Dependencies: 229
-- Name: SEQUENCE historial_login_id_log_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.historial_login_id_log_seq TO rol_seguridad_pg;
GRANT SELECT,USAGE ON SEQUENCE public.historial_login_id_log_seq TO rol_configuracion_pg;
GRANT SELECT,USAGE ON SEQUENCE public.historial_login_id_log_seq TO rol_sucursales_pg;


--
-- TOC entry 4991 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE rol; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.rol TO rol_seguridad_pg;


--
-- TOC entry 4992 (class 0 OID 0)
-- Dependencies: 217
-- Name: SEQUENCE rol_id_rol_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.rol_id_rol_seq TO rol_seguridad_pg;
GRANT SELECT,USAGE ON SEQUENCE public.rol_id_rol_seq TO rol_configuracion_pg;
GRANT SELECT,USAGE ON SEQUENCE public.rol_id_rol_seq TO rol_sucursales_pg;


--
-- TOC entry 4993 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE sucursal; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.sucursal TO rol_sucursales_pg;


--
-- TOC entry 4994 (class 0 OID 0)
-- Dependencies: 225
-- Name: SEQUENCE sucursal_id_sucursal_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.sucursal_id_sucursal_seq TO rol_seguridad_pg;
GRANT SELECT,USAGE ON SEQUENCE public.sucursal_id_sucursal_seq TO rol_configuracion_pg;
GRANT SELECT,USAGE ON SEQUENCE public.sucursal_id_sucursal_seq TO rol_sucursales_pg;


--
-- TOC entry 4995 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE suscripcion; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.suscripcion TO rol_analista_pg;


--
-- TOC entry 4996 (class 0 OID 0)
-- Dependencies: 227
-- Name: SEQUENCE suscripcion_id_suscripcion_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.suscripcion_id_suscripcion_seq TO rol_seguridad_pg;
GRANT SELECT,USAGE ON SEQUENCE public.suscripcion_id_suscripcion_seq TO rol_configuracion_pg;
GRANT SELECT,USAGE ON SEQUENCE public.suscripcion_id_suscripcion_seq TO rol_sucursales_pg;


-- Completed on 2026-11-03 09:05:13

--
-- PostgreSQL database dump complete
--

\unrestrict GaMTFqbPNCQc5EZVGzvc8RSmU2etZnjLrSsWh18eWyAaXTPP2vVKIG35bMXL34C

