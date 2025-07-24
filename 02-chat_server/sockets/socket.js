const { io } = require('../index');
const { comprobarJWT } = require('../helpers/jwt');
const {usuarioConectado, usuarioDesconectado, grabarMensaje} = require('../controllers/socket');

io.on('connection', (client) => {
  console.log('Cliente conectado');

  // Obtener cliente con JWT
  // Usamos client.handshake.headers para obtener los headers de la conexión
  // Nos interesa el header 'x-token' que contiene el JWT.
  const [valido, uid] = comprobarJWT(client.handshake.headers['x-token']);

  // Verificar autenticación.
  if (!valido) {
    return client.disconnect();
  }

  // Cliente autenticado.
  usuarioConectado(uid);

  // Ingresar al usuario a una sala en particular.
  // Sala global: Todos los dispositivos conectados se encuentran aquí. Por eso funciona io.emit
  // Envío a un cliente privado: Se puede usar client.id, que es el identificador único del cliente conectado, y
  //    lo genera el socket server de forma automática.
  // Sala individual: Utilizaremos el UID del usuario al que queremos mandar el mensaje y que tenemos guardado en Mongo.
  //    Se genera una sala con el nombre del UID.
  // Para unir una persona a esa sala con nombre UID:
  client.join(uid);

  // Escuchar del cliente el mensaje-personal y lo reenviamos a la sala correspondiente.
  client.on('mensaje-personal', async (payload) => {
    await grabarMensaje(payload);
    io.to(payload.para).emit('mensaje-personal', payload);
  });

  // TENEMOS QUE GUARDAR EL MENSAJE EN BD PARA CARGARLO LUEGO COMO HISTORICO.
  // Para enviar un mensaje a esa sala, se usa:
  // client.to(uid).emit('mensaje-personal');

  client.on('disconnect', () => {
    console.log('Cliente desconectado');
    usuarioDesconectado(uid);
  });

  // client.on('mensaje', (payload) => {
  //   console.log('Mensaje', payload);
  //   io.emit('mensaje', { admin: 'Nuevo mensaje' });
  // });

});
