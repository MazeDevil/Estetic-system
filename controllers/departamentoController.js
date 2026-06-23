const Departamento = require('../models/Departamento');
const metadata = require('../models/metadata');
const createCrudController = require('./crudController');

module.exports = createCrudController({
  model: Departamento,
  title: 'Departamentos',
  route: '/departamentos',
  fields: metadata.departamentos,
});
