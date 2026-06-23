const Agendamento = require('../models/Agendamento');
const metadata = require('../models/metadata');
const createCrudController = require('./crudController');

module.exports = createCrudController({
  model: Agendamento,
  title: 'Agendamentos',
  route: '/agendamentos',
  fields: metadata.agendamentos,
});
