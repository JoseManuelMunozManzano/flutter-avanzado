const { validationResult } = require("express-validator");

// middleware para validar los campos de las peticiones.
const validarCampos = (req, res, next) => {
  const errores = validationResult(req);

  if (!errores.isEmpty()) {
    return res.status(400).json({
      ok: false,
      errors: errores.mapped(),
    });
  }

  // Este next() es un callback que indica a Express, que, si todo sale bien,
  // continue con el siguiente middleware o controlador.
  next();
}

module.exports = {
  validarCampos,
}