import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:http/http.dart' as http;
import 'package:moolzal/text_copy.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ResultPage extends StatefulWidget {
  final String path;

  ResultPage({required this.path});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String _text = '';

  Future _fileFromImageUrl(String path) async {
    final response = await http.get(Uri.parse(path));
    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = File(join(documentDirectory.path, 'imagetest.png'));

    file.writeAsBytesSync(response.bodyBytes);

    return getText(file);
  }

  Future getText(File file) async {
    showDialog(
        context: this.context,
        builder: (context) {
          return SizedBox(child: Center(child: CircularProgressIndicator()));
        });
    final inputImage = InputImage.fromFile(file);
    final textDetector = GoogleMlKit.vision.textDetector();
    final RecognisedText recognisedText =
        await textDetector.processImage(inputImage);
    String text = recognisedText.text;
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        _text += line.text + '\n';
      }
    }
    print(text);
    Navigator.pop(this.context);
    Navigator.of(this.context)
        .push(MaterialPageRoute(builder: (context) => CopyPage(text: text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Text Recognition'),
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  _fileFromImageUrl(widget.path);
                },
                icon: Icon(Icons.text_format))
          ],
        ),
        body: Center(
            child: Container(
          height: 300,
          padding: EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width * .70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            image: DecorationImage(
                fit: BoxFit.fill, image: NetworkImage(widget.path)),
          ),
        )));
  }
}
