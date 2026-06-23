const BaseModel = require('./BaseModel');
const metadata = require('./metadata');

module.exports = new BaseModel({
  table: 'Cliente',
  primaryKey: 'id_cliente',
  columns: metadata.clientes,
});
