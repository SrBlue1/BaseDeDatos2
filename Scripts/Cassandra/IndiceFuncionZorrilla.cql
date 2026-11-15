CREATE INDEX IF NOT EXISTS idx_alerta_estado_zorrilla ON mype_inventario_kardex.alertas_reabastecimiento_historico (estado_notificacion);

SELECT id_comerciante, fecha_alerta, id_sucursal, id_variante_sku, stock_actual, estado_notificacion FROM mype_inventario_kardex.alertas_reabastecimiento_historico WHERE estado_notificacion = 'ENVIADO';

CREATE OR REPLACE FUNCTION mype_inventario_kardex.fn_criticidad_porcentual_zorrilla(
    stock_actual double, 
    stock_minimo double
)
RETURNS NULL ON NULL INPUT
RETURNS double
LANGUAGE java
AS '
    if (stock_minimo == 0) return 0.0;
    return (stock_actual / stock_minimo) * 100.0;
';

SELECT 
    id_comerciante, 
    id_variante_sku, 
    stock_actual, 
    stock_minimo_configurado,
    mype_inventario_kardex.fn_criticidad_porcentual_zorrilla(stock_actual, stock_minimo_configurado) AS criticidad_porcentual
FROM mype_inventario_kardex.alertas_reabastecimiento_historico 
LIMIT 5;