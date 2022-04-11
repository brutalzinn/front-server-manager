import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/server.dart';

class Config {
  FlutterSecureStorage? storage;

 Config(){
  storage = FlutterSecureStorage();
  }
   
  

  Future<void> saveServers(List<Server> list) async {
    // var json = list.map((item) {
    //   return item.toJson();
    // }).toList();
    var json = jsonEncode(list);
    print(json);
    await storage?.write(key: "servidores", value: json);
  }

 Future<List<Server>> getServers() async {
  
    var json = await storage?.read(key: "servidores");
    print(json);
    if(json == null) return [];
    var list = jsonDecode(json) as List;
    return list.map((i)=>Server.fromJson(i)).toList();

  }
}