import 'package:flutter/material.dart';

class CopyPage extends StatefulWidget {
  final String text;

  CopyPage({required this.text});

  @override
  _CopyPageState createState() => _CopyPageState();
}

class _CopyPageState extends State<CopyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Text Detail'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.copy))
          ],
        ),
        body: Center(
            child: Container(
              alignment: Alignment.center,
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              child: SelectableText(widget.text.isEmpty ? 'No Text Found' : widget.text),
            )));
  }
}
