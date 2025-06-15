# FLUTTER AVANZADO: LLEVA TU CONOCIMIENTO AL SIGUIENTE NIVEL

Del curso DevTalles https://cursos.devtalles.com/courses/flutter-avanzado

## 01-band_names

### BandNamesApp - Socket.io - Aplicación en tiempo real

En esta sección se hace solo la parte del diseño, que es quizás lo menos importante de la app.

Lo más importante va a ser como se realiza la comunicación en tiempo real con un backend usando sockets.

#### Temas puntuales de la sección

Aquí tocaremos temas sobre:

- Diseño de la aplicación
- inputDialog para IOS y Android
- Dismissible
- Trabajar con listas

La aplicación visualmente es básica, pero nos ayudará a preparar el terrenos para conectarla a un socket server que haremos en la sección que sigue a esta. Luego le integraremos gráficas en tiempo real y todo el proceso CRUD mediante sockets.

## 01-band_names_server

### BandNamesApp - Socket Server - Express - Backend

En esta sección creamos desde cero el backend de nuestra app usando Node. Vamos a user el paquete `socket.io` porque queremos usar `websockets` y que nuestro servidor mantenga una conexión activo-activo con los clientes conectados.

Indicar que esta app en Node no es recomendable usarla en Producción. Más adelante en el curso se realiza otro backend mucho más completo y que si será posible usar en Producción si queremos.

#### Temas puntuales de la sección

Aquí tocaremos temas sobre:

- Crear un backend en Node
- Crear directorios públicos
- Variables de entorno
- Configuración de Socket.io
- Emitir y escuchar eventos
- Separar la lógica en diferentes archivos
- Realizar respaldos en GitHub
- Procedimiento para escuchar cuando un cliente se conecta y se desconecta