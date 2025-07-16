const { response } = require('express');
const bcrypt = require('bcryptjs');

const Usuario = require('../models/usuario');

const { generarJWT } = require('../helpers/jwt');

const crearUsuario = async (req, res = response) => {
  // Esta es la información que me interesa del body.
  const { email, password } = req.body;

  // Verificamos si el email ya existe.
  try {
    const existeEmail = await Usuario.findOne({ email });
    if (existeEmail) {
      return res.status(400).json({
        ok: false,
        msg: 'El correo ya está registrado',
      });
    }

    // Extraemos la información que viene en el body de la petición.
    // Aunque enviemos todo el body, el modelo filtrará lo que no aparezca en el.
    const usuario = new Usuario(req.body);

    // Encriptar la contraseña.
    const salt = bcrypt.genSaltSync(10);
    usuario.password = bcrypt.hashSync(password, salt);

    // Guardamos el usuario en la base de datos.
    await usuario.save();

    // Generar un token JWT.
    const token = await generarJWT(usuario.id);

    // Devolvemos una respuesta al cliente.
    // Aquí llamamos al método toJSON que hemos definido en el modelo Usuario.
    // Esto nos permitirá renombrar _id a uid y eliminar password y __v.
    res.json({
      ok: true,
      usuario,
      token,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      ok: false,
      msg: 'Hable con el administrador',
    });
  }
};

const login = async (req, res = response) => {
  const { email, password } = req.body;

  try {
    const usuarioDB = await Usuario.findOne({ email });
    if (!usuarioDB) {
      return res.status(404).json({
        ok: false,
        msg: 'Email no encontrado', // En la vida real no informamos al usuario del problema concreto.
      });
    }

    // Validar la contraseña.
    // Comparamos la contraseña que nos llega en el body con la que tenemos en la base de datos.
    const validPassword = bcrypt.compareSync(password, usuarioDB.password);
    if (!validPassword) {
      return res.status(400).json({
        ok: false,
        msg: 'La contraseña no es válida',
      });
    }

    // Generar un token JWT.
    const token = await generarJWT(usuarioDB.id);

    res.json({
      ok: true,
      usuario: usuarioDB,
      token,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      ok: false,
      msg: 'Hable con el administrador',
    });
  }
};

const renewToken = async (req, res = response) => {
  // Este uid del usuario lo hemos guardado en el middleware validarJWT.
  const uid = req.uid;

  try {
    // Generar un nuevo token JWT.
    const token = await generarJWT(uid);

    // Obtener el usuario por uid.
    const usuario = await Usuario.findById(uid);
    if (!usuario) {
      return res.status(404).json({
        ok: false,
        msg: 'Usuario no encontrado',
      });
    }

    res.json({
      ok: true,
      usuario,
      token,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      ok: false,
      msg: 'Hable con el administrador',
    });
  }
};

module.exports = {
  crearUsuario,
  login,
  renewToken,
};
