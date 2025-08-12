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

### Cubit

Un Cubit es una clase que podemos consumir de la misma forma que se consume un BLoC.

Al igual que Provider, lo podemos colocar en cualquier árbol de Widgets y todo sus hijos podrán acceder a esa instancia del Cubit.

Lo tenemos en su propia rama `cubit`.

### BLoC

Si se ha aprendido Cubit, más o menos ya hemos aprendido BLoC.

Usualmente, el BLoC tiene 3 archivos:

- El BLoC como tal en el que hay métodos y propiedades globales.
- El estado como se encuentra BLoC en ese momento.
- Eventos. Modificaremos el estado únicamente disparando eventos.

Lo tenemos en su propia rama `bloc`.

### GetX

GetX es más que un gestor de estados, sería más bien un mini framework que sirve también para cambiar de tema, inyectar dependencias...

Documentación: `https://pub.dev/packages/get`

Lo tenemos en su propia rama `getx`.

#### Continuación de proyecto

Instalamos el paquete `get`.

Vamos a modificar `usuario.dart` para que sea null safety.

#### Navegación con GetX

Una de las cosas que más llama la atención de GetX es el poco uso del context que vamos a necesitar.

Otra de las cosas más importates de GetX es que nos sirve para inyectar dependencias.

Pero vamos a empezar con la navegación para cubrir algunas generalidades muy útiles de GetX.

Modificamos `main.dart` para cambiar `MaterialApp` por `GetMaterialApp` y la forma de usar las routes. Veremos que la navegación funciona exactamente igual que antes.

Modificamos `pagina1_page.dart` donde cambiamos la forma de hacer la navegación a otro lugar, de `Navigator.pushNamed(context, 'pagina2')` a `Get.to(() => Pagina2Page())` para una navegación sencilla, o `Get.toNamed('pagina2', arguments: {'nombre': 'José Manuel', 'edad': 46,})` donde además vemos como se mandan argumentos.

Para obtener los argumentos que está mandado la ruta, usaremos `Get.arguments`. Esto lo vemos en `pagina2_page.dart`.

#### Gestor de estado - GetxController

Vamos a trabajar con los controladores de GetX. Son sencillos de usar y nos van a servir para compartir la información y de manera dinámica renderizar los componentes que necesitemos cambiar cuando algo sucede en nuestro estado.

En la carpeta `lib` creamos la carpeta `controllers` y dentro un nuevo archivo `usuario_controller.dart`.

En `pagina1_page.dart` usaremos el controller, para que de manera condicional muestre un texto indicando que no hay usuario, o muestre el usuario.

En `pagina2_page.dart` vamos a llamar al método `cargarUsuario()` de `UsuarioController` cuando se pulse el botón `Establecer Usuario`.

#### Utilizar el usuario y cambiar la edad

Ya tenemos un usuario en el controller, pero ahora tenemos que poder visualizarlo en pantalla, y para ello modificamos `pagina1_page.dart`.

Para poder cambiar la edad, creamos un nuevo método `cambiarEdad()` en `usuario_controller.dart`.

Modificamos `pagina2_page.dart` para llamar a este nuevo método cuando se pulsa el botón `Cambiar Edad`.

#### Manejo de las profesiones del usuario

Vamos a realizar las modificaciones necesarias para crear profesiones cuando en `pagina2_page.dart` pulsemos el botón `Añadir Profesión`.

En `usuario_controller.dart` creamos un nuevo método `agregarProfesion()` para poder añadir las profesiones. También creamos un getter para saber cuántas profesiones tengo.

Modificamos `pagina2_page.dart` para llamar a este método.

Modificamos `pagina1_page.dart` para visualizar las profesiones.

#### Otras funcionalidades de GetX

Vamos a mostrar unas notificaciones cuando en `pagina2_page.page` pulsamos el botón `Establecer Usuario`. Esto ya nos lo da GetX muy fácilmente usando `Get.snackbar()`.

En `pagina2_page.dart` creamos otro botón para cambiar el tema de la aplicación. Es muy fácil con GetX usando `Get.changeTheme()`.

Todo esto funciona gracias a que en `main.dart` cambiamos `MaterialApp` por `GetMaterialApp`.