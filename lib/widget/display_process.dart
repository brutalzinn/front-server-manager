import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/process.dart';
import 'package:flutter_application_1/models/stats.dart';

import '../core/genericDialog.dart';

class DisplayProcess extends StatelessWidget {
  final List<ProcessModel> data;
  DisplayProcess(this.data, {Key? key}) : super(key: key);
 final TextEditingController _hostFieldController = TextEditingController();

_confirmRegister(BuildContext context, {int index =-1}) {
var baseDialog = BaseAlertDialog.Simple(
    title: "Gerenciamento de processo",
    content: "Deseja parar esse processo?",
  //   inputs: [
  //     TextField(
  //          controller: _hostFieldController,
  //           decoration: InputDecoration(hintText: "Processo"),
  //   ),
  // ],
    yesOnPressed: () {
      print("call back funcionou e cliquei sim");


    },
    noOnPressed: () {
      print("call back funcionou e cliquei não");

    });

showDialog(context: context, builder: (BuildContext context) => baseDialog);
}

  @override
  Widget build(BuildContext context) {
    const TextStyle kStyle = TextStyle(
    color: Color.fromARGB(255, 0, 0, 0),
    fontWeight: FontWeight.w400,
    fontSize: 20
    );
    return Expanded(child: ListView.builder(
      itemBuilder: (BuildContext context, int index) {
      if(index < data.length){
      return ListTile(
          title: Text("${data[index].name} - Pid: ${data[index].pid} - Ram: ${data[index].memory}"),
        onLongPress: (){
          _confirmRegister(context, index:index);
        },
      ); 
     }
      else if (index == data.length) {
        return  Center(child: Text("${data.length} ${data.length > 1 ? "processos" : "processo"} em andamento" ,style: kStyle));
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