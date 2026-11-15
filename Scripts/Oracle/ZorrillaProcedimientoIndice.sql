CREATE OR REPLACE PROCEDURE sp_evaluar_comprobantes_zorrilla (
    p_id_venta IN NUMBER,
    o_estado_sunat OUT VARCHAR2
) IS
    v_total_bruto NUMBER(10,2);
BEGIN
    SELECT total_bruto 
    INTO v_total_bruto
    FROM mype_financiero.venta
    WHERE id_venta = p_id_venta;
 
    IF v_total_bruto > 700.00 THEN
        o_estado_sunat := 'REQUIERE DNI/RUC OBLIGATORIO';
    ELSE
        o_estado_sunat := 'COMPROBANTE SIMPLIFICADO VALIDO';
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        o_estado_sunat := 'VENTA NO ENCONTRADA';
END;
/

CREATE INDEX mype_financiero.idx_venta_fecha_zorrilla 
ON mype_financiero.venta (fecha_venta);
