import 'package:flutter/material.dart';

class myfavorite extends StatelessWidget {
  const myfavorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('myfavorite Page'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () {
              //Navigator.pop(context);
              // 서치로 가기?
              Navigator.pushNamed(context, '/search');
            },
          ),
        ],
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Launch screen'),
          onPressed: () {
            // 클릭하면 두 번째 화면으로 전환합니다!
          },
        ),
      ),
    );
  }
}