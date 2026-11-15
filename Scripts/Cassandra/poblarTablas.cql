USE mype_inventario_kardex;

-- ==========================================
-- 1. MOVIMIENTO INVENTARIO POR SUCURSAL (20 registros)
-- ==========================================
INSERT INTO movimiento_inventario_por_sucursal (id_sucursal, fecha_movimiento, id_variante_sku, id_movimiento, tipo_movimiento, cantidad, origen_motivo, id_usuario) 
VALUES (10, '2026-11-01 08:30:00', 'SKU-ABAR-001', uuid(), 'ENTRADA', 50.0, 'Compra Proveedor Fact-001', 1);

INSERT INTO movimiento_inventario_por_sucursal (id_sucursal, fecha_movimiento, id_variante_sku, id_movimiento, tipo_movimiento, cantidad, origen_motivo, id_usuario) 
VALUES (10, '2026-11-01 09:15:00', 'SKU-BEB-015', uuid(), 'SALIDA', 12.0, 'Venta Boleta B001-45', 3);

INSERT INTO movimiento_inventario_por_sucursal (id_sucursal, fecha_movimiento, id_variante_sku, id_movimiento, tipo_movimiento, cantidad, origen_motivo, id_usuario) 
VALUES (10, '2026-11-01 10:00:00', 'SKU-LIM-008', uuid(), 'ENTRADA', 30.0, 'Compra Proveedor Fact-002', 1);

INSERT INTO movimiento_inventario_por_sucursal (id_sucursal, fecha_movimiento, id_variante_sku, id_movimiento, tipo_movimiento, cantidad, origen_motivo, id_usuario) 
VALUES (10, '2026-11-01 11:20:00', 'SKU-SNACK-022', uuid(), 'SALIDA', 5.0, 'Venta Boleta B001-46', 3);

INSERT INTO movimiento_inventario_por_sucursal (id_sucursal, fecha_movimiento, id_variante_sku, id_movimiento, tipo_movimiento, cantidad, origen_motivo, id_usuario) 
VALUES (10, '2026-11-01 12:00:00', 'SKU-LACT-004', uuid(), 'MERMA', 2.0, 'Rotura de envase en anaquel', 2);

INSERT INTO movimiento_inventario_por_sucursal (id_sucursal, fecha_movimiento, id_variante_sku, id_movimiento, tipo_movimiento, cantidad, origen_motivo, id_usuario) 
VALUES (10, '2026-11-02 08:00:00', 'SKU-ABAR-001', uuid(), 'SALIDA', 20.0, 'Venta Boleta B001-50', 3);

INSERT INTO movimiento_inventario_por_sucursal (id_sucursal, fecha_movimiento, id_variante_sku, id_movimiento, tipo_movimiento, cantidad, origen_motivo, id_usuario) 
VALUES (10, '2026-11-02 09:30:00', 'SKU-BEB-015', uuid(), 'ENTRADA', 40.0, 'Compra Proveedor Fact-005', 1);

INSERT INTO movimiento_inventario_por_sucursal (id_sucursal, fecha_movimiento, id_variante_sku, id_movimiento, tipo_movimiento, cantidad, origen_motivo, id_usuario) 
VALUES (10, '2026-11-02 14:10:00', 'SKU-LIM-008', uuid(), 'SALIDA', 8.0, 'Venta Boleta B001-62', 3);

INSERT INTO movimiento_inventario_por_sucursal (id_sucursal, fecha_movimiento, id_variante_sku, id_movimiento, tipo_movimiento, cantidad, origen_motivo, id_usuario) 
VALUES (10, '2026-11-02 16:45:00', 'SKU-SNACK-022', uuid(), 'TRANSFERENCIA', 15.0, 'Envío a Sede Norte', 2);

INSERT INTO movimiento_inventario_por_sucursal (id_sucursal, fecha_movimiento, id_variante_sku, id_movimiento, tipo_movimiento, cantidad, origen_motivo, id_usuario) 
VALUES (10, '2026-11-03 09:00:00', 'SKU-LACT-004', uuid(), 'ENTRADA', 60.0, 'Compra Proveedor Fact-010', 1);

