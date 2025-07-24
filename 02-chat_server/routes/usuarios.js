/*
  path: /api/usuarios
*/

const { Router } = require('express');
const { validarJWT } = require('../middlewares/validar-jwt');
const { getUsuarios } = require('../controllers/usuarios');

const router = Router();

// Es buena práctica separar la ruta de su controlador.
// El controlador está en controllers/usuarios.js
router.get('/', validarJWT, getUsuarios);

module.exports = router;
