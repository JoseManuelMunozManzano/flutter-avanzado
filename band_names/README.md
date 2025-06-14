# band_names

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