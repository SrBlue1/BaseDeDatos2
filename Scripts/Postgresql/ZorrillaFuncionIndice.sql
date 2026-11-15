CREATE OR REPLACE FUNCTION public.fn_evaluar_dias_restantes_suscripcion(
    p_id_suscripcion INT,
    OUT dias_restantes INT,
    OUT estado_alerta TEXT
) AS $$
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
$$ LANGUAGE plpgsql;


CREATE INDEX idx_suscripcion_vencimiento_zorrilla 
ON public.suscripcion (fecha_fin, estado_pago);