INSERT INTO movimiento_inventario_por_sucursal (id_sucursal, fecha_movimiento, id_variante_sku, id_movimiento, tipo_movimiento, cantidad, origen_motivo, id_usuario) 
VALUES (20, '2026-11-01 08:30:00', 'SKU-ABAR-001', uuid(), 'ENTRADA', 40.0, 'Recepción Sede Central', 2);

INSERT INTO movimiento_inventario_por_sucursal (id_sucursal, fecha_movimiento, id_variante_sku, id_movimiento, tipo_movimiento, cantidad, origen_motivo, id_usuario) 
VALUES (20, '2026-11-01 10:15:00', 'SKU-BEB-015', uuid(), 'SALIDA', 10.0, 'Venta Ticket Norte-01', 3);

INSERT INTO movimiento_inventario_por_sucursal (id_sucursal, fecha_movimiento, id_variante_sku, id_movimiento, tipo_movimiento, cantidad, origen_motivo, id_usuario) 
VALUES (20, '2026-11-01 11:45:00', 'SKU-LIM-008', uuid(), 'ENTRADA', 25.0, 'Compra Local Norte', 1);

INSERT INTO movimiento_inventario_por_sucursal (id_sucursal, fecha_movimiento, id_variante_sku, id_movimiento, tipo_movimiento, cantidad, origen_motivo, id_usuario) 
VALUES (20, '2026-11-01 13:20:00', 'SKU-SNACK-022', uuid(), 'SALIDA', 8.0, 'Venta Ticket Norte-05', 3);

INSERT INTO movimiento_inventario_por_sucursal (id_sucursal, fecha_movimiento, id_variante_sku, id_movimiento, tipo_movimiento, cantidad, origen_motivo, id_usuario) 
VALUES (20, '2026-11-02 09:10:00', 'SKU-LACT-004', uuid(), 'SALIDA', 12.0, 'Venta Ticket Norte-10', 3);

INSERT INTO movimiento_inventario_por_sucursal (id_sucursal, fecha_movimiento, id_variante_sku, id_movimiento, tipo_movimiento, cantidad, origen_motivo, id_usuario) 
VALUES (20, '2026-11-02 11:00:00', 'SKU-ABAR-001', uuid(), 'MERMA', 1.0, 'Deterioro por humedad', 2);

INSERT INTO movimiento_inventario_por_sucursal (id_sucursal, fecha_movimiento, id_variante_sku, id_movimiento, tipo_movimiento, cantidad, origen_motivo, id_usuario) 
VALUES (20, '2026-11-02 14:30:00', 'SKU-BEB-015', uuid(), 'ENTRADA', 30.0, 'Recepción Sede Central', 2);

INSERT INTO movimiento_inventario_por_sucursal (id_sucursal, fecha_movimiento, id_variante_sku, id_movimiento, tipo_movimiento, cantidad, origen_motivo, id_usuario) 
VALUES (20, '2026-11-03 10:00:00', 'SKU-LIM-008', uuid(), 'SALIDA', 5.0, 'Venta Ticket Norte-18', 3);

INSERT INTO movimiento_inventario_por_sucursal (id_sucursal, fecha_movimiento, id_variante_sku, id_movimiento, tipo_movimiento, cantidad, origen_motivo, id_usuario) 
VALUES (20, '2026-11-03 15:00:00', 'SKU-SNACK-022', uuid(), 'ENTRADA', 20.0, 'Compra Local Norte', 1);

INSERT INTO movimiento_inventario_por_sucursal (id_sucursal, fecha_movimiento, id_variante_sku, id_movimiento, tipo_movimiento, cantidad, origen_motivo, id_usuario) 
VALUES (20, '2026-11-03 17:30:00', 'SKU-LACT-004', uuid(), 'SALIDA', 6.0, 'Venta Ticket Norte-22', 3);


-- ==========================================
-- 2. AUDITORIA STOCK DIARIO (20 registros)
-- ==========================================
INSERT INTO auditoria_stock_diario (id_sucursal, fecha_cierre, id_variante_sku, cantidad_sistema, cantidad_fisica_contada, diferencia) 
VALUES (10, '2026-11-01', 'SKU-ABAR-001', 150.0, 150.0, 0.0);

