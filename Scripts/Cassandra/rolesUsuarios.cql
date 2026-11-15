CREATE ROLE llanos WITH password = 'Llanos2026*' AND login = true AND superuser = true;
GRANT CREATE, ALTER, SELECT, MODIFY, EXECUTE ON KEYSPACE mype_inventario_kardex TO llanos;

CREATE ROLE romero WITH password = 'Romero2026*' AND login = true AND superuser = false;
GRANT CREATE, ALTER, SELECT, MODIFY, EXECUTE ON KEYSPACE mype_inventario_kardex TO romero;

CREATE ROLE zorrilla WITH password = 'Zorrilla2026*' AND login = true AND superuser = false;
GRANT CREATE, ALTER, SELECT, MODIFY, EXECUTE ON KEYSPACE mype_inventario_kardex TO zorrilla;

CREATE ROLE mescua WITH password = 'Mescua2026*' AND login = true AND superuser = false;
GRANT CREATE, ALTER, SELECT, MODIFY, EXECUTE ON KEYSPACE mype_inventario_kardex TO mescua;