import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/server.dart';
import 'package:flutter_application_1/widget/display_info.dart';
import 'package:flutter_application_1/widget/display_process.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'core/config.dart';
import 'core/genericDialog.dart';
import 'models/process.dart';
import 'models/stats.dart';




  class MainPageServer extends StatelessWidget {
  final Server server;
  const MainPageServer({Key? key, required this.server}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: ServerPage(title: server.serverName ?? "Sem nome", server:server),
    );
  }
}

class ServerPage extends StatefulWidget {
  const ServerPage({Key? key, required this.title, required this.server}) : super(key: key);

  final String title;
  final Server server;

  @override
  State<ServerPage> createState() => _PageServerPageState();
}

class _PageServerPageState extends State<ServerPage> {
  Stats _stats = Stats();
  List<ProcessModel> listProcess = [];
  late Socket socket;
  Timer ?_debounce;
  int _debouncetime = 500;
  final TextEditingController _processFilter = TextEditingController();

 void initSocket() {
   socket = io(widget.server.host, OptionBuilder().setTransports(["websocket"])
  .setExtraHeaders({"Api-Key":widget.server.apiKey})
  .build());

  try{

  socket.connect();
  socket.onConnect((_) => socket.emit("server_stats","null"));
  socket.onDisconnect((_) => print("Desconectado"));
  socket.on('stats_monitor', (data) =>{
    if (mounted) {
      setState(() {
       _stats  = Stats.fromJson(data);
    })
    }
  });
socket.on('info', (data) =>{
_infoAlert(context, data)
});
  socket.on('process_list', (data) =>{
    if (mounted) {
      setState(() {
       listProcess = ProcessModel.toList(data);
    })
    }
  });

  }catch(e){
    socket.disconnect();
    dispose();
    // socket.connect()
  }
}
  @override
    void initState() {
    super.initState();
    initSocket();
    _processFilter.addListener(_onSearchChanged);
  } 

   _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: _debouncetime), () {
      if (_processFilter.text != "") {
        ///here you perform your search
        sendProcessName();
      }
    });
  }
  sendProcessName(){
    socket.emit("server_process_list",{"name":_processFilter.text});
  }

  //remover showdialog e tipar esse dynamic.
  _infoAlert(BuildContext context, dynamic data) {
  var baseDialog = BaseAlertDialog.SimpleActions(
    title: "Aviso",
    content: data["message"],
    yesOnPressed: () {
    },
    noOnPressed: () {
    });
  showDialog(context: context, builder: (BuildContext context) => baseDialog);
}

  @override
  Widget build(BuildContext context) {
    const TextStyle kStyle = TextStyle(
    color: Color.fromARGB(255, 0, 238, 255),
    fontWeight: FontWeight.w900,
    fontSize: 30
    );
  return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            controller: _processFilter,
            decoration: 
            InputDecoration(
              hintText: "Nome do processo",
              suffixIcon: IconButton(
              onPressed: () {
                _processFilter.clear();
                sendProcessName();
              },
              icon: Icon(Icons.clear),
            ),
            )
            ),
            DisplayInfo(_stats),
            Text("Processos", style: kStyle),
            DisplayProcess(listProcess, socket)

        ],
      ),//DisplayInfo(_stats),
      )
  );
  }
}