INSERT INTO auditoria_stock_diario (id_sucursal, fecha_cierre, id_variante_sku, cantidad_sistema, cantidad_fisica_contada, diferencia) 
VALUES (10, '2026-11-01', 'SKU-BEB-015', 85.0, 84.0, -1.0);

INSERT INTO auditoria_stock_diario (id_sucursal, fecha_cierre, id_variante_sku, cantidad_sistema, cantidad_fisica_contada, diferencia) 
VALUES (10, '2026-11-01', 'SKU-LIM-008', 40.0, 40.0, 0.0);

INSERT INTO auditoria_stock_diario (id_sucursal, fecha_cierre, id_variante_sku, cantidad_sistema, cantidad_fisica_contada, diferencia) 
VALUES (10, '2026-11-01', 'SKU-SNACK-022', 110.0, 108.0, -2.0);

INSERT INTO auditoria_stock_diario (id_sucursal, fecha_cierre, id_variante_sku, cantidad_sistema, cantidad_fisica_contada, diferencia) 
VALUES (10, '2026-11-01', 'SKU-LACT-004', 50.0, 50.0, 0.0);

INSERT INTO auditoria_stock_diario (id_sucursal, fecha_cierre, id_variante_sku, cantidad_sistema, cantidad_fisica_contada, diferencia) 
VALUES (10, '2026-11-02', 'SKU-ABAR-001', 130.0, 130.0, 0.0);

INSERT INTO auditoria_stock_diario (id_sucursal, fecha_cierre, id_variante_sku, cantidad_sistema, cantidad_fisica_contada, diferencia) 
VALUES (10, '2026-11-02', 'SKU-BEB-015', 115.0, 115.0, 0.0);

INSERT INTO auditoria_stock_diario (id_sucursal, fecha_cierre, id_variante_sku, cantidad_sistema, cantidad_fisica_contada, diferencia) 
VALUES (10, '2026-11-02', 'SKU-LIM-008', 32.0, 31.0, -1.0);

INSERT INTO auditoria_stock_diario (id_sucursal, fecha_cierre, id_variante_sku, cantidad_sistema, cantidad_fisica_contada, diferencia) 
VALUES (10, '2026-11-02', 'SKU-SNACK-022', 93.0, 93.0, 0.0);

INSERT INTO auditoria_stock_diario (id_sucursal, fecha_cierre, id_variante_sku, cantidad_sistema, cantidad_fisica_contada, diferencia) 
VALUES (10, '2026-11-02', 'SKU-LACT-004', 110.0, 110.0, 0.0);

INSERT INTO auditoria_stock_diario (id_sucursal, fecha_cierre, id_variante_sku, cantidad_sistema, cantidad_fisica_contada, diferencia) 
VALUES (20, '2026-11-01', 'SKU-ABAR-001', 90.0, 90.0, 0.0);

INSERT INTO auditoria_stock_diario (id_sucursal, fecha_cierre, id_variante_sku, cantidad_sistema, cantidad_fisica_contada, diferencia) 
VALUES (20, '2026-11-01', 'SKU-BEB-015', 60.0, 59.0, -1.0);

INSERT INTO auditoria_stock_diario (id_sucursal, fecha_cierre, id_variante_sku, cantidad_sistema, cantidad_fisica_contada, diferencia) 
VALUES (20, '2026-11-01', 'SKU-LIM-008', 25.0, 25.0, 0.0);

INSERT INTO auditoria_stock_diario (id_sucursal, fecha_cierre, id_variante_sku, cantidad_sistema, cantidad_fisica_contada, diferencia) 
VALUES (20, '2026-11-01', 'SKU-SNACK-022', 70.0, 70.0, 0.0);

INSERT INTO auditoria_stock_diario (id_sucursal, fecha_cierre, id_variante_sku, cantidad_sistema, cantidad_fisica_contada, diferencia) 
VALUES (20, '2026-11-01', 'SKU-LACT-004', 38.0, 38.0, 0.0);

