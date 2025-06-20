# 01-band_names

## Creación del proyecto

Creamos el proyecto band_names usando VSCode.

En la carpeta `lib` se crea la carpeta `pages` y dentro el archivo `home_page.dart`.

Se ha modificado `main.dart` para que tenga como ruta `home`.

## Crear un modelo para el manejo de bandas

Creamos un modelo que se va a encargar de manejar la información de como va a lucir una banda.

En la carpeta `lib` se crea la carpeta `models` y dentro el archivo `band.dart`.

## Interfaz básica de nuestro HomePage

Con nuestro modelo creado, volvemos a `home_page.dart` para crear la interfaz de usuario que vamos a mostrar en pantalla.

## InputDialog y CupertinoDialog - Añadir a la lista

Al tocar el botón queremos que muestre un diálogo, poder ingresar una información, tocar Guardar y crear una nueva banda en el listado. 

Esto, más adelante, acabará lanzando una comunicación al backend y este lo agregará a un listado de bandas y regresará un nuevo id.

Se modifica `home_dart.page`.

## Borrar una banda - Dismissible

Vamos a poder deslizar el nombre de la banda a la derecha y aparecerá una opción en rojo para indicar al usuario que se va a borrar la banda. No vamos a hacer el proceso de eliminación de la lista porque cuando lo conectemos al backend el procedimiento va a ser diferente.

Se modifica `home_dart.page`.

## Socket Service - Conectar nuestra App con el Socket Server

En la carpeta `pages` creamos una nueva página `status_page.dart` y ponemos una nueva ruta en `main.dart`.

Vamos a crear un servicio que sea capaz de tener toda la comunicación que vamos a necesitar en esta y otras aplicaciones que se vayan a comunicar a un socket service basado en `socket.io`.

En la carpeta `lib` creamos una nueva carpeta `services` y dentro el archivo `socket_service.dart` que se encarga de expandir la comunicación con mi servidor en cualquier parte de mi app donde lo necesite.

Necesitamos instalar dos paquetes: `socket_io_client` y `provider`.

Documentación: `https://pub.dev/packages/socket_io_client` y `https://pub.dev/packages/provider`.

## Mostrar el status del Servidor de Sockets

Vamos a indicar en nuestra UI si estamos conectados o desconectados.

Modificamos `status_page.dart` y `socket_service.dart`.

## Escuchar eventos del Servidor de Sockets

Vamos a escuchar cuando mi backend server emita un evento.

Modificamos `socket_service.dart`.

**PRUEBA**

Ejecutar el backend y acceder al navegador. A la vez mirar el Debug Console de Flutter.

En el navegador abrir las DevTools y acceder a Console. Ahí, escribir `socket.emit('emitir-mensaje', {nombre: José Manuel, mensaje: 'Hola Mundo!'});`

## Emitir evento de sockets desde Flutter

Vamos a realizar el proceso inverso a la clase anterior, es decir, desde Flutter vamos a emitir un mensaje o evento que acabarán recibiendo todos los clientes conectados.

**PRUEBA**

Ejecutar el backend y acceder al navegador. Abrir las DevTools del navegador.

En Flutter pulsar el botón y en las DevTools del navegador, en la pestaña Console, debe aparecer `{ 'nombre': 'Flutter', 'mensaje': 'Hola desde Flutter',}`.

## Indicador visual si hay conexión con el Socket Server

Ya sabemos como conocer el estado del servidor y sabemos como emitir mensajes.

Volvemos a `main.dart` y cambiamos la propiedad `initialRoute` de `status` a `home`.

Modificamos `home_page.dart` para colocar un icono que nos permitirá saber cuando está conectado al servidor y cuando no.

## Flutter: Escuchar evento 'active-bands'

Vamos a escuchar el evento `active-bands`.

Modificamos `home_page.dart`.

## Socket: Votar por una Banda

Cuando toquemos una banda en pantalla, se incrementa en uno la votación a esa banda, el servidor lo recibe y emite un mensaje a todos los clientes conectados, en este caso nuestra conexión web (en la Consola)

Modificamos `home_page.dart` para emitir el evento `vote-band`.

## Socket: Agregar una nueva Banda

Vamos a agregar una nueva banda en Flutter y llamar al servidor de sockets para que lo agregue en BD y comunique a todos los clientes la nueva banda.

Modificamos `home-page.dart` para emitir el evento `add-band`.

## Socket: Borrar Banda

Vamos a eliminar una banda cuando movamos el nombre de la banda a la derecha.

Al eliminar desde Flutter, mandaremos el id al backend para que elimine la banda. A su vez, notificará a todos los clientes que se eliminó dicha banda.

Modificamos `home_page.dart` para emitir el evento `delete-band`.

## Pequeñas optimizaciones

Vamos a hacer que el código sea más fácil de leer y, que en el futuro se puedan añadir más listener sin que el código crezca de manera descomunal.

Modificamos `home_page.dart`.

## Gráfica en tiempo real

Vamos a colocar una gráfica que se actualizará en tiempo real en base a las votaciones que cualquier persona conectada a mi app va a poder hacer.

Instalaremos el paquete de gráficas `pie_chart`. Documentación `https://pub.dev/packages/pie_char`.

Vamos a añadir la gráfica en `home_page.dart`.