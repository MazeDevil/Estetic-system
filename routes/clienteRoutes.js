const createCrudRoutes = require('./crudRoutes');
const controller = require('../controllers/clienteController');

module.exports = createCrudRoutes(controller);