INSERT INTO auditoria_stock_diario (id_sucursal, fecha_cierre, id_variante_sku, cantidad_sistema, cantidad_fisica_contada, diferencia) 
VALUES (20, '2026-11-02', 'SKU-ABAR-001', 89.0, 89.0, 0.0);

INSERT INTO auditoria_stock_diario (id_sucursal, fecha_cierre, id_variante_sku, cantidad_sistema, cantidad_fisica_contada, diferencia) 
VALUES (20, '2026-11-02', 'SKU-BEB-015', 90.0, 90.0, 0.0);

INSERT INTO auditoria_stock_diario (id_sucursal, fecha_cierre, id_variante_sku, cantidad_sistema, cantidad_fisica_contada, diferencia) 
VALUES (20, '2026-11-02', 'SKU-LIM-008', 20.0, 20.0, 0.0);

INSERT INTO auditoria_stock_diario (id_sucursal, fecha_cierre, id_variante_sku, cantidad_sistema, cantidad_fisica_contada, diferencia) 
VALUES (20, '2026-11-02', 'SKU-SNACK-022', 90.0, 90.0, 0.0);

INSERT INTO auditoria_stock_diario (id_sucursal, fecha_cierre, id_variante_sku, cantidad_sistema, cantidad_fisica_contada, diferencia) 
VALUES (20, '2026-11-02', 'SKU-LACT-004', 32.0, 32.0, 0.0);


-- ==========================================
-- 3. ALERTAS REABASTECIMIENTO HISTORICO (20 registros)
-- ==========================================
INSERT INTO alertas_reabastecimiento_historico (id_comerciante, fecha_alerta, id_variante_sku, id_sucursal, stock_actual, stock_minimo_configurado, estado_notificacion) 
VALUES (1001, '2026-11-01 14:00:00', 'SKU-LIM-008', 10, 4.0, 5.0, 'LEIDO');

INSERT INTO alertas_reabastecimiento_historico (id_comerciante, fecha_alerta, id_variante_sku, id_sucursal, stock_actual, stock_minimo_configurado, estado_notificacion) 
VALUES (1001, '2026-11-01 16:30:00', 'SKU-SNACK-022', 10, 8.0, 10.0, 'ENVIADO');

INSERT INTO alertas_reabastecimiento_historico (id_comerciante, fecha_alerta, id_variante_sku, id_sucursal, stock_actual, stock_minimo_configurado, estado_notificacion) 
VALUES (1001, '2026-11-02 09:15:00', 'SKU-ABAR-001', 10, 12.0, 15.0, 'LEIDO');

INSERT INTO alertas_reabastecimiento_historico (id_comerciante, fecha_alerta, id_variante_sku, id_sucursal, stock_actual, stock_minimo_configurado, estado_notificacion) 
VALUES (1001, '2026-11-02 11:20:00', 'SKU-BEB-015', 20, 5.0, 10.0, 'ENVIADO');

INSERT INTO alertas_reabastecimiento_historico (id_comerciante, fecha_alerta, id_variante_sku, id_sucursal, stock_actual, stock_minimo_configurado, estado_notificacion) 
VALUES (1001, '2026-11-02 15:40:00', 'SKU-LACT-004', 20, 3.0, 8.0, 'LEIDO');

INSERT INTO alertas_reabastecimiento_historico (id_comerciante, fecha_alerta, id_variante_sku, id_sucursal, stock_actual, stock_minimo_configurado, estado_notificacion) 
VALUES (1001, '2026-11-03 08:10:00', 'SKU-LIM-008', 20, 2.0, 5.0, 'ENVIADO');

INSERT INTO alertas_reabastecimiento_historico (id_comerciante, fecha_alerta, id_variante_sku, id_sucursal, stock_actual, stock_minimo_configurado, estado_notificacion) 
VALUES (1001, '2026-11-03 10:00:00', 'SKU-SNACK-022', 10, 6.0, 10.0, 'LEIDO');

INSERT INTO alertas_reabastecimiento_historico (id_comerciante, fecha_alerta, id_variante_sku, id_sucursal, stock_actual, stock_minimo_configurado, estado_notificacion) 
VALUES (1001, '2026-11-03 12:30:00', 'SKU-ABAR-001', 20, 9.0, 15.0, 'ENVIADO');

