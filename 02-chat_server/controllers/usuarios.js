const { response } = require('express');
const Usuario = require('../models/usuario');

const getUsuarios = async (req, res = response) => {

  // Paginación.
  const desde = Number(req.query.desde) || 0;

  // Ordenamos para que los que están conectados aparezcan primero (como es un booleano se pone el negativo).
  // Debemos evitar que una persona se pueda enviar mensajes a sí mismo, por lo que no se incluye el usuario que hace la petición.
  // Es el dueño del token.
  // Es mejor filtrarlo aquí que en el frontend.
  const usuarios = await Usuario
    .find({_id: { $ne: req.uid }})
    .sort('-online')
    .skip(desde)
    .limit(20);

  res.json({
    ok: true,
    usuarios,
  })
};

module.exports = {
  getUsuarios,
};