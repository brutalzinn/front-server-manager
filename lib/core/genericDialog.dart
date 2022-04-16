import 'package:flutter/material.dart';

// usando recursos aprendidos durante a aula da academia do flutter pra criar diálogos
//de forma reutilizável.
enum MODE {
  edit,
  insert,
  simple,
  noConfirmButtons
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
    BaseAlertDialog.SimpleActions({required String title, required String content, required Function yesOnPressed, required Function noOnPressed}){
   _title = title;
   _content = content;
   _yesOnPressed = yesOnPressed;
   _noOnPressed = noOnPressed;
   _mode = MODE.noConfirmButtons;
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

Widget customContent(){
   switch(_mode){
     case MODE.edit:
     case MODE.insert:
      _onShow();
     return Column(
      children: <Widget>[..._inputs]
      );
      case MODE.noConfirmButtons:
      case MODE.simple:
      return Text(_content);
   }
}
 Widget customButtons(BuildContext context){
   switch(_mode){
     case MODE.edit:
      return Row(      
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
         TextButton(
          child: const Text("Deletar"),
          onPressed: () {
            _noOnPressed();
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text("Cancelar"),
          onPressed: () {
            _noOnPressed();
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text("Editar"),
          onPressed: () {
            _yesOnPressed();
            Navigator.pop(context);
          },
        ),
      ],
      );
     case MODE.insert:
     return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        TextButton(
          child: const Text("Cancelar"),
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

      case MODE.noConfirmButtons:
         return  TextButton(
          child: const Text("OK"),
          onPressed: () {
            _yesOnPressed();
            Navigator.pop(context);
          },
        );
      case MODE.simple:
      return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
           TextButton(
          child: const Text("Cancelar"),
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
        )    
        ]);
        
   }
}

@override
Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_title),
      content: customContent(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      actions: <Widget>[
        customButtons(context)
      ],
    );
  }
}