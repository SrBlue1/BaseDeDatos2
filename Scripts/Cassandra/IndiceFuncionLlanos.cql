CREATE OR REPLACE FUNCTION mype_inventario_kardex.fn_diferencia_stock_absoluta(stock_sistema double, stock_fisico double)
RETURNS NULL ON NULL INPUT
RETURNS double
LANGUAGE java
AS 'return Math.abs(stock_sistema - stock_fisico);';

CREATE INDEX idx_movimiento_tipo 
ON mype_inventario_kardex.movimiento_inventario_por_sucursal (tipo_movimiento);