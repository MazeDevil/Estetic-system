const createCrudRoutes = require('./crudRoutes');
const controller = require('../controllers/agendamentoController');

module.exports = createCrudRoutes(controller);
