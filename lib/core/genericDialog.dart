import 'package:flutter/material.dart';

// usando recursos aprendidos durante a aula da academia do flutter pra criar diálogos
//de forma reutilizável.
enum MODE {
  edit,
  insert,
  simple
}

class BaseAlertDialog extends StatelessWidget {

late String _title;
late String _content;
late Function _yesOnPressed;
late Function _noOnPressed;
late Function _onShow;
late List<Widget> _inputs;
late MODE _mode;

  BaseAlertDialog.Simple({required String title, required String content, required Function yesOnPressed, required Function noOnPressed}){
   _title = title;
   _content = content;
   _yesOnPressed = yesOnPressed;
   _noOnPressed = noOnPressed;
   _mode = MODE.simple;
  }
  BaseAlertDialog.Editor({required String title, required List<Widget> inputs,required Function onShow ,required Function yesOnPressed, required Function noOnPressed}){
   _title = title;
   _inputs = inputs;
   _yesOnPressed = yesOnPressed;
   _noOnPressed = noOnPressed;
   _mode = MODE.edit;
   _onShow = onShow;
  }
  BaseAlertDialog.Insert({required String title, required List<Widget> inputs,required Function onShow, required Function yesOnPressed, required Function noOnPressed}){
   _title = title;
   _inputs = inputs;
   _yesOnPressed = yesOnPressed;
   _noOnPressed = noOnPressed;
   _mode = MODE.insert;
   _onShow = onShow;
  }

 Widget Tipo (){
   switch(_mode){
     case MODE.edit:
     case MODE.insert:
      _onShow();
     return Column(
      children: <Widget>[..._inputs]
      );
      case MODE.simple:
      return Text(_content);
   }
   
  }
  @override
Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_title),
      content: Tipo(),
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      actions: <Widget>[
        TextButton(
          child: const Text("Não"),
          onPressed: () {
            _noOnPressed();
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text("Sim"),
          onPressed: () {
            _yesOnPressed();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}