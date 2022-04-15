import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/process.dart';
import 'package:flutter_application_1/models/stats.dart';

class DisplayProcess extends StatelessWidget {
  final List<ProcessModel> data;
  DisplayProcess(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const TextStyle kStyle = TextStyle(
    color: Color.fromARGB(255, 0, 0, 0),
    fontWeight: FontWeight.w900,
    );
    return  ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
      return ListTile(
        title: Text("${data[index].name} - ${data[index].pid} - ${data[index].memory}"),
      );
  }
  
    );
  }
}