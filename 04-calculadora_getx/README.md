# 04-calculadora_getx

Es una calculadora hecha en GetX.

Solo usaremos GetX como gestor de estados, y partimos de un diseño ya hecho.

## Controlador

Definimos nuestro controlador que nos va a ayudar a mantener el valor del primer número, la operación matemática, el segundo número y el resultado matemático.

Dentro de la carpeta `lib` creamos la carpeta `controllers` y dentro el archivo `calculator_controller.dart`.

## Utilización del controlador para mostrar la información

Modificamos `screens/calculator_screen.dart` para usar nuestra controlador para ver la información. Para que todo se vea más fácil se va a separar en Widgets.

En la carpeta `widgets` creamos el archivo `math_results.dart` y nos llevamos ciertos Widgets de `calculator_screen.dart`. Estos son los que se tienen que redibujar cuando cambia el estado.

Tenemos que definir el punto en el cual vamos a inyectar `calculator_controller.dart` para que GetX sepa de su existencia. Lo vamos a inyectar en `calculator_screen.dart`.

## Botón AC

Al pulsar este botón, el primer número será 0, la operación será +, el segundo número será 0 y el resultado será 0.

Creamos un método `resetAll()` dentro de `calculator_controller.dart`.

Modificamos `calculator_screen.dart` para ejecutar este método cuando se pulse el botón `AC`.

## Números

Aquí hay que tener en cuenta que, si hay un 0, hay que sustituirlo por el número o, en caso contrario, concatenarlo.

También hay que tener en cuenta los números negativos y los decimales cuya parte entera es 0.

Creamos un método `addNumber()` dentro de `calculator_controller.dart`.

Ahora, en cada uno de los botones de números de `calculator_screen.dart`, tenemos que llamar al método `addNumber()`.

## Símbolo +/-

Si hay un símbolo negativo y se pulsa este botón, se elimina y, si no lo hay, lo pongo.

Creamos un método `changeNegativePositive()` dentro de `calculator_controller.dart`.

Ahora, en el símbolo +/- de `calculator_screen.dart`, tenemos que llamar al método `changeNegativePositive()`.

## Símbolo .

Sólo debemos permitir un punto decimal y, si el número empieza en 0, tengo que permitir 0. y si no empieza por 0, concatena el valor con el .

Creamos un método `addDecimalPoint()` dentro de `calculator_controller.dart`.

Ahora, en el símbolo . de `calculator_screen.dart`, tenemos que llamar al método `addDecimalPoint()`.

## Corrección de muchos números en pantalla

Modificamos `main_result.dart` para dejar bien la pantalla cuando se informan muchos números, usando `FittedBox`.

## Operaciones matemáticas

Cuando toquemos unos de los botones siguientes: /, X, -, +

Vamos a tomar lo que escribió el usuario, pasarlo a la parte de arriba y poner el símbolo de la operación pulsada. El número que informa el usuario pasa a valer 0.

Creamos un método `selectOperation()` dentro de `calculator_controller.dart`.

Ahora, al pulsar cada una de las operaciones matemáticas de `calculator_screen.dart`, tenemos que llamar al método `selectOperation()`.

## Símbolo del

Al pulsar el botón del borraremos el último dígito que tenemos informado. Si solo tenemos un dígito informado, que aparezca un 0. Si tenemos un valor negativo y un solo dígito informado, también debe aparecer 0, sin el signo negativo.

Creamos un método `deleteLastEntry()` dentro de `calculator_controller.dart`.

Ahora, al pulsar el botón del de `calculator_screen.dart`, tenemos que llamar al método `deleteLastEntry()`.

## Símbolo =

Cuando toquemos este botón, haremos el cálculo matemático entre el primer valor y el que escribimos en pantalla. El resultado se ve en el segundo valor.

Creamos un método `calculateResult()` dentro de `calculator_controller.dart`.

Ahora, al pulsar el botón = de `calculator_screen.dart`, tenemos que llamar al método `calculateResult()`.

## Cosas que faltan

Control de división entre 0...