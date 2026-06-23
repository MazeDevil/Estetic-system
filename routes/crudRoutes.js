const express = require('express');

function createCrudRoutes(controller) {
  const router = express.Router();

  router.get('/', controller.index);
  router.get('/novo', controller.create);
  router.post('/', controller.store);
  router.get('/:id/editar', controller.edit);
  router.put('/:id', controller.update);
  router.delete('/:id', controller.destroy);

  return router;
}

module.exports = createCrudRoutes;
