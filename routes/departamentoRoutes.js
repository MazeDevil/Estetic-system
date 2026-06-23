const createCrudRoutes = require('./crudRoutes');
const controller = require('../controllers/departamentoController');

module.exports = createCrudRoutes(controller);
