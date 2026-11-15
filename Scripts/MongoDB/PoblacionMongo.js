// PRODUCTOS

let productosDocs = [];
let marcasBase = ["Nike", "Adidas", "Logitech", "Razer", "Genius", "Don Lucho Brand", "Wilson", "Puma"];
let skusBase = [
    "TEXTIL-CASACA-L-NEGRO", 
    "COMPUTO-TECLADO-RGB", 
    "TEXTIL-POLO-M-AZUL", 
    "TECNOLOGIA-MOUSE-GAMER", 
    "CALZADO-ZAPATILLA-42"
];

let categoriaIds = db.categorias.find({}, { _id: 1 }).toArray().map(c => c._id);
if (categoriaIds.length === 0) {
    for (let c = 0; c < 10; c++) categoriaIds.push(new ObjectId());
}

for (let i = 1; i <= 100; i++) {
    let prodId = new ObjectId();
    let randomComerciante = Math.floor(Math.random() * 110) + 1; // Rango 1 - 110 (PostgreSQL)
    let randomCatId = categoriaIds[Math.floor(Math.random() * categoriaIds.length)];
    let skuSelect = skusBase[(i - 1) % skusBase.length] + "-" + i;
    
    productosDocs.push({
        _id: prodId,
        id_comerciante: NumberInt(randomComerciante),
        nombre: `Producto Tecnológico y Textil ${i}`,
        marca: marcasBase[i % marcasBase.length],
        categoria_id: randomCatId,
        variantes: [
            {
                id_variante_sku: `VAR-${skuSelect}`,
                sku: skuSelect,
                talla: "Única / L",
                color: "Variado",
                precio_venta_sugerido: NumberDecimal((Math.random() * 200 + 50).toFixed(2)),
                costo_promedio: NumberDecimal((Math.random() * 100 + 20).toFixed(2))
            }
        ]
    });
}
db.productos.insertMany(productosDocs);


// INTEGRACIONES_ECOMMERCE

let integracionesDocs = [];
let plataformas = ["Shopify", "WooCommerce", "Mercado Libre", "Magento", "PrestaShop"];

for (let i = 1; i <= 100; i++) {
    let intId = new ObjectId();
    let randomComerciante = Math.floor(Math.random() * 110) + 1; // Rango 1 - 110
    
    integracionesDocs.push({
        _id: intId,
        id_comerciante: NumberInt(randomComerciante),
        plataforma: plataformas[i % plataformas.length],
        ultima_sincronizacion: new Date(),
        configuracion_api: [
            {
                api_key: `key_prod_sec_${i}_abcdef`,
                api_secret: `secret_val_${i}_xyz789`,
                webhook_url: `https://api.comercio${i}.com/webhook/v1`
            }
        ]
    });
}
db.integraciones_ecommerce.insertMany(integracionesDocs);

//PROMOCIONES
let promocionesDocs = [];
let tiposDescuento = ["Porcentaje", "Monto Fijo"];

for (let i = 1; i <= 100; i++) {
    let promoId = new ObjectId();
    let randomComerciante = Math.floor(Math.random() * 110) + 1; // Rango 1 - 110
    
    promocionesDocs.push({
        _id: promoId,
        id_comerciante: NumberInt(randomComerciante),
        nombre_campaña: `Campaña Promocional de Temporada ${i}`,
        tipo_descuento: tiposDescuento[i % tiposDescuento.length],
        valor: NumberDecimal("15.50"),
        reglas_aplicacion: [
            {
                compra_minima: NumberDecimal("100.00"),
                sucursales_permitidas: NumberInt(1),
                metodos_pago_exclusi: "Efectivo y Tarjeta"
            }
        ]
    });
}
db.promociones.insertMany(promocionesDocs);

// INVENTARIO_FLUJO_LOCAL
let inventarioDocs = [];

for (let i = 1; i <= 100; i++) {
    let invId = new ObjectId();
    let randomSucursal = Math.floor(Math.random() * 120) + 1; // Rango 1 - 120 (PostgreSQL sucursal)
    let skuSelect = skusBase[(i - 1) % skusBase.length] + "-" + i;
    
    inventarioDocs.push({
        _id: invId,
        id_sucursal: NumberInt(randomSucursal),
        id_variante_sku: skuSelect,
        stock_minimo_alerta: NumberInt(5),
        ubicacion_almacen: `Pasillo ${i % 10 + 1}, Estante ${Math.floor(i / 10) + 1}`
    });
}
db.inventario_flujo_local.insertMany(inventarioDocs);

//CATEGORIAS
let categoriasDocs = [];
let categoriaIds = [];

for (let i = 1; i <= 100; i++) {
    let catId = new ObjectId();
    categoriaIds.push(catId);
    categoriasDocs.push({
        _id: catId,
        nombre_categoria: `Categoría Comercial y Especializada ${i}`,
        slug: `categoria-comercial-especializada-${i}`
    });
}
db.categorias.insertMany(categoriasDocs);