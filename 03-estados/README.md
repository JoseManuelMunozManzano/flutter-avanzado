# ESTADOS

Una de las cosas más importantes de una app es saber el estado de la misma, como cambia la información y como actualizar los widgets en tiempo real en la UI cuando algo sucede.

## Inicio de proyecto

Creamos el proyecto usando VSCode y el plugin de Flutter. Indicamos el nombre `estados` y una vez creado le cambiamos el nombre a `03-estados`.

Entramos al proyecto, vamos al archivo `lib/main.dart`, borramos todo el contenido y escribimos lo siguiente para generar el código de inicio: `mateapp` y pulsamos `Tab`.

En la carpeta `lib` creamos la carpeta `pages` y dentro estas dos páginas: `pagina1_page.dart` y `pagina2_page.dart`.

En cada una de ellas, para crear un código inicial, escribimos lo siguiente: `stless` y pulsamos `Tab`.

Vamos a crear una forma de mostrar la información ya que el objetivo es ver diferentes formas de mantener el estado de la aplicación.

## Diseño de ambas pantallas

Va a ser un diseño sencillo, porque el objetivo no es aprender a diseñar, sino dejar preparadas las pantallas para empezar a trabajar con los estados para poder manejarlo, y poder manipular de manera simultanea las pantallas.

En `pagina2_page.dart` es donde van a estar unas opciones para cambiar valores del estado de la aplicación.

Vamos a crear un modelo que nos va a ayudar a mantener la información del usuario. Para ello, creamos una carpeta `models` dentro de `lib` y dentro de ella el archivo `usuario.dart`.

## Preparar repositorio y ramas

Trabajaremos en distintas ramas, manteniendo el diseño de las pantallas y el modelo de usuario, pero cambiando la forma de manejar el estado.

### Singleton

Singleton puede ser una buena opción cuando queremos hacer una petición HTTP, traer la información y mostrarla, sin querer mantener el estado y para descentralizar la lógica de negocio de la app con el UI.

Lo tenemos en su propia rama `singleton`.

### Provider

Provider nos ayuda a mantener un Singleton de la clase que queramos implementar, pero a la vez, dependiendo del nivel donde pongamos el MultiProvider, podemos tener diferentes instancias de la misma clase en diferentes niveles de la aplicación.

Lo tenemos en su propia rama `provider`.