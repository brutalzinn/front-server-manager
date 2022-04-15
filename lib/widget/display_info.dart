import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/stats.dart';

class DisplayInfo extends StatelessWidget {
  final Stats data;
  DisplayInfo(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const TextStyle kStyle = TextStyle(
    color: Color.fromARGB(255, 0, 0, 0),
    fontWeight: FontWeight.w900,
    );
    return DefaultTextStyle(
      style: kStyle,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
             Text("Memória Total: ${data.totalMem}"),
             Text("Memória em uso: ${data.memoryUsed}"),
             Text("Cpu em uso: ${data.cpuPercent} %"),
             Text("Disco em uso: ${data.diskPercent} %")

        ],
      ),
    );
  }
}