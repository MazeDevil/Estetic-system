const express = require('express');
const consultaController = require('../controllers/consultaController');

const router = express.Router();

router.get('/agenda', consultaController.agenda);

module.exports = router;
