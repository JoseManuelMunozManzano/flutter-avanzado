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

#### Continuación de proyecto

Tenemos que instalar los siguientes paquetes 

- bloc, cuya documentación puede encontrarse en: https://pub.dev/packages/bloc
  - Es la implementación del patrón bloc.
- flutter_bloc, cuya documentación puede encontrarse en: https://pub.dev/packages/flutter_bloc
  - Es una serie de widgets especializados para que podamos redibujarlo cuando hay cambios en el estado.

`flutter_bloc` depende de `bloc`.

También, ya para VSCode, se ha instalado la extensión `bloc`, que permite crear blocs rápidamente (los 3 archivos), aunque en esta sección los haremos a mano para aprender bien como se crean.

#### Configurando el BLoC

Podemos tener muchos blocs dentro de una misma aplicación, por ejemplo, uno encargado de controla el estado de los usuarios, otro de los productos, de los artículos... y pueden relacionarse entres sí.

Dentro de la carpeta `lib` creamos la carpeta `bloc`, y dentro otra carpeta llamada `user`. En esta carpeta tendremos todo el bloc relacionado con el usuario.

Si tuviéramos otro bloc para manejar artículos, crearíamos otra carpeta dentro de `bloc` llamada `artículo`, con el objetivo de mantener todos los blocs ordenados.

Dentro de la carpeta `user` creamos 3 archivos:

- user_bloc.dart
  - Es quien tiene la información de cual es el estado actual y procesa los eventos.
- user_event.dart
  - Son acciones que podemos disparar, que va a recibir el bloc y cambiar el state.
- user_state.dart
  - Como se encuetra el estado de la aplicación (si el usuario esta logeado, cuánto vale el contador, cuántos productos tengo...)

#### Mostrar Widgets condicionalmente basados en el estado del BLoC

Ya tenemos el BLoC configurado.

Ahora tenemos que colocarlo en `main.dart` porque queremos que este disponible para todos los Widgets de toda la app.

Usaremos el widget `MultiBlocProvider` para añadir todos los blocs que queremos queden disponibles para usar en toda la app, usando `BlocProvider(create: (context) => UserBloc())` para ello.

Una vez hecho esto, en el context, a nivel global, tengo `UserBloc`.

Vamos a mostrar ahora la información de `pagina1_page.dart` de manera condicional. Si tengo usuario lo muestro y si no mostraré otro widget.

Para usar bloc, usaremos el widget `BlocBuilder` que construye un widget basado en los cambios de state.

#### Disparar eventos - Asignar un usuario al estado

Vamos a cambiar el estado cuando hacemos click en `pagina2_page.dart`, en el botón `Establecer Usuario`.

Vamos a establecer un nuevo estado en `user_state.dart` y vamos a modificar `user_bloc.dart` para que, cuando recibamos un evento de tipo `ActivateUser` emitamos este nuevo estado que hemos creado `UserSetState`.

El evento `ActivateUser` lo vamos a llamar desde `pagina2_page.dart` cuando pulsemos el botón `Establecer Usuario`.

#### Mostrar información del usuario

Ya sabemos que tenemos un usuario establecido.

Modificamos `pagina1_page.dart` para mostrar la información de dicho usuario.

#### Copiar el estado anterior

Vamos a cambiar la edad del usuario cuando hacemos click en `pagina2_page.dart`, en el botón `Cambiar Edad`.

Si no hay un usuario establecido, no podremos cambiar la edad, es decir, no podremos emitir un nuevo estado.

En `user_state.dart` podemos usar el mismo estado `UserSetState`.

En `user_event.dart` necesitamos crear un nuevo evento para saber qué hacer cuando reciba una petición de cambio de edad. Creamos la clase de evento `ChangeUserAge`.

En `user_bloc.dart` establecemos la relación entre el estado y este nuevo evento.

El evento `ChangeUserAge` lo vamos a llamar desde `pagina2_page.dart` cuando pulsemos el botón `Cambiar Edad`.

Modificamos nuestro modelo `usuario.dart` para crear un método `copyWith()` para evitar mutar el estado en `user_bloc.dart`.

#### Añadir una nueva profesión al State

Vamos a añadir profesiones al usuario cuando hagamos click en `pagina2_page.dart`, en el botón `Añadir Profesión`.

En `user_state.dart` podemos usar el mismo estado `UserSetState`.

En `user_event.dart` necesitamos crear un nuevo evento para saber qué hacer cuando reciba una petición de añadir profesión. Creamos la clase de evento `AddUserProfession`.

En `user_bloc.dart` establecemos la relación entre el estado y este nuevo evento.

El evento `AddUserProfession` lo vamos a llamar desde `pagina2_page.dart` cuando pulsemos el botón `Añadir Profesión`.

#### Borrar el usuario

Vamos a borrar el usuario y regresarlo al estado inicial.

En `user_event.dart` necesitamos crear un nuevo evento para saber qué hacer cuando reciba una petición de borrar el usuario. Creamos la clase de evento `DeleteUser`.

En `user_bloc.dart` establecemos la relación entre el estado y este nuevo evento.

En `pagina1_page.dart` creamos un nuevo botón para borrar el usuario y llamamos al evento `DeleteUser`.