const jwt = require('jsonwebtoken');

const generarJWT = (uid) => {

  // Devolvemos una promesa.
  return new Promise((resolve, reject) => {
    const payload = { uid };

    jwt.sign(
      payload,
      process.env.JWT_SECRET,
      // características del token
      {
        expiresIn: '24h',
      },
      // callback que se ejecuta al finalizar la firma del token
      (err, token) => {
        if (err) {
          console.log(err);
          reject('No se pudo generar el JWT');
        } else {
          resolve(token);
        }
      }
    );
  });
};

const comprobarJWT = (token = '') => {
  try {
    const { uid } = jwt.verify(token, process.env.JWT_SECRET);
    // Devuelve un array con el resultado de la verificación.
    return [true, uid];
    
  } catch (error) {
    return [false, null];
  }
}

module.exports = {
  generarJWT,
  comprobarJWT
};
