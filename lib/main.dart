import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/display_info.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'models/stats.dart';

void main() {
  runApp(const MyApp());
}
class StreamSocket{
  final _socketResponse= StreamController<String>();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose(){
    _socketResponse.close();
  }
}

StreamSocket streamSocket =StreamSocket();
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
  Stats _stats = new Stats();

void initSocket() {
  print('Connecting to chat service');
  
  Socket socket = io('http://192.168.0.159:8080', <String, dynamic>{'transports': ['websocket']});

  socket.connect();
  print(socket.connected);
  socket.onConnect((_) => print('Conected'));
  socket.on('data', (data) =>{
      setState(() {
       _stats  =Stats.fromJson(data);
    })
  });
  socket.onDisconnect((_) => print('disconnect'));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: DisplayInfo(_stats)
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: initSocket,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
