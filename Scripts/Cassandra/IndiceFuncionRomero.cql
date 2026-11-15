CREATE OR REPLACE FUNCTION mype_inventario_kardex.fn_excede_limite_seguridad(
    stock_enviado DOUBLE,
    limite_seguridad DOUBLE
)
RETURNS NULL ON NULL INPUT
RETURNS BOOLEAN
LANGUAGE JAVA
AS 'return stock_enviado > limite_seguridad;';

SELECT id_comerciante, id_variante_sku, stock_enviado, mype_inventario_kardex.fn_excede_limite_seguridad(stock_enviado, 10000) AS excede_limite 
FROM mype_inventario_kardex.sincronizacion_stock_log WHERE plataforma_destino = 'Shopify';

CREATE INDEX IF NOT EXISTS idx_sincronizacion_plataforma ON mype_inventario_kardex.sincronizacion_stock_log (plataforma_destino);

SELECT id_comerciante, fecha_sincronizacion, id_variante_sku, plataforma_destino, stock_enviado, estado_api FROM mype_inventario_kardex.sincronizacion_stock_log WHERE plataforma_destino = 'Shopify';