INSERT INTO alertas_reabastecimiento_historico (id_comerciante, fecha_alerta, id_variante_sku, id_sucursal, stock_actual, stock_minimo_configurado, estado_notificacion) 
VALUES (1001, '2026-11-03 14:20:00', 'SKU-BEB-015', 10, 4.0, 10.0, 'LEIDO');

INSERT INTO alertas_reabastecimiento_historico (id_comerciante, fecha_alerta, id_variante_sku, id_sucursal, stock_actual, stock_minimo_configurado, estado_notificacion) 
VALUES (1001, '2026-11-03 16:50:00', 'SKU-LACT-004', 10, 2.0, 8.0, 'ENVIADO');

INSERT INTO alertas_reabastecimiento_historico (id_comerciante, fecha_alerta, id_variante_sku, id_sucursal, stock_actual, stock_minimo_configurado, estado_notificacion) 
VALUES (1001, '2026-11-04 08:30:00', 'SKU-LIM-008', 10, 3.0, 5.0, 'ENVIADO');

INSERT INTO alertas_reabastecimiento_historico (id_comerciante, fecha_alerta, id_variante_sku, id_sucursal, stock_actual, stock_minimo_configurado, estado_notificacion) 
VALUES (1001, '2026-11-04 09:45:00', 'SKU-ABAR-001', 10, 10.0, 15.0, 'LEIDO');

INSERT INTO alertas_reabastecimiento_historico (id_comerciante, fecha_alerta, id_variante_sku, id_sucursal, stock_actual, stock_minimo_configurado, estado_notificacion) 
VALUES (1001, '2026-11-04 11:15:00', 'SKU-SNACK-022', 20, 5.0, 10.0, 'ENVIADO');

INSERT INTO alertas_reabastecimiento_historico (id_comerciante, fecha_alerta, id_variante_sku, id_sucursal, stock_actual, stock_minimo_configurado, estado_notificacion) 
VALUES (1001, '2026-11-04 13:00:00', 'SKU-BEB-015', 20, 6.0, 10.0, 'LEIDO');

INSERT INTO alertas_reabastecimiento_historico (id_comerciante, fecha_alerta, id_variante_sku, id_sucursal, stock_actual, stock_minimo_configurado, estado_notificacion) 
VALUES (1001, '2026-11-04 15:20:00', 'SKU-LACT-004', 20, 4.0, 8.0, 'ENVIADO');

INSERT INTO alertas_reabastecimiento_historico (id_comerciante, fecha_alerta, id_variante_sku, id_sucursal, stock_actual, stock_minimo_configurado, estado_notificacion) 
VALUES (1001, '2026-11-05 08:00:00', 'SKU-ABAR-001', 20, 11.0, 15.0, 'LEIDO');

INSERT INTO alertas_reabastecimiento_historico (id_comerciante, fecha_alerta, id_variante_sku, id_sucursal, stock_actual, stock_minimo_configurado, estado_notificacion) 
VALUES (1001, '2026-11-05 09:30:00', 'SKU-LIM-008', 20, 1.0, 5.0, 'ENVIADO');

INSERT INTO alertas_reabastecimiento_historico (id_comerciante, fecha_alerta, id_variante_sku, id_sucursal, stock_actual, stock_minimo_configurado, estado_notificacion) 
VALUES (1001, '2026-11-05 11:10:00', 'SKU-SNACK-022', 10, 4.0, 10.0, 'LEIDO');

INSERT INTO alertas_reabastecimiento_historico (id_comerciante, fecha_alerta, id_variante_sku, id_sucursal, stock_actual, stock_minimo_configurado, estado_notificacion) 
VALUES (1001, '2026-11-05 14:00:00', 'SKU-BEB-015', 10, 3.0, 10.0, 'ENVIADO');

INSERT INTO alertas_reabastecimiento_historico (id_comerciante, fecha_alerta, id_variante_sku, id_sucursal, stock_actual, stock_minimo_configurado, estado_notificacion) 
VALUES (1001, '2026-11-05 16:15:00', 'SKU-LACT-004', 10, 5.0, 8.0, 'LEIDO');


