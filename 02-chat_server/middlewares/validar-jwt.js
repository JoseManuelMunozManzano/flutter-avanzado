const jwt = require('jsonwebtoken');

const validarJWT = (req, res, next) => {
  // Leer el token del header (en Postman se añade en los Headers para pruebas también).
  const token = req.header('x-token');

  // Verificar si no hay token.
  if (!token) {
    return res.status(401).json({
      ok: false,
      msg: 'No hay token en la petición',
    });
  }

  try {
    // Verificar el token.
    const { uid } = jwt.verify(token, process.env.JWT_SECRET);
    req.uid = uid; // Guardar el uid en la request para usarlo en otros middlewares o controladores.

    next(); // Continuar con el siguiente middleware o controlador.
  } catch (error) {
    return res.status(401).json({
      ok: false,
      msg: 'Token no válido',
    });
  }
};

module.exports = {
  validarJWT,
};
