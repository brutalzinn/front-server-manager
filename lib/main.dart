import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/page_server.dart';
import 'package:flutter_application_1/widget/display_info.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'core/config.dart';
import 'models/server.dart';
import 'models/stats.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
 
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
   List<Server> list_server = [];//[new Server("http://192.168.0.159:8080", "local")];
  final Config config = new Config();
  final String _valueText = "";
  final TextEditingController _hostFieldController = TextEditingController();
  final TextEditingController _serverNameFieldController = TextEditingController();
   
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
        config.saveServers(list_server);
      });
      Navigator.pop(context);
      },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Inserir servidor"),
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

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

updateStorage(){
}

toJSONEncodable() {
    return list_server.map((item) {
      return item.toJson();
    }).toList();
}
List<Server> toJSONDecode(List<Server> items) {
  return List<Server>.from(
    (items as List).map(
      (item) => Server.fromJson(item)
    ),
  );
}
 @override
 void initState() {
    super.initState();
    WidgetsBinding.instance
    .addPostFrameCallback((_) async {
    list_server = await config.getServers();
    setState(() => list_server);
    });

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
        onLongPress: (){
          //adicionar um alert dialog para confirmar o delete.
          setState(() {
              list_server.removeAt(index);
              config.saveServers(list_server);
          });
        },
         onTap: () {
           Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainPageServer(server:list_server[index])));
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
