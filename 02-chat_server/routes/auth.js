/*
  path: /api/login
*/

const { Router } = require('express');
const { check } = require('express-validator');

const { crearUsuario, login, renewToken } = require('../controllers/auth');
const { validarCampos } = require('../middlewares/validar-campos');
const { validarJWT } = require('../middlewares/validar-jwt');

const router = Router();

// Es buena práctica separar la ruta de su controlador.
// El controlador está en controllers/auth.js
// El segundo argumento son los middlewares validadores de express-validator
// y nuestro middleware personalizado.
router.post(
  '/new',
  [
    check('nombre', 'El nombre es obligatorio').not().isEmpty(),
    check('email', 'El correo es obligatorio y debe ser válido').isEmail(),
    check('password', 'La contraseña es obligatorio y debe tener al menos 6 caracteres').isLength({ min: 6 }),
    validarCampos,
  ],
  crearUsuario
);

router.post(
  '/',
  [
    check('email', 'El correo es obligatorio y debe ser válido').isEmail(),
    check('password', 'La contraseña es obligatorio y debe tener al menos 6 caracteres').isLength({ min: 6 }),
    validarCampos
  ],

  login
);

router.get('/renew', validarJWT , renewToken);

module.exports = router;
