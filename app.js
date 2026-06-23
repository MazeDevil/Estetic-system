const express = require('express');
const mysql = require('mysql2/promise');
const expressHandlebars = require('express-handlebars');
const path = require('path');
const PORT = process.env.PORT || 3000;

const app = express();

app.engine('handlebars', expressHandlebars.engine);

app.set('view engine', 'handlebars');

app.set('views', './views');

app.use(express.static(path.join(__dirname, 'public')));

app.get('/', async (req, res) => {
    res.render('index');
});

app.listen(PORT, function(){
    console.log(`Servidor está rodando na porta ${PORT}`);
});