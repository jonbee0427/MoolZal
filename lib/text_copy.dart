import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  widget.text.isEmpty ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("저장할 텍스트가 없습니다!"))) :
                  Clipboard.setData(new ClipboardData(text: widget.text)).then((_){
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content:Text("텍스트 저장!")));
                  });
                },
                icon: Icon(Icons.copy))
          ],
        ),
        body: Center(
            child: Container(
              alignment: Alignment.center,
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              child: widget.text.isEmpty ? Text('NO TEXT FOUND', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)) : SelectableText(widget.text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
            )));
  }
}
