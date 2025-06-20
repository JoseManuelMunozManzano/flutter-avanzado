const { io } = require('../index');
const Band = require('../models/band');
const Bands = require('../models/bands');

// Este arreglo de bandas solo se ejecuta (se crea la instancia) una vez al iniciar el servidor.
const bands = new Bands();

bands.addBand(new Band('Breaking Benjamin'));
bands.addBand(new Band('Bon Jovi'));
bands.addBand(new Band('Heroes del Silencio'));
bands.addBand(new Band('Metallica')); // 4

// Mensajes de Sockets.
// El client es una computadora que se conecta al servidor.
io.on('connection', (client) => {
  console.log('Cliente conectado');

  // Cuando un cliente se conecte, haremos una emisión de las bandas registradas en el servidor.
  client.emit('active-bands', bands.getBands());

  client.on('disconnect', () => {
    console.log('Cliente desconectado');
  });

  // client.on('mensaje', (payload) => {
  //   console.log('Mensaje', payload);

  //   // Mensaje a todos los clientes conectados usando io.emit()
  //   // Para enviar un mensaje solo a un cliente específico, se puede usar client.emit()
  //   io.emit('mensaje', { admin: 'Nuevo mensaje' });
  // });

  // Votamos y realizamos la notificación a todos los clientes conectados.
  // io es el servidor y todos los clientes conectados están ahí.
  client.on('vote-band', (payload) => {
    bands.voteBand(payload.id);
    io.emit('active-bands', bands.getBands());
  });

  // Escuchar: add-band, creamos la nueva banda y la agregamos a la lista de bandas y notificamos a todos los clientes conectados.
  client.on('add-band', (payload) => {
    const newBand = new Band(payload.name);
    bands.addBand(newBand);
    io.emit('active-bands', bands.getBands());
  });

  // Escuchar: delete-band, eliminamos la banda y notificamos a todos los clientes conectados.
  client.on('delete-band', (payload) => {
    bands.deleteBand(payload.id);
    io.emit('active-bands', bands.getBands());
  });

  // Escuchamos y enviamos el mensaje a todos los clientes conectados.
  client.on('emitir-mensaje', (payload) => {
    // console.log(payload);
    // Emite el mensaje a todos los clientes conectados menos al que lo emitió en primer lugar.
    client.broadcast.emit('nuevo-mensaje', payload);
  });
});
