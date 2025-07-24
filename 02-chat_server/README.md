# 02-chat_server

En esta sección nos centramos en el backend, en el manejo de las sesiones de los usuarios, en JWT y gestión de contraseñas, en generar y guardar usuarios, validaciones para no tener dos usuarios duplicados...

Usaremos MongoDB para guardar los mensajes y los usuarios.

Podremos trabajar con servicios REST y con sockets.

Preguntas frecuentes:

- Si tenemos un usuario que no está conectado, pero yo le escribo, ¿cómo lo guardo en BD?
- ¿Cómo autenticar un socket?

## Creación de proyecto

Este proyecto se ha creado a partir de `01-band_names_server`, eliminando la carpeta `models` y un poco de código no necesario de `sockets.js` y `index.html`.

Lo vamos a expandir con las necesidades que tenemos en esta aplicación.

## Instalaciones

Para mirar documentación de los paquetes que vamos a instalar, podemos ir a:

`https://www.npmjs.com/`

Instalamos los siguientes paquetes:

`npm i bcryptjs cors express-validator jsonwebtoken mongoose`

## MongoDB

Voy a usar el MongoDB que tengo en mi Raspberry Pi.

Acceder en el navegador a la ruta: `https://mongoosejs.com/`. Es lo que vamos a usar para conectarnos a la base de datos MongoDB desde nuestra aplicación de Node.js. La idea es no tener que escribir SQLs directamente, sino usar este ORM.

En el archivo `.env` añadimos la variable de entorno `DB_CNN` con la URL de conexión a nuestra base de datos MongoDB.

En la raiz de nuestro proyecto creamos el directorio `database` y dentro de él el archivo `config.js` con la configuración de conexión a la base de datos.

## Crear nuestro primer Rest endpoint - Crear usuario

Desde la aplicación de Flutter tenemos una pantalla de login y registro. En el server esto se traduce en un endpoint REST que nos permita crear un usuario. No es recomendable hacerlo con sockets.

Modificamos `index.js` vamos a configurar la lectura/parseo de la información que viene en el body de una petición HTTP e indicaremos las rutas.

Para la configuración de las rutas, en la raiz del proyecto creamos el directorio `routes` y dentro de él el archivo `auth.js`.

Como es buena práctica separa la ruta de su controlador, creamos una carpeta `controllers` en la raiz del proyecto y dentro de ella el archivo `auth.js` donde implementaremos la lógica de creación de un usuario.

## Express Validator

La función `crearUsuario` no debe ejecutarse si no viene toda la información que esperamos.

En `routes/auth.js` añadimos las validaciones, que son middlewares que se ejecutan antes de la función del controlador.

En `controllers/auth.js` añadimos la lógica de validación de los datos que nos llegan, pero eso no es cómodo porque habría que hacerlo para cada endpoint.

## Middleware personalizado - ValidarCampos

Para evitar tener que duplicar en cada endpoint la lógica de validación, creamos en la raiz del proyecto un directorio `middlewares` y dentro un archivo `validar-campos.js` en la carpeta `controllers` donde definiremos las validaciones que vamos a usar en los endpoints. Si las validaciones no se cumplen, no continuamos al controller, sino que devolvemos un error.

## Crear usuario en base de datos

Para grabar el usuario en la BD, primero vamos a crear un modelo. Es una clase que se encarga de tener toda la información que vamos a necesitar para grabar en la BD.

En la raiz del proyecto creamos el directorio `models` y dentro de él el archivo `usuario.js`.

El modelo lo usamos en `controllers/auth.js` para grabar el usuario en la base de datos.

## Validar que no existe el mail

El mail es nuestra clave primaria de la tabla Usuario. Controlamos que no exista en la base de datos antes de grabar el usuario.

Modificamos `controllers/auth.js` para buscar el usuario por su email antes de grabarlo. Si ya existe, devolvemos un error.

## Encriptar la contraseña

Actualmente estamos guardando la contraseña en texto plano, lo cual no es seguro. Vamos a encriptarla antes de guardarla en BD.

Encriptaremos la contraseña usando un hash de una sola vía. Esto significa que no podremos recuperar la contraseña original, pero sí podremos verificar si una contraseña introducida por el usuario coincide con la que tenemos en la base de datos.

