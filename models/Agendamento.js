const BaseModel = require('./BaseModel');
const metadata = require('./metadata');

module.exports = new BaseModel({
  table: 'Agendamento',
  primaryKey: 'id_agendamento',
  columns: metadata.agendamentos,
});
