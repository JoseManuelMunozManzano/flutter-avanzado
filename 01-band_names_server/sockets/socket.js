const {io} = require('../index');

// Mensajes de Sockets.
// El client es una computadora que se conecta al servidor.
io.on('connection', (client) => {
  console.log('Cliente conectado');

  client.on('disconnect', () => {
    console.log('Cliente desconectado');
  });

  client.on('mensaje', (payload) => {
    console.log('Mensaje', payload);

    // Mensaje a todos los clientes conectados usando io.emit()
    // Para enviar un mensaje solo a un cliente específico, se puede usar client.emit()
    io.emit('mensaje', { admin: 'Nuevo mensaje' });
  });
});
