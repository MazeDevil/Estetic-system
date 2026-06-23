const Profissional = require('../models/Profissional');
const metadata = require('../models/metadata');
const createCrudController = require('./crudController');

module.exports = createCrudController({
  model: Profissional,
  title: 'Profissionais',
  route: '/profissionais',
  fields: metadata.profissionais,
});
