const BaseModel = require('./BaseModel');
const metadata = require('./metadata');

module.exports = new BaseModel({
  table: 'Profissional',
  primaryKey: 'id_profissional',
  columns: metadata.profissionais,
});
