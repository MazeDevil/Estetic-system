const Servico = require('../models/Servico');
const metadata = require('../models/metadata');
const createCrudController = require('./crudController');

module.exports = createCrudController({
  model: Servico,
  title: 'Servicos',
  route: '/servicos',
  fields: metadata.servicos,
});
