db.createCollection("categorias", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      title: "categorias",
      required: ["_id", "nombre_categoria"],
      properties: {
        "_id": { bsonType: "objectId" },
        "nombre_categoria": { bsonType: "string" },
        "slug": { bsonType: "string" },
      },
    },
  },
});

db.createCollection("productos", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      title: "productos",
      required: ["_id", "id_comerciante", "nombre"],
      properties: {
        "_id": { bsonType: "objectId" },
        "id_comerciante": { bsonType: "int" },
        "nombre": { bsonType: "string" },
        "marca": { bsonType: "string" },
        "categoria_id": { bsonType: "objectId" },
        "variantes": { bsonType: "array", items: { bsonType: "object" } },
      },
    },
  },
});

db.createCollection("integraciones_ecommerce", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      title: "integraciones_ecommerce",
      required: ["_id", "id_comerciante", "plataforma"],
      properties: {
        "_id": { bsonType: "objectId" },
        "id_comerciante": { bsonType: "int" },
        "plataforma": { bsonType: "string" },
        "ultima_sincronizacion": { bsonType: "date" },
        "configuracion_api": { bsonType: "array", items: { bsonType: "object" } },
      },
    },
  },
});

db.createCollection("inventario_flujo_local", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      title: "inventario_flujo_local",
      required: ["_id", "id_sucursal", "id_variante_sku"],
      properties: {
        "_id": { bsonType: "objectId" },
        "id_sucursal": { bsonType: "int" },
        "id_variante_sku": { bsonType: "string" },
        "stock_minimo_alerta": { bsonType: "int" },
        "ubicacion_almacen": { bsonType: "string" },
      },
    },
  },
});

db.createCollection("promociones", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      title: "promociones",
      required: ["_id", "id_comerciante", "nombre_campaña"],
      properties: {
        "_id": { bsonType: "objectId" },
        "id_comerciante": { bsonType: "int" },
        "nombre_campaña": { bsonType: "string" },
        "tipo_descuento": { bsonType: "string" },
        "valor": { bsonType: "decimal" },
        "reglas_aplicacion": { bsonType: "array", items: { bsonType: "object" } },
      },
    },
  },
});