-- ==========================================
-- 4. LOGS DISPOSITIVOS ESCANER (20 registros)
-- ==========================================
INSERT INTO logs_dispositivos_escaner (id_usuario, fecha_log, modelo_celular, codigo_barras_leido, tiempo_respuesta_ms, resultado) 
VALUES (2, '2026-11-01 08:12:05', 'Samsung A32', '7750123456789', 145, 'EXITOSO');

INSERT INTO logs_dispositivos_escaner (id_usuario, fecha_log, modelo_celular, codigo_barras_leido, tiempo_respuesta_ms, resultado) 
VALUES (2, '2026-11-01 08:15:22', 'Samsung A32', '7750987654321', 190, 'EXITOSO');

INSERT INTO logs_dispositivos_escaner (id_usuario, fecha_log, modelo_celular, codigo_barras_leido, tiempo_respuesta_ms, resultado) 
VALUES (2, '2026-11-01 08:20:10', 'Samsung A32', '0000000000000', 310, 'NO_ENCONTRADO');

INSERT INTO logs_dispositivos_escaner (id_usuario, fecha_log, modelo_celular, codigo_barras_leido, tiempo_respuesta_ms, resultado) 
VALUES (3, '2026-11-01 09:05:40', 'Xiaomi Redmi Note 10', '7750111222333', 120, 'EXITOSO');

INSERT INTO logs_dispositivos_escaner (id_usuario, fecha_log, modelo_celular, codigo_barras_leido, tiempo_respuesta_ms, resultado) 
VALUES (3, '2026-11-01 09:10:11', 'Xiaomi Redmi Note 10', '7750444555666', 135, 'EXITOSO');

INSERT INTO logs_dispositivos_escaner (id_usuario, fecha_log, modelo_celular, codigo_barras_leido, tiempo_respuesta_ms, resultado) 
VALUES (2, '2026-11-02 08:22:00', 'Samsung A32', '7750123456789', 150, 'EXITOSO');

INSERT INTO logs_dispositivos_escaner (id_usuario, fecha_log, modelo_celular, codigo_barras_leido, tiempo_respuesta_ms, resultado) 
VALUES (2, '2026-11-02 08:25:33', 'Samsung A32', 'BAD_BARCODE_XYZ', 450, 'ERROR CAMARA');

INSERT INTO logs_dispositivos_escaner (id_usuario, fecha_log, modelo_celular, codigo_barras_leido, tiempo_respuesta_ms, resultado) 
VALUES (3, '2026-11-02 10:11:05', 'Xiaomi Redmi Note 10', '7750987654321', 110, 'EXITOSO');

INSERT INTO logs_dispositivos_escaner (id_usuario, fecha_log, modelo_celular, codigo_barras_leido, tiempo_respuesta_ms, resultado) 
VALUES (3, '2026-11-02 10:14:50', 'Xiaomi Redmi Note 10', '7750777888999', 125, 'EXITOSO');

INSERT INTO logs_dispositivos_escaner (id_usuario, fecha_log, modelo_celular, codigo_barras_leido, tiempo_respuesta_ms, resultado) 
VALUES (2, '2026-11-03 08:05:12', 'Samsung A32', '7750111222333', 160, 'EXITOSO');

INSERT INTO logs_dispositivos_escaner (id_usuario, fecha_log, modelo_celular, codigo_barras_leido, tiempo_respuesta_ms, resultado) 
VALUES (2, '2026-11-03 08:09:40', 'Samsung A32', '7750444555666', 140, 'EXITOSO');

INSERT INTO logs_dispositivos_escaner (id_usuario, fecha_log, modelo_celular, codigo_barras_leido, tiempo_respuesta_ms, resultado) 
VALUES (3, '2026-11-03 09:30:15', 'Moto G52', '7750123456789', 180, 'EXITOSO');

INSERT INTO logs_dispositivos_escaner (id_usuario, fecha_log, modelo_celular, codigo_barras_leido, tiempo_respuesta_ms, resultado) 
VALUES (3, '2026-11-03 09:35:22', 'Moto G52', '9999999999999', 290, 'NO_ENCONTRADO');

