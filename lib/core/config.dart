import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/server.dart';

class Config {
  FlutterSecureStorage? storage;

 Config(){
  storage = FlutterSecureStorage();
  }

   static String apiKey = "blablabla";
  

  Future<void> saveServers(List<Server> list) async {
    var json = jsonEncode(list);
    await storage?.write(key: "servidores", value: json);
  }

 Future<List<Server>> getServers() async {
    var json = await storage?.read(key: "servidores");
    if(json == null) return [];
    var list = jsonDecode(json) as List;
    return list.map((i)=>Server.fromJson(i)).toList();

  }
}