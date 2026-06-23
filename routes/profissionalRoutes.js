const createCrudRoutes = require('./crudRoutes');
const controller = require('../controllers/profissionalController');

module.exports = createCrudRoutes(controller);
