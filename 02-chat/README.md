# 02-chat

## Creación del proyecto

Creamos el proyecto band_names usando VSCode.

En la raiz, creamos la carpeta `assets` y dentro colocamos la imagen `tag_logo.png`.

Para poder usar todos los assets, abrimos `pubspec.yaml` y añadimos:

```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/
```

Abrimos `lib/main.dart`, borramos todo y escribimos `mateapp` para que nos genere el código base.

Dentro de la carpeta `lib`, creamos la carpeta `routes` y dentro creamos el archivo `routes.dart`.

Nos definimos las pantallas que vamos a usar en la aplicación. Para ello, en la carpeta `lib`, creamos la carpeta `pages` y dentro:

- `usuarios_page.dart`: Pantalla de usuarios.
- `chat_page.dart`: Pantalla de chat.
- `login_page.dart`: Pantalla de login.
- `register_page.dart`: Pantalla de registro.
- `loading_page.dart`: Me servirá como un preloader, para saber si estamos autenticados, de forma que nos mande a otra pantalla.

## Diseño del LoginPage

Modificamos el archivo `login_page.dart` para que tenga un diseño sencillo. Usamos un `Scaffold` con un `AppBar` y un `Center` que contiene un `Column` con los campos de texto y botones necesarios.

## CustomInputField

Vamos a crear el input del Login como un Widget independiente que nos pemita reutilizarlo en otras pantallas. Creamos un archivo `custom_input.dart` dentro de la nueva carpeta `widgets`.

## Argumentos a nuestro CustomInput

Refactorizamos nuestro `CustomInput` para que reciba argumentos.

También creamos en la carpeta `widgets` los archivos `logo.dart` y `labels.dart` que contienen la parte del logo y las etiquetas de la pantalla de login.

## Botón azul

Vamos a trabajar con el botón de `login_page.dart`.

Nos lo llevamos a un widget independiente llamado `boton_azul.dart` dentro de la carpeta `widgets`.

## SingleChildScrollView

Añadimos este Widget para que la pantalla sea scrollable y no se corte el contenido en pantallas pequeñas. Modificamos `login_page.dart` para envolver el `Column` en un `SingleChildScrollView`.

## Registro y Navegar entre pantallas

Creamos la pantalla de registro en `register_page.dart` y la conectamos con la pantalla de login.

Desde la pantalla de login, al tocar el botón `Crea una ahora!`, vamos a navegar a la pantalla de registro.

## Página de Usuarios

Vamos a enfocarnos en `usuarios_page.dart`.

También creamos una carpeta `models` dentro de `lib` para definir el modelo de usuario. Creamos el archivo `usuario.dart` con la clase `Usuario`.

## Pull to Refresh

No queremos que los usuarios se estén mostrando por sockets. Vamos a hacer un llamado a un endpoint que nos devuelva los usuarios registrados, y así consumir menos recursos.

A su vez, ese pull to refresh nos va a actualizar o traer el estado activo.

Lo que sí vamos a hacer por sockets es el chat. El objetivo es ver las distintas formas de hacer las cosas.

Para hacer más fácil integrar el pull to refresh, vamos a instalar el paquete `pull_to_refresh`: `https://pub.dev/packages/pull_to_refresh`

## ChatPage

Vamos a crear la pantalla de chat en `chat_page.dart`.

## Mensajes de burbujas

Nos creamos en la carpeta `widgets` un widget llamado `chat_message.dart` que nos va a permitir mostrar los mensajes de forma más bonita.

Seguimos también modificando `chat_page.dart` para que use este widget.

## Backend y Frontend - Autenticación

Levantar el backend `02-chat_server` accediendo a su carpeta con el comando `npm run start:dev` y este frontend de Flutter.

Vamos a ocupar bastantes servicios en nuestra app. Necesitamos hacer peticiones HTTP, un servicio para manejar los sockets...

Como manejador de estado de esta app vamos a usar `provider`. Ver documentación en `https://pub.dev/packages/provider`. Lo instalamos usando `pubscpec assist`.

En la carpeta `lib` creamos la carpeta `services` y dentro el archivo `auth_service.dart` que va a ser una clase.

## Petición HTTP.POST al login

Desde `auth_service.dart`, vamos a llamar al endpoint de login del backend.

Vamos a usar el paquete `http` para hacer las peticiones. Lo instalamos con `pubspec assist`. La documentación está en: `https://pub.dev/packages/http`.

En `main.dart`, vamos a envolver nuestra app con el `MultiProvider` de `provider` para que podamos usar el `AuthService` en toda la app.

Vamos a tener que crearnos unas variables de entorno porque el localhost en Android no funciona, y tampoco funcionará cuando se ponga en producción. En iOs si se puede usar localhost, pero es mejor usar una IP fija.

Para ello, dentro de `lib` creamos la carpeta `global` y dentro el archivo `environment.dart`.

Por último, para probar que esto funciona, desde nuestra pantalla de login `login_page.dart`, vamos a llamar al método `login` del `AuthService` al pulsar el botón de login.

## Mapear respuesta de un login

Vamos a mapear la respuesta del login a un tipo de modelo propio de nuestra aplicación.

Si no lo hacemos, tenemos que trabajar con mapas de Dart, que es un poco incómodo. Son de este tipo: `resp.body['usuario']`.

Para hacerlo, usaremos la web `https://quicktype.io/` que nos permite generar el modelo a partir de un JSON.

Partimos de la respuesta de un login exitoso, que podemos ver en Postman y generamos las clases seleccionando Dart.

Copias el código generado y lo pegamos en un archivo llamado `login_response.dart` dentro de la carpeta `models`.

También en `models` modificamos el archivo `usuario.dart` para que usemos el modelo generado en `quicktype`.

Seguimos modificando `auth_service.dart` para que use el modelo de respuesta del login y también tratar las excepciones que puedan ocurrir.

## Bloquear botón mientras se realiza la autenticación

Cuando se haga la autenticación, vamos a hacer que desaparezca el teclado y bloquear el botón de Ingrese para evitar un doble posteo.

Modificamos `auth_service.dart` para saber cuando nos estamos autenticando y así poder bloquear el botón.

También modificamos `login_page.dart` para que el botón de login se bloquee mientras se está autenticando.

## Mostrar alertas si las credenciales son incorrectas

`auth_service.dart` actualmente regresa un Future<void>. Lo cambiamos para que regrese un Future<bool>, que será true si el login fue exitoso y false si no lo fue, y en ese caso mostramos una alerta.

Modificamos `login_page.dart`.

En la carpeta `lib` creamos un nuevo directorio llamado `helpers` y dentro el archivo `mostrar_alerta.dart` que contendrá una función para mostrar alertas.

## Guardar JWT en el Storage (Keychain IOS y Keystore Android)

Cuando el login es exitoso, vamos a guardar el JWT en el almacenamiento local del dispositivo. Para ello, usaremos el paquete `flutter_secure_storage`.

Lo instalamos con `pubspec assist`. Documentación: `https://pub.dev/packages/flutter_secure_storage`.

Modificamos `auth_service.dart` para guardar el token en el almacenamiento seguro del dispositivo.

Modificamos `login_page.dart` para navegar a otra pantalla si el login es exitoso.

## Pantalla de registro

Modificamos `auth_service.dart` para crear un método `register` que haga una petición HTTP.POST al endpoint de registro del backend.

Modificamos `register_page.dart` para que use este método y registre un nuevo usuario si el registro es exitoso. En caso contrario, mostramos una alerta con el error.

## Mantener la pantalla de usuarios si tenemos un token válido

Cuando ingresamos con unas credenciales válidas, se genera un token que se guarda. El problema es que si ahora pulsamos un hot restart, el token lo seguimos teniendo, pero vuelve a aparecer la pantalla de login.

La idea es mantener la pantalla de usuarios si tenemos un token válido.

Vamos a crear un método en `auth_service.dart` que verifique si el token que tenemos almacenado es válido y, si lo es, navegue directamente a la pantalla de usuarios.

Modificamos `loading_page.dart` para que al iniciar la app verifique si el usuario ya está autenticado y, en caso afirmativo, navegue directamente a la pantalla de usuarios.

## Logout de nuestra aplicación

Desde la pantalla `usuarios_page.dart`, vamos a implementar un botón de logout que nos permita cerrar sesión.

## Testing

- Login: Indicar el correo `test1@test.com` y la contraseña `123456` (esto tiene que estar creado en el backend).
- Registro: Indicar un correo `test1@test.com` no existente en BD (cambiar el 1 por otro) y la contraseña `123456`. Indicar un nombre cualquiera.