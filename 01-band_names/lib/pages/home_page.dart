import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pie_chart/pie_chart.dart';

import 'package:band_names/models/band.dart';
import 'package:band_names/services/socket_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [];

  @override
  void initState() {
    super.initState();
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on('active-bands', _handleActiveBands);
  }

  // Parte de la optimización.
  // Hacemos initState más fácil de leer.
  _handleActiveBands(dynamic payload) {
    // Lo mapeamos para obtener los datos de cada band y actualizamos el estado.
    // para que redibuje el Widget.
    bands = (payload as List).map((band) => Band.fromMap(band)).toList();
    setState(() {});
  }

  // Esto no hace falta porque no vamos a destruir este componente.
  @override
  void dispose() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.off('active-bands');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames', style: TextStyle(color: Colors.black87)),
        elevation: 1,
        backgroundColor: Colors.white,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            // Mostramos el icono cuando tenga conexión con el servidor.
            child:
                socketService.serverStatus == ServerStatus.online
                    ? Icon(Icons.check_circle, color: Colors.blue[300])
                    : Icon(Icons.offline_bolt, color: Colors.red),
          ),
        ],
      ),
      body: Column(
        children: [
          _showGraph(),

          // La columna no indica a ListView.builder cuanto espacio tiene para mostrar la información.
          // Por eso, usamos un Expanded para que ocupe todo el espacio disponible.
          Expanded(
            child: ListView.builder(
              itemCount: bands.length,
              itemBuilder: (context, i) => _bandTile(bands[i]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        elevation: 1,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band band) {
    final socketService = Provider.of<SocketService>(context, listen: false);

    return Dismissible(
      // En el key tenemos que indicar un identificador único.
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed:
          (DismissDirection direction) =>
              socketService.emit('delete-band', {'id': band.id}),
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete Band', style: TextStyle(color: Colors.white)),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(band.name.substring(0, 2)),
        ),
        title: Text(band.name),
        trailing: Text('${band.votes}', style: TextStyle(fontSize: 20)),
        // Mandaré el id para incrementar la votación de esa banda.
        // Siempre es mejor mandar un mapa, por si el día de mañana se agrega un nuevo campo.
        onTap: () => socketService.emit('vote-band', {'id': band.id}),
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();

    // Android
    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        // Cuando veamos un builder normalmente regresaremos un Widget.
        builder:
            (_) => AlertDialog(
              title: Text('New band name:'),
              content: TextField(controller: textController),
              actions: [
                MaterialButton(
                  onPressed: () => addBandToList(textController.text),
                  elevation: 5,
                  textColor: Colors.blue,
                  child: Text('Add'),
                ),
              ],
            ),
      );
    }

    // iOS
    showCupertinoDialog(
      context: context,
      builder:
          (_) => CupertinoAlertDialog(
            title: Text('New band name:'),
            content: CupertinoTextField(controller: textController),
            actions: [
              CupertinoDialogAction(
                onPressed: () => addBandToList(textController.text),
                isDefaultAction: true,
                child: Text('Add'),
              ),

              // Por defecto, en iOS el dialog no se cierra automáticamente.
              // Creamos otro botón para cerrarlo.
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context),
                isDestructiveAction: true,
                child: Text('Dismiss'),
              ),
            ],
          ),
    );
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      // Podemos agregar
      // Emitir add-band {name: name}
      final socketService = Provider.of<SocketService>(context, listen: false);
      socketService.emit('add-band', {'name': name});
    }

    // Cerramos el diálogo.
    Navigator.pop(context);
  }

  // Mostrar la gráfica.
  Widget _showGraph() {
    Map<String, double> dataMap = {};
    for (final band in bands) {
      dataMap[band.name] = band.votes.toDouble();
    }

    final List<Color> colorList = <Color>[
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.purple,
      Colors.orange,
    ];

    return Container(
      padding: EdgeInsets.only(top: 10),
      width: double.infinity,
      height: 200,
      child:
          dataMap.isEmpty
              ? const Center(child: Text('No hay bandas para mostrar'))
              : PieChart(
                dataMap: dataMap,
                animationDuration: Duration(milliseconds: 800),
                colorList: colorList,
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: false,
                  decimalPlaces: 0,
                  chartValueBackgroundColor: Colors.grey[200],
                ),
                legendOptions: LegendOptions(showLegends: true),
                chartType: ChartType.ring,
              ),
    );
  }
}