INSERT INTO logs_dispositivos_escaner (id_usuario, fecha_log, modelo_celular, codigo_barras_leido, tiempo_respuesta_ms, resultado) 
VALUES (2, '2026-11-04 08:15:00', 'Samsung A32', '7750987654321', 130, 'EXITOSO');

INSERT INTO logs_dispositivos_escaner (id_usuario, fecha_log, modelo_celular, codigo_barras_leido, tiempo_respuesta_ms, resultado) 
VALUES (2, '2026-11-04 08:18:45', 'Samsung A32', '7750777888999', 155, 'EXITOSO');

INSERT INTO logs_dispositivos_escaner (id_usuario, fecha_log, modelo_celular, codigo_barras_leido, tiempo_respuesta_ms, resultado) 
VALUES (3, '2026-11-04 11:00:10', 'Moto G52', '7750111222333', 115, 'EXITOSO');

INSERT INTO logs_dispositivos_escaner (id_usuario, fecha_log, modelo_celular, codigo_barras_leido, tiempo_respuesta_ms, resultado) 
VALUES (3, '2026-11-04 11:05:30', 'Moto G52', '7750444555666', 140, 'EXITOSO');

INSERT INTO logs_dispositivos_escaner (id_usuario, fecha_log, modelo_celular, codigo_barras_leido, tiempo_respuesta_ms, resultado) 
VALUES (2, '2026-11-05 08:10:00', 'Samsung A32', '7750123456789', 145, 'EXITOSO');

INSERT INTO logs_dispositivos_escaner (id_usuario, fecha_log, modelo_celular, codigo_barras_leido, tiempo_respuesta_ms, resultado) 
VALUES (3, '2026-11-05 10:20:15', 'Moto G52', '7750987654321', 125, 'EXITOSO');

INSERT INTO logs_dispositivos_escaner (id_usuario, fecha_log, modelo_celular, codigo_barras_leido, tiempo_respuesta_ms, resultado) 
VALUES (3, '2026-11-05 10:25:00', 'Moto G52', 'INVALID_CODE_99', 500, 'ERROR CAMARA');


-- ==========================================
-- 5. SINCRONIZACION STOCK LOG (20 registros)
-- ==========================================
INSERT INTO sincronizacion_stock_log (id_comerciante, fecha_sincronizacion, id_variante_sku, plataforma_destino, stock_enviado, estado_api) 
VALUES (1001, '2026-11-01 09:00:00', 'SKU-ABAR-001', 'Shopify', 150.0, 'OK');

INSERT INTO sincronizacion_stock_log (id_comerciante, fecha_sincronizacion, id_variante_sku, plataforma_destino, stock_enviado, estado_api) 
VALUES (1001, '2026-11-01 09:00:05', 'SKU-BEB-015', 'Shopify', 85.0, 'OK');

INSERT INTO sincronizacion_stock_log (id_comerciante, fecha_sincronizacion, id_variante_sku, plataforma_destino, stock_enviado, estado_api) 
VALUES (1001, '2026-11-01 09:00:10', 'SKU-LIM-008', 'Shopify', 40.0, 'OK');

INSERT INTO sincronizacion_stock_log (id_comerciante, fecha_sincronizacion, id_variante_sku, plataforma_destino, stock_enviado, estado_api) 
VALUES (1001, '2026-11-01 12:00:00', 'SKU-SNACK-022', 'WooCommerce', 110.0, 'OK');

INSERT INTO sincronizacion_stock_log (id_comerciante, fecha_sincronizacion, id_variante_sku, plataforma_destino, stock_enviado, estado_api) 
VALUES (1001, '2026-11-01 12:00:05', 'SKU-LACT-004', 'WooCommerce', 50.0, 'OK');

INSERT INTO sincronizacion_stock_log (id_comerciante, fecha_sincronizacion, id_variante_sku, plataforma_destino, stock_enviado, estado_api) 
VALUES (1001, '2026-11-02 09:00:00', 'SKU-ABAR-001', 'Shopify', 130.0, 'OK');

INSERT INTO sincronizacion_stock_log (id_comerciante, fecha_sincronizacion, id_variante_sku, plataforma_destino, stock_enviado, estado_api) 
VALUES (1001, '2026-11-02 09:00:05', 'SKU-BEB-015', 'Shopify', 115.0, 'OK');

INSERT INTO sincronizacion_stock_log (id_comerciante, fecha_sincronizacion, id_variante_sku, plataforma_destino, stock_enviado, estado_api) 
VALUES (1001, '2026-11-02 09:00:10', 'SKU-LIM-008', 'Shopify', 32.0, 'TIMEOUT');

INSERT INTO sincronizacion_stock_log (id_comerciante, fecha_sincronizacion, id_variante_sku, plataforma_destino, stock_enviado, estado_api) 
VALUES (1001, '2026-11-02 12:00:00', 'SKU-SNACK-022', 'WooCommerce', 93.0, 'OK');

INSERT INTO sincronizacion_stock_log (id_comerciante, fecha_sincronizacion, id_variante_sku, plataforma_destino, stock_enviado, estado_api) 
VALUES (1001, '2026-11-02 12:00:05', 'SKU-LACT-004', 'WooCommerce', 110.0, 'OK');

INSERT INTO sincronizacion_stock_log (id_comerciante, fecha_sincronizacion, id_variante_sku, plataforma_destino, stock_enviado, estado_api) 
VALUES (1001, '2026-11-03 09:00:00', 'SKU-ABAR-001', 'Shopify', 120.0, 'OK');

INSERT INTO sincronizacion_stock_log (id_comerciante, fecha_sincronizacion, id_variante_sku, plataforma_destino, stock_enviado, estado_api) 
VALUES (1001, '2026-11-03 09:00:05', 'SKU-BEB-015', 'Shopify', 95.0, 'OK');

INSERT INTO sincronizacion_stock_log (id_comerciante, fecha_sincronizacion, id_variante_sku, plataforma_destino, stock_enviado, estado_api) 
VALUES (1001, '2026-11-03 09:00:10', 'SKU-LIM-008', 'Shopify', 30.0, 'OK');

INSERT INTO sincronizacion_stock_log (id_comerciante, fecha_sincronizacion, id_variante_sku, plataforma_destino, stock_enviado, estado_api) 
VALUES (1001, '2026-11-03 12:00:00', 'SKU-SNACK-022', 'WooCommerce', 85.0, 'OK');

INSERT INTO sincronizacion_stock_log (id_comerciante, fecha_sincronizacion, id_variante_sku, plataforma_destino, stock_enviado, estado_api) 
VALUES (1001, '2026-11-03 12:00:05', 'SKU-LACT-004', 'WooCommerce', 95.0, 'ERROR_401');

INSERT INTO sincronizacion_stock_log (id_comerciante, fecha_sincronizacion, id_variante_sku, plataforma_destino, stock_enviado, estado_api) 
VALUES (1001, '2026-11-04 09:00:00', 'SKU-ABAR-001', 'Shopify', 110.0, 'OK');

INSERT INTO sincronizacion_stock_log (id_comerciante, fecha_sincronizacion, id_variante_sku, plataforma_destino, stock_enviado, estado_api) 
VALUES (1001, '2026-11-04 09:00:05', 'SKU-BEB-015', 'Shopify', 80.0, 'OK');

INSERT INTO sincronizacion_stock_log (id_comerciante, fecha_sincronizacion, id_variante_sku, plataforma_destino, stock_enviado, estado_api) 
VALUES (1001, '2026-11-04 09:00:10', 'SKU-LIM-008', 'Shopify', 25.0, 'OK');

INSERT INTO sincronizacion_stock_log (id_comerciante, fecha_sincronizacion, id_variante_sku, plataforma_destino, stock_enviado, estado_api) 
VALUES (1001, '2026-11-04 12:00:00', 'SKU-SNACK-022', 'WooCommerce', 75.0, 'OK');

INSERT INTO sincronizacion_stock_log (id_comerciante, fecha_sincronizacion, id_variante_sku, plataforma_destino, stock_enviado, estado_api) 
VALUES (1001, '2026-11-04 12:00:05', 'SKU-LACT-004', 'WooCommerce', 85.0, 'OK');