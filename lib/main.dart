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
      home: const MyHomePage(title: 'Server Manager'),
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
  List<Server> listServer = [];//[new Server("http://192.168.0.159:8080", "local")];
  
  final Config config = Config();  

//remover showAlertDialog com a classe generic dialog
showAlertDialog(BuildContext context, {int index = -1}) {
  
  final TextEditingController _hostFieldController = TextEditingController();
  final TextEditingController _serverNameFieldController = TextEditingController();
  final TextEditingController _apiKeyFieldController = TextEditingController();

   final bool isEdit = index != -1;
  if(index != -1){
    Server _server = listServer[index];
    _hostFieldController.text = _server.host ?? "";
    _serverNameFieldController.text = _server.serverName ?? "";
    _apiKeyFieldController.text = _server.apiKey ?? "";
  }else{
    _apiKeyFieldController.clear();
    _serverNameFieldController.clear();
    _hostFieldController.clear();
  }

  Widget cancelarBotao = TextButton(
    child: Text("Cancelar"),
    onPressed:  () {Navigator.pop(context);},
  );
  Widget continuarBotao = TextButton(
    child: Text(isEdit ? "Editar" : "Salvar"),
    onPressed:  () {
      String host = _hostFieldController.text;
      String server_name = _serverNameFieldController.text;
      String api_key = _apiKeyFieldController.text;
      Server server  = Server(host, server_name, api_key);
      setState(() {
        isEdit ? listServer[index] = server : listServer.add(server);
        config.saveServers(listServer);
      });
      Navigator.pop(context);
      },
  );
  Widget deletarBotao = TextButton(
    child: Text("Deletar"),
    onPressed: isEdit ?  () {
      setState(() {
        listServer.removeAt(index);
        config.saveServers(listServer);
      });
      Navigator.pop(context);
      } : null,
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
    ),
       TextField(
            controller: _apiKeyFieldController,
            decoration: InputDecoration(hintText: "Api-Key"),
    )
  ],
  ),
    actions: [
      deletarBotao,
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

 @override
 void initState() {
    super.initState();
    WidgetsBinding.instance
    .addPostFrameCallback((_) async {
    listServer = await config.getServers();
    setState(() => listServer);
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
      itemCount: listServer.length,
      itemBuilder: (BuildContext context, int index) {
      return ListTile(
        title: Text(listServer[index].serverName.toString()),
        onLongPress: (){
          showAlertDialog(context, index: index);
        },
         onTap: () {
           Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainPageServer(server:listServer[index])));
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
