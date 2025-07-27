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

Creamos una rama y nos movemos a ella: `git checkout -b singleton`.

Singleton puede ser una buena opción cuando queremos hacer una petición HTTP, traer la información y mostrarla, sin querer mantener el estado y para descentralizar la lógica de negocio de la app con el UI.

Detrás de muchos manejadores de estado subyace la idea del Singleton, que es tener una única instancia de nuestra clase que maneje el estado de la aplicación y que esta información sea distribuida a los demás widgets que la necesiten.

No se va a realizar un Singleton 'real' porque haría falta un `Factory Constructor` y además no nos vamos a enfocar mucho en este patrón. Se va a hacer de una manera superficial.

Creamos una carpeta `services` dentro de `lib` y dentro de ella el archivo `usuario_service.dart`.

Modificamos `pagina1_page.dart` para que muestre información del usuario si lo tengo, o muestre un mensaje indicando que no hay información del usuario.

#### Establecer el usuario

Vamos a cambiar el valor del estado del usuario. Para ello, tendremos que llamar al método `cargarUsuario()` del servicio `UsuarioService` y asignar el valor a la variable `usuario`, todo esto desde `pagina2_page.dart`.

Hacemos lo mismo para el botón `Cambiar Edad`.

Tal y como está ahora mismo, no se va a actualizar la pantalla con la nueva información (hay que pulsar el rayo de las herramientas de ejecución de VSCode), ya que no hay un mecanismo que lo haga.

#### Re-dibujar Widgets cuando hay cambios en el servicio

Vamos a crear el mecanismo faltante para que, cuando se cambie el estado del usuario, se actualicen los widgets que lo muestran.

Este mecanismo se basa en el uso de `Stream` y `StreamController`, que nos permite emitir eventos y escuchar cambios en el estado.

Modificamos `usuario_service.dart` para que use un `StreamController<Usuario>` y emita el usuario cada vez que se cambie.

Modificamos `pagina1_page.dart` para que escuche el `Stream` del servicio. Para ello, becesitamos un `StreamBuilder` para escuchar los cambios y reconstruir el widget cuando se emita un nuevo valor.

#### Varios listeners

Vamos a modificar `pagina2_page.dart` para que también escuche el `Stream` del servicio.

De esta manera, cuando se cambie el usuario desde `pagina2_page.dart`, aparecerá el nombre del usuario en su título.

Necesitamos un `StreamBuilder` para escuchar los cambios y reconstruir el widget cuando se emita un nuevo valor.

Importante: si se quiere escuchar el mismo `Stream` en varios widgets, se debe usar un `StreamController` con `broadcast`, para que pueda emitir eventos a múltiples oyentes. Esto se hace en `usuario_service.dart`.