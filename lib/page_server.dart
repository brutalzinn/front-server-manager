import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/server.dart';
import 'package:flutter_application_1/widget/display_info.dart';
import 'package:flutter_application_1/widget/display_process.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'core/config.dart';
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

 void initSocket() {
   socket = io(widget.server.host, OptionBuilder().setTransports(["websocket"])
  .setExtraHeaders({"Api-Key":widget.server.apiKey})
  .build());
  try{

  socket.connect();
  socket.onConnect((_) => print('Conected'));
  socket.onDisconnect((_) => print("Desconectado"));
  // socket.emit("server_stats");
  // if (!mounted) return;
  socket.on('stats_monitor', (data) =>{
    if (mounted) {
      setState(() {
       _stats  = Stats.fromJson(data);
    })
    }
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
  } 
  final TextEditingController _processFilter = TextEditingController();

  sendProcessName(){
    socket.emit("server_process_list",{"name":_processFilter.text});
  }
  @override
  Widget build(BuildContext context) {
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
              onPressed: () => {
                _processFilter.clear,
                sendProcessName
              },
              icon: Icon(Icons.clear),
            ),
            )
            ),
              TextButton(
              child: Text("Pesquisar"),
              onPressed: sendProcessName,
              ),
              
    
             DisplayInfo(_stats),
             DisplayProcess(listProcess)

        ],
      ),//DisplayInfo(_stats),
      )
  );
  }
}