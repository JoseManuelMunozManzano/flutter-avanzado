/*
  Path: /api/mensajes
*/

// Solo tenemos una ruta que nos sirve para reconstruir el chat.
// Necesitamos poder validar el token, ya que es la persona que está haciendo la petición,
// y de qué sala tengo que cargar los mensajes (:de).

const { Router } = require('express');
const { validarJWT } = require('../middlewares/validar-jwt');
const { obtenerChat } = require('../controllers/mensajes');

const router = Router();

// Es buena práctica separar la ruta de su controlador.
// El controlador está en controllers/usuarios.js
// Este id es la persona de la que queremos el chat.
router.get('/:de', validarJWT, obtenerChat);

module.exports = router;