Modificamos `controllers/auth.js`.

## Generar JWT

Para autenticar a los usuarios, vamos a generar un JWT (JSON Web Token) que se enviará al cliente y se usará para autenticar las peticiones posteriores.

Modificamos `controllers/auth.js`, pero todas las implementaciones de JWT la haremos en un middleware que crearemos en la nueva carpeta de la raiz `helpers` llamado `jwt.js`.

En `.env` añadimos la variable de entorno `JWT_SECRET` con una clave secreta que usaremos para firmar el token.

En Flutter, tomaremos el token y lo guardaremos en el almacenamiento local del dispositivo para usarlo en futuras peticiones, como método de autenticación, tanto de los servicios como de los sockets.

## Login de usuario

Vamos a trabajar con el login de usuario. Es parecido a la creación de usuarios, pero sin grabar en BD.

Creamos un nuevo endpoint en `routes/auth.js` y su controlador en `controllers/auth.js`.

## Renovar el JWT

Vamos a crear otro endpoint para verificar el JWT. Esto es útil para mantener la sesión activa sin que el usuario tenga que volver a iniciar sesión.

Creamos un nuevo endpoint en `routes/auth.js` y su controlador en `controllers/auth.js`.

Creamos un nuevo middleware en `middlewares/validar-jwt.js` que se encargará de verificar el JWT en las peticiones.

## Generar un nuevo JWT y retornar información del usuario

En nuestra funcion `renewToken` del controlador `controllers/auth.js`, vamos a generar un nuevo JWT y retornar la información del usuario.`

## Ejecución del proyecto

Clonar desde GitHub y sustituir el archivo `.env.template` por `.env`, indicando sus valores correctos.

Instalar las dependencias: `npm install`.

En la terminal, en la raiz del proyecto ejecutar: `npm run start:dev` o `npm start` (este último sin Live Reload de los cambios, pero necesario al desplegar porque es el que se ejecutará).

Abrir un navegador y acceder a la ruta: `http:localhost:3000`. Hay que refrescar para emitir los mensajes que hay en `index.html`.

Abrir otro navegador y acceder a la misma ruta. Recargar solo en uno de los navegadores para ver como se realiza la emisión-escucha de los mensajes.

## Backend y Frontend - Autenticación

Levantar este backend con `npm run start:dev` y el frontend de Flutter `02-chat`.

## Socket.io en nuestra aplicación de chat

Empezamos a hacer la comunicación en tiempo real con Socket.io.

## Autenticando el cliente conectado por sockets

Tenemos que utilizar el JWT para autenticar al cliente que se conecta por sockets. El servidor debe verificar que el JWT es válido antes de permitir la conexión del socket. Si el token no es válido, se debe desconectar el socket.

Modificamos `sockets/socket.js` para autenticar el socket con el JWT. El JWT lo obtenemos del cliente a través de los headers de la conexión del socket. Y en este programa usamos `socket.handshake.headers['x-token']` para obtener el token.

En `helpers/jwt.js` creamos una función `comprobarJWT` que se encargará de verificar el JWT. Esta función se usará en el socket para autenticar al cliente.

Como prueba, desde el cliente Flutter, deberemos conectarnos al socket, ya que se envía el JWT. Pero si accedemos usando el navegador a `http://localhost:3000` (ver consola), no se enviará el JWT y el socket no se conectará.

## Actualizar base de datos cuando un usuario se conecta

Tenemos un usuario conectado correctamente, pero en la BD MongoDB no tenemos información de que este usuario está conectado (es nuestro campo online). Vamos a actualizar la BD para reflejar esto, tanto al conectarse como al desconectarse.

No queremos cargar mucho el archivo `sockets/socket.js`, así que creamos un nuevo archivo en la carpeta `controllers` llamado `socket.js` donde implementaremos los métodos de interacción con los sockets.

Modificamos `sockets/socket.js` para usar los métodos de `controllers/socket.js` al conectarse y desconectarse.

## Servicio REST para retornar los usuarios conectados

Queremos cargar en el front los usuarios conectados cuando se haga un pull-to-refresh. Para ello, en la carpeta `routes` creamos un nuevo archivo `usuarios.js` donde definiremos un endpoint REST que retorne los usuarios conectados.

En la carpeta `controllers` creamos un nuevo archivo `usuarios.js` donde implementaremos la lógica para obtener los usuarios conectados.

## Teoría sobre el envío de mensajes privados por socket

Imaginemos tres dispositivos conectados al socket server.

- client.emit: Si el primer dispositivo emite el mensaje, si nuestro servidor llama a client.emit, se lo emite a la persona que emitió el primer mensaje.
- io.emit: io hace referencia a todos los clientes conectados, por lo que si el primer dispositivo emite un mensaje, se lo envía a todos los dispositivos conectados.
- Salas o canales: Si queremos que el primer dispositivo y el tercero hablen entre sí, siendo el primer dispositivo el que emite el mensaje, este se comunica con el servidor indicando el destinatario. Es el servidor el que reenvía el mensaje al dispositivo tres.
  - Cuando un dispositivo se conecta a un socket server, se conecta automáticamente a dos canales, el `canal global`, que permite a io.emit hacer un broadcast de un mensaje a todos los clientes conectados, y el `canal que tiene el nombre del mismo id del socket`. El canal global es el que se usa para emitir mensajes a todos los dispositivos conectados, mientras que el otro canal es que se usa para enviar mensajes privados a un dispositivo específico. El id es muy volátil, es el `client.id` y cada vez que nos reconectamos cambia, por lo que tendríamos que estar actualizando el id muchas veces. Esto no lo vamos a hacer así. Los sockets están identificados por el uid de cada una de las personas, o su correo electrónico, y esto está en Mongo y son únicos.

Por tanto, vamos a hacer lo siguiente. Usando `client.join('UID de mongo / correo electrónico')` vamos a unir al cliente a una sala que va a tener el UID (o correo electrónico) de Mongo que es único. Es mejor el UID, y es lo que vamos a usar.

## Emitir un mensaje del chat al servidor

Modificamos `sockets/socket.js` para que cuando un cliente emita un mensaje, este se envíe a la sala correspondiente al UID del destinatario.

## Escuchar mensajes del servidor en Flutter

Modificamos `socket_service.dart` para reenviar el mensaje a un canal usando `io.to`

## Backend - Modelo de mensajes

La información que se escribe la vamos a persistir como histórico.

Vamos a crear un modelo para guardarlo en mongoose. En `models` creamos un archivo `mensaje.js`.

## Guardar mensaje en base de datos

Vamos a utilizar nuestro modelo para grabar el mensaje en la base de datos.

Modificamos `controllers/socket.js` para crear una nueva función `grabarMensaje` que se encargará de guardar el mensaje en la base de datos.

Modificamos `sockets/socket.js` para usar la función `grabarMensaje` al recibir un mensaje del cliente.

## Backend - Servicio para obtener los mensajes de chat

Vamos a crear un servicio REST para obtener los mensajes de chat. Esto nos permitirá cargar el histórico de mensajes en el cliente.

Modificamos `index.js` para crear una nueva ruta `/api/mensajes` que apunte a una nueva ruta `routes/mensajes`.

Creamos un nuevo archivo en `routes/mensajes.js` donde definiremos el endpoint REST para obtener los mensajes.

Creamos un nuevo archivo en `controllers/mensajes.js` donde implementaremos la lógica para obtener los mensajes de la base de datos.

## Testing

Se ha probado con Postman.

En la carpeta `postman` en la raiz del proyecto, hay un archivo `Flutter-Chat.postman_collection.json` que contiene las peticiones que se pueden hacer al servidor.

Modificamos `index.js` para usar las rutas de `usuarios.js`.

Para probar, primero tenemos que obtener un token válido. Para ello, hacemos un POST a `/api/login` con un usuario existente. Luego, usamos ese token en las peticiones a `/api/usuarios` para obtener los usuarios conectados.

## Desplegar en Raspberry Pi

Voy a desplegar este proyecto en mi Raspberry Pi.

Para ello creo los archivos `Dockerfile` y `docker-compose.yml`.

Tengo el contexto de docker apuntado a mi Raspberry Pi: `docker context use docker-pi`.

Ahora ejecuto el comando `docker compose up -d`.

He tenido que cambiar, en el proyecto Flutter, en `socket_service.dart` la ruta del server a la de mi Raspberry Pi.