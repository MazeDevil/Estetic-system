const Cliente = require('../models/Cliente');
const metadata = require('../models/metadata');
const createCrudController = require('./crudController');

module.exports = createCrudController({
  model: Cliente,
  title: 'Clientes',
  route: '/clientes',
  fields: metadata.clientes,
});
