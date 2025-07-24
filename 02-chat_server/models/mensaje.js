const { Schema, model } = require('mongoose');

// Schema nos ayuda a crear el modelo, como luce el modelo.
// model es lo que se va a ver fuera de este archivo.

const MensajeSchema = Schema(
  {
    de: {
      type: Schema.Types.ObjectId,
      ref: 'Usuario',
      required: [true, 'El usuario emisor es obligatorio'],
    },
    para: {
      type: Schema.Types.ObjectId,
      ref: 'Usuario',
      required: [true, 'El usuario receptor es obligatorio'],
    },
    mensaje: {
      type: String,
      required: [true, 'El mensaje es obligatorio'],
    },
  },
  { timestamps: true } // Agrega createdAt y updatedAt automáticamente
);

// Sobreescribimos el método toJSON para convertir a JSON solo el objeto.
// Hay que usar una función tradicional, no de flecha, para que 'this' se refiera al documento actual.
// Las funciones de flecha no modifican el valor al que apunta 'this'.
MensajeSchema.method('toJSON', function () {
  const { __v, _id, ...object } = this.toObject();
  return object;
});

// Mongoose por defecto añade el plural.
module.exports = model('Mensaje', MensajeSchema);
