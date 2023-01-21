const express = require('express')
const app = express()

const {Pool} = require('pg');

const pool = new Pool({
    user: 'postgres',
    password: 'Armadillo2021.',
    host: 'localhost',
    database: 'cyf_ecommerce',
    port: 5432
});

const listAllProducts =
    "select products.product_name , suppliers.supplier_name " +
    "from products join suppliers on products.supplier_id = suppliers.id"

const listProductsByName =
    'select products.product_name, suppliers.supplier_name ' +
    ' from products join suppliers on products.supplier_id = suppliers.id ' +
    ' where products.product_name like $1'


app.get('/customers', (req, res) => {
    pool.query('select * from customers', (error, result) => {
        res.json(result.rows)
    })
})

app.get("/products", function (req, res) {
    let productNameLike = req.query.productName

    if (!productNameLike) {
        // Client is not sending any name
        pool.query(listAllProducts, (error, result) => {
            if (error) {
                console.error(e)
                res.send('Error al buscar productos')
            } else {
                res.json(result.rows);
            }
        });
    } else {
        pool.query(listProductsByName, ['%' + productNameLike + '%'])
            .then(result => {res.json(result.rows)})
            .catch(e => {
                console.error(e)
                res.send('Error al buscar productos pro nombre')
            })
    }
});

app.listen(3000, function () {
    console.log("Server is listening on port 3000. Ready to accept requests!");
});

const customersById = 'select * from customers where id = $1'

app.get('/customers/:customersId', (req, res) => {
    let customersId = req.params.customersId
    if (!customersId) {
        pool.query('select * from customers', (error, result) => {
        res.json(result.rows)})
    } else {
        pool.query(customersById, [customersId], (error, result) => {
        res.json(result.rows)})
    }
})


const createNewProduct = 'INSERT INTO products (product_name, unit_price, supplier_id) VALUES ($1,$2,$3)';
app.post('/products', (req, res) => {
    let newProductName = req.body.product_name
    let newProductUnitPrice = req.body.unit_price
    let newProductSupplierId = req.body.supplier_id
    
    if (newProductUnitPrice !== Number){
        res.send('el precio debe ser numerico')
    } else {
        pool.query(createNewProduct, [newProductName,newProductUnitPrice,newProductSupplierId], (error, result) => {
            if (error) {
                console.log(error);
            } else {
                res.json('producto creado')
            }
        })
    }
})

