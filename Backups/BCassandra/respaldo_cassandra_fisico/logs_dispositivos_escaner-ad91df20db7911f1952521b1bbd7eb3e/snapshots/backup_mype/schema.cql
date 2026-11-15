CREATE TABLE IF NOT EXISTS mype_inventario_kardex.logs_dispositivos_escaner (
    id_usuario int,
    fecha_log timestamp,
    codigo_barras_leido text,
    modelo_celular text,
    resultado text,
    tiempo_respuesta_ms int,
    PRIMARY KEY (id_usuario, fecha_log)
) WITH ID = ad91df20-db79-11f1-9525-21b1bbd7eb3e
    AND CLUSTERING ORDER BY (fecha_log DESC)
    AND additional_write_policy = '99p'
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND cdc = false
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '16', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND memtable = 'default'
    AND crc_check_chance = 1.0
    AND default_time_to_live = 0
    AND extensions = {}
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair = 'BLOCKING'
    AND speculative_retry = '99p';
