# 01-band_names_server

Este proyecto es la parte backend de 01-band_names.

Es un servidor de Express al que vamos a configurar la comunicación por Sockets, que permite mantener una comunicación activo-activo entre la app y el server, es decir, ambos se hablarán de manera bilateral.

Este server se podría haber hecho usando otro lenguaje de programación, como Java.

## Creación de proyecto

Creamos la carpeta `01-band_names_server` y accedemos a ella.

En la terminal ejecutamos el comando `npm init -y`, con lo cual creamos el archivo `package.json`.

Usando la terminal vamos a instalar los siguientes paquetes: `npm i express nodemon`.

En la raiz del proyecto, ya usando VSCode, creamos el archivo `index.js`.

## Crear un directorio público

Vamos a hacer que nuestro server regrese un sitio web para poder disparar sockets desde otra instancia.

Es decir, vamos a disparar comunicación por socket desde Flutter y desde el HTML y ambos van a interactuar como si fuera la misma app.

Creamos la carpeta `public` y dentro el archivo `index.html`.

## Variables de entorno y Scripts

Hay que hacer un par de cambios que nos permitan, cuando despleguemos la app a un servidor de producción en la nube, saber cual es el puerto en el que está corriendo mi app.

Para ello instalamos un paquete: `npm i dotenv`.

En la raiz creamos dos archivos, `.env` que no se guarda en Git y `.env.template` que sí.

## Socket.io - Configuración inicial

Configuramos nuestro bakend server para que trabaje utilizando sockets.

El paquete que usaremos es `socket.io` y lo instalaremos: `npm i socket.io`.

Documentación: https://www.npmjs.com/package/socket.io

Ejecutar el proyecto y, en el navegador, acceder a la ruta `http:localhost:3000/socket.io/socket.io.js`. Veremos la documentación necesaria para que nuestra aplicación web necesita para conectarse a nuestro socket server. Esa ruta nos la llevamos a `index.html` a un script así:

```html
<script src="socket.io/socket.io.js"></script>
```

Y debajo creamos otro script que va a ser llamado de la conexión a nuestro socket server.

```html
<script>
  var socket = io();

  socket.on('connect', function() {
    console.log('Conectado al servidor');
  });

  socket.on('disconnect', function() {
    console.log('Perdimos comunicación con el servidor');
  });
</script>
```

Cada vez que nos conectemos vamos a tener un id único en el dispositivo conectado.

## Emitir y escuchar eventos

Esto que vamos a ver es casi exactamente igual a como lo vamos a trabajar en la parte de Flutter.

Vamos a mandar un mensaje desde el cliente y que el servidor lo escuche. A su vez, cuando el servidor escuche algo, quiero mandarle un mensaje del servidor al cliente que está conectado y que el cliente reaccione basado en algo.

En `index.html` (más tarde será la app de Flutter), se emite un evento usando `socket.emit`.

En la parte backend, `index.js` escucharemos el mensaje usando `socket.on`.

Si queremos esuchar en `index.html` solo tenemos que usar `socket.on` y si queremos emitir en el server, usaremos `socket.emit`.

## Archivo independiente de la configuración de sockets

Vamos a mover la lógica de los mensajes por socket de `index.js`, donde no tienen mucho que ver, a un archivo independiente donde estará todo lo relacionado a la comunicación y mensajes por sockets.

En la raiz del proyecto creamos un directorio `sockets` y dentro creamos el archivo `socket.js`.

## Lógica para el manejo de las votaciones

Vamos a añadir la lógica para manejar las votaciones.

Nos creamos un nuevo directorio `models` y dentro creamos dos clases, una que manejará cada una de las instancias que vamos a tener y otra para manejar la colección de cada uno de los BandNames que vamos a tener y la lógica. Las clases son `band.js`y `bands.js`.

Instalamos, para el id, el paquete `uuid`: `npm i uuid`.

Cuando un cliente se conecte, obtendrá el listado completo de las bandas.

## Socket: Emitir bandas registradas

Modificamos `socket.js` para crear una nueva instancia de la clase `Bands` y, cuando un cliente se conecte, emitiremos las bandas con la información actualizada.

Modificamos `index.html` para realizar la prueba de escuchar esa emisión. No olvidar, al hacer la prueba, refrescar el navegador.

## Ejecución del proyecto

Clonar desde GitHub y sustituir el archivo `.env.template` por `.env`.

En la terminal, en la raiz del proyecto ejecutar: `npm run start:dev` o `npm start` (este último sin Live Reload de los cambios, pero necesario al desplegar porque es el que se ejecutará).

Abrir un navegador y acceder a la ruta: `http:localhost:3000`. Hay que refrescar para emitir los mensajes que hay en `index.html`.

Abrir otro navegador y acceder a la misma ruta. Recargar solo en uno de los navegadores para ver como se realiza la emisión-escucha de los mensajes.

**NOTA:** Abrir las DevTools del navegador, porque lo importante va a ocurrir ahí. También visualizar el terminal para ver los mensajes en el server.

## Socket: Votar por una Banda

Cuando toquemos una banda en pantalla, se incrementa en uno la votación a esa banda, el servidor lo recibe y emite un mensaje a todos los clientes conectados, en este caso nuestra conexión web (en la Consola)

Modificamos `socket.js` para escuchar el evento `vote-band`.

Recuperamos el id y realizamos la votación.

Desde la consola del navegador tambíen podemos votar de esta forma: `socket.emit('vote-band', {id: <un_id>});` y veremos que la app de Flutter se refresca con los nuevos valores.

## Socket: Agregar una nueva Banda

Vamos a agregar una nueva banda en Flutter y llamar al servidor de sockets para que lo agregue en BD y comunique a todos los clientes la nueva banda.

Modificamos `socket.js` para escuchar el evento `add-band` y emitirá `active-bands` a todos los clientes conectados.

## Socket: Borrar Banda

Vamos a eliminar una banda cuando movamos el nombre de la banda a la derecha.

Al eliminar desde Flutter, mandaremos el id al backend para que elimine la banda. A su vez, notificará a todos los clientes que se eliminó dicha banda.

Modificamos `socket.js` para escuchar el evento `delete-band` y emitirá `active-bands` a todos los clientes conectados.

## Desplegar en Raspberry Pi

Voy a desplegar este proyecto en mi Raspberry Pi.

Para ello creo los archivos `Dockerfile` y `docker-compose.yml`.

Tengo el contexto de docker apuntado a mi Raspberry Pi: `docker context use docker-pi`.

Ahora ejecuto el comando `docker compose up -d`.

He tenido que cambiar, en el proyecto Flutter, en `socket_service.dart` la ruta del server a la de mi Raspberry Pi.