const createCrudRoutes = require('./crudRoutes');
const controller = require('../controllers/servicoController');

module.exports = createCrudRoutes(controller);
