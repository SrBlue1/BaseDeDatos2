db.createRole({
  role: "rolAdminProductos",
  privileges: [
    { 
      resource: { db: "catalogo", collection: "productos" }, 
      actions: ["find", "insert", "update", "remove", "createIndex", "collStats"] 
    }
  ],
  roles: []
});

db.createUser({
  user: "llanos",
  pwd: "Llanos2026*",
  roles: [
    { role: "rolAdminProductos", db: "catalogo" },
    { role: "root", db: "admin" }
  ]
});



db.createRole({
  role: "rolAdminEcommerce",
  privileges: [
    { 
      resource: { db: "catalogo", collection: "integraciones_ecommerce" }, 
      actions: ["find", "insert", "update", "remove", "createIndex", "collStats"] 
    }
  ],
  roles: []
});

db.createUser({
  user: "romero",
  pwd: "Romero2026*",
  roles: [
    { role: "rolAdminEcommerce", db: "catalogo" }
  ]
});



db.createRole({
  role: "rolAdminInventarioFlujo",
  privileges: [
    { 
      resource: { db: "catalogo", collection: "inventario_flujo_local" }, 
      actions: ["find", "insert", "update", "remove", "createIndex", "collStats"] 
    }
  ],
  roles: []
});

db.createUser({
  user: "zorrilla",
  pwd: "Zorrilla2026*",
  roles: [
    { role: "rolAdminInventarioFlujo", db: "catalogo" }
  ]
});




db.createRole({
  role: "rolAdminPromociones",
  privileges: [
    { 
      resource: { db: "catalogo", collection: "promociones" }, 
      actions: ["find", "insert", "update", "remove", "createIndex", "collStats"] 
    }
  ],
  roles: []
});

db.createUser({
  user: "mescua",
  pwd: "Mescua2026*",
  roles: [
    { role: "rolAdminPromociones", db: "catalogo" }
  ]
});