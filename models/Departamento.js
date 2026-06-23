const BaseModel = require('./BaseModel');
const metadata = require('./metadata');

module.exports = new BaseModel({
  table: 'Departamento',
  primaryKey: 'id_departamento',
  columns: metadata.departamentos,
});
