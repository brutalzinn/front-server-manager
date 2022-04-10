import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/page_server.dart';
import 'package:flutter_application_1/widget/display_info.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'models/server.dart';
import 'models/stats.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Server Status - Teste'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


  
class _MyHomePageState extends State<MyHomePage> {
  List<Server> list_server = [new Server("http://192.168.0.159:8080", "local")];

  String _valueText = "";
  TextEditingController _hostFieldController = TextEditingController();
  TextEditingController _serverNameFieldController = TextEditingController();

  //thansk to https://stackoverflow.com/questions/53844052/how-to-make-an-alertdialog-in-flutter
showAlertDialog(BuildContext context) {

  Widget cancelarBotao = TextButton(
    child: Text("Cancelar"),
    onPressed:  () {Navigator.pop(context);},
  );
  Widget continuarBotao = TextButton(
    child: Text("Salvar"),
    onPressed:  () {
      String host = _hostFieldController.text;
      String server_name = _serverNameFieldController.text;
      Server server  = Server(host, server_name);
      setState(() {
        list_server.add(server);
      });
      Navigator.pop(context);
      },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Inserir servidor"),
    // content: TextField(
    //         controller: _hostFieldController,
    //         decoration: InputDecoration(hintText: "http://endereço:porta"),
    // ),
    content:Column(
      children: <Widget>[
      TextField(
            controller: _serverNameFieldController,
            decoration: InputDecoration(hintText: "Nome"),
    ),
        TextField(
            controller: _hostFieldController,
            decoration: InputDecoration(hintText: "http://endereço:porta"),
    )


        ],),
  
    actions: [
      cancelarBotao,
      continuarBotao,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
      child: ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: list_server.length,
      itemBuilder: (BuildContext context, int index) {
      return ListTile(
        title: Text(list_server[index].serverName.toString()),
         onTap: () {
           Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainPageServer(server:list_server[index])));
          print(list_server[index]);
      },
      );
  }
        ),
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAlertDialog(context);
         },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
