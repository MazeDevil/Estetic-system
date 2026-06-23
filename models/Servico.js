const BaseModel = require('./BaseModel');
const metadata = require('./metadata');

module.exports = new BaseModel({
  table: 'Servico',
  primaryKey: 'id_servico',
  columns: metadata.servicos,
});
