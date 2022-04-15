import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/process.dart';
import 'package:flutter_application_1/models/stats.dart';

class DisplayProcess extends StatelessWidget {
  final List<ProcessModel> data;
  DisplayProcess(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // const TextStyle kStyle = TextStyle(
    // color: Color.fromARGB(255, 0, 0, 0),
    // fontWeight: FontWeight.w900,
    // );
    return Expanded(child: ListView.builder(
    //  shrinkWrap: true,
     // physics: ScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
      if(index < data.length){
      return ListTile(
          title: Text("${data[index].name} - Pid: ${data[index].pid} - Ram: ${data[index].memory}"),
      ); 
      }
      else if (index == data.length) {
        return const Center(child: Text('Fim da lista'));
      }
      else
      {
        return Center(child: CircularProgressIndicator());
      }
     },
    itemCount: data.length + 1,


    ),
  
    );
  }
}