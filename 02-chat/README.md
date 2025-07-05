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