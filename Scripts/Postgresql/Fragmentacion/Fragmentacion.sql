CREATE TABLE public.historial_login_nueva (
    LIKE public.historial_login
    INCLUDING DEFAULTS
    INCLUDING IDENTITY
)
PARTITION BY RANGE (fecha_hora);

ALTER TABLE public.historial_login_nueva ADD CONSTRAINT historial_login_nueva_pkey PRIMARY KEY (fecha_hora, id_log);
ALTER TABLE public.historial_login_nueva ADD CONSTRAINT historial_login_nueva_empleado_fkey FOREIGN KEY (empleado_id_empleado) REFERENCES public.empleado(id_empleado);

DO $$
DECLARE
    mes_inicio timestamp;
    mes_fin timestamp;
    mes_actual timestamp;
    mes_siguiente timestamp;
    nombre_particion text;
BEGIN

    SELECT
        DATE_TRUNC('month', COALESCE(MIN(fecha_hora), LOCALTIMESTAMP)),
        DATE_TRUNC('month', COALESCE(MAX(fecha_hora), LOCALTIMESTAMP))
    INTO mes_inicio, mes_fin
    FROM public.historial_login;

    mes_fin := GREATEST(
        mes_fin,
        DATE_TRUNC('month', LOCALTIMESTAMP)
    ) + INTERVAL '12 months';

    mes_actual := mes_inicio;

    WHILE mes_actual <= mes_fin LOOP

        mes_siguiente := mes_actual + INTERVAL '1 month';

        nombre_particion :=
            'historial_login_nueva_' ||
            TO_CHAR(mes_actual, 'YYYY_MM');

        EXECUTE FORMAT(
            'CREATE TABLE public.%I
             PARTITION OF public.historial_login_nueva
             FOR VALUES FROM (%L) TO (%L)',
            nombre_particion,
            mes_actual,
            mes_siguiente
        );

        mes_actual := mes_siguiente;

    END LOOP;

END $$;

INSERT INTO public.historial_login_nueva (id_log,fecha_hora,dispositivo,empleado_id_empleado) OVERRIDING SYSTEM VALUE SELECT id_log,fecha_hora,dispositivo,empleado_id_empleado
FROM public.historial_login;

SELECT setval(pg_get_serial_sequence('public.historial_login_nueva','id_log'), COALESCE(MAX(id_log), 1),MAX(id_log) IS NOT NULL) FROM public.historial_login_nueva;

SELECT tableoid::regclass AS particion, COUNT(*) AS cantidad_registros FROM public.historial_login_nueva GROUP BY tableoid ORDER BY particion;

BEGIN;
LOCK TABLE public.historial_login IN ACCESS EXCLUSIVE MODE;
LOCK TABLE public.historial_login_nueva IN ACCESS EXCLUSIVE MODE;
ALTER TABLE public.historial_login RENAME TO historial_login_anterior;
ALTER TABLE public.historial_login_nueva RENAME TO historial_login;
COMMIT;

DROP TABLE public.historial_login_anterior; 

















