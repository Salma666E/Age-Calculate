    import 'package:flutter/material.dart';

Widget emptyBox = const SizedBox(height: 20);

  Widget buildHeading(String headingTitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        headingTitle,
        style: const TextStyle(fontSize: 20, color: Colors.grey),
      ),
    );
  }

   Widget buildButton(context, handler, txt) {
    return ButtonTheme(
      minWidth: 160,
      height: 60,
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        onPressed: handler,
        child:
            Text(txt, style: const TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }

  Widget buildOutputField(context, String outputTitle, String outputData) {
    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).primaryColor,
          width: 115,
          height: 30,
          child: Center(
              child: Text(
            outputTitle,
            style: const TextStyle(color: Colors.white),
          )),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor)),
          width: 115,
          height: 30,
          child: Center(
              child: Text(
            outputData,
            style: const TextStyle(color: Colors.grey),
          )),
        )
      ],
    );
  }
  