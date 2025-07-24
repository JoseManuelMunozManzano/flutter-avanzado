const { Schema, model } = require('mongoose');

// Schema nos ayuda a crear el modelo, como luce el modelo.
// model es lo que se va a ver fuera de este archivo.

const UsuarioSchema = Schema({
  nombre: {
    type: String,
    required: [true, 'El nombre es obligatorio'],
    trim: true,
  },
  email: {
    type: String,
    required: [true, 'El correo es obligatorio'],
    unique: true,
  },
  password: {
    type: String,
    required: [true, 'La contraseña es obligatoria'],
  },
  online: {
    type: Boolean,
    default: false,
  },
});

// Sobreescribimos el método toJSON para que no muestre el password y __v al convertir a JSON.
// Hay que usar una función tradicional, no de flecha, para que 'this' se refiera al documento actual.
// Las funciones de flecha no modifican el valor al que apunta 'this'.
UsuarioSchema.method('toJSON', function () {
  const { __v, password, _id, ...object } = this.toObject();
  object.uid = _id; // Renombramos _id a uid
  return object;
});

// Mongoose por defecto añade el plural.
module.exports = model('Usuario', UsuarioSchema);