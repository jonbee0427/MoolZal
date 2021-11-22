import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String name = FirebaseAuth.instance.currentUser!.displayName.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:50.0, left: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Welcome!',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(name, style: TextStyle(fontSize: 20),),
              SizedBox(height: 50,),
              Text(
                'Category',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        SizedBox.fromSize(
                          size: Size(60, 60), // button width and height
                          child: ClipOval(
                            child: Material(
                              color: Colors.lightBlue, // button color
                              child: InkWell(// splash color
                                onTap: () {
                                  print("영어 button");
                                }, // button pressed
                                child: Center(
                                  child:
                                    Icon(Icons.language), // icon// text
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("영어"),
                      ],
                    ),
                    SizedBox(width: 25,),
                    Column(
                      children: [
                        SizedBox.fromSize(
                          size: Size(60, 60), // button width and height
                          child: ClipOval(
                            child: Material(
                              color: Colors.lightBlue, // button color
                              child: InkWell(// splash color
                                onTap: () {
                                  print("영어 button");
                                }, // button pressed
                                child: Center(
                                  child:
                                  Icon(Icons.language), // icon// text
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("영어"),
                      ],
                    ),
                    SizedBox(width: 25,),
                    Column(
                      children: [
                        SizedBox.fromSize(
                          size: Size(60, 60), // button width and height
                          child: ClipOval(
                            child: Material(
                              color: Colors.lightBlue, // button color
                              child: InkWell(// splash color
                                onTap: () {
                                  print("영어 button");
                                }, // button pressed
                                child: Center(
                                  child:
                                  Icon(Icons.language), // icon// text
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("영어"),
                      ],
                    ),
                    SizedBox(width: 25,),
                    Column(
                      children: [
                        SizedBox.fromSize(
                          size: Size(60, 60), // button width and height
                          child: ClipOval(
                            child: Material(
                              color: Colors.lightBlue, // button color
                              child: InkWell(// splash color
                                onTap: () {
                                  print("영어 button");
                                }, // button pressed
                                child: Center(
                                  child:
                                  Icon(Icons.language), // icon// text
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("영어"),
                      ],
                    ),
                    SizedBox(width: 25,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
