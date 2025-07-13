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

module.exports = {
  generarJWT,
};
