import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String name = FirebaseAuth.instance.currentUser!.displayName.toString();

  getCurrentUser() {
    name = FirebaseAuth.instance.currentUser!.displayName.toString();
  }

  @override
  initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome!',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/search');
                          },
                          icon: Icon(
                            Icons.search,
                            size: 40,
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Category',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Row tile 1
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        SizedBox.fromSize(
                          size: Size(60, 60), // button width and height
                          child: ClipOval(
                            child: Material(
                              child: InkWell(
                                // splash color
                                onTap: () {
                                  print("???????????? button");
                                  Navigator.pushNamed(context, '/layout');
                                }, // button pressed
                                child: Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    //color: const Color(0xff7c94b6),
                                    image: DecorationImage(
                                      image: AssetImage('csee.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                    border: Border.all(
                                      color: Colors.deepPurple,
                                      width: 4.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "????????????",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox.fromSize(
                          size: Size(60, 60), // button width and height
                          child: ClipOval(
                            child: Material(
                              child: InkWell(
                                // splash color
                                onTap: () {
                                  print("???????????? button");
                                }, // button pressed
                                child: Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    //color: const Color(0xff7c94b6),
                                    image: DecorationImage(
                                      image: AssetImage('economics.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                    border: Border.all(
                                      color: Colors.deepPurple,
                                      width: 4.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "????????????",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox.fromSize(
                          size: Size(60, 60), // button width and height
                          child: ClipOval(
                            child: Material(
                              child: InkWell(
                                // splash color
                                onTap: () {
                                  print("??? button");
                                }, // button pressed
                                child: Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    //color: const Color(0xff7c94b6),
                                    image: DecorationImage(
                                      image: AssetImage('law.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                    border: Border.all(
                                      color: Colors.deepPurple,
                                      width: 4.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "???",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox.fromSize(
                          size: Size(60, 60), // button width and height
                          child: ClipOval(
                            child: Material(
                              child: InkWell(
                                // splash color
                                onTap: () {
                                  print("???????????? button");
                                }, // button pressed
                                child: Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    //color: const Color(0xff7c94b6),
                                    image: DecorationImage(
                                      image: AssetImage('film.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                    border: Border.all(
                                      color: Colors.deepPurple,
                                      width: 4.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "????????????",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                // Row tile 2
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        SizedBox.fromSize(
                          size: Size(60, 60), // button width and height
                          child: ClipOval(
                            child: Material(
                              child: InkWell(
                                // splash color
                                onTap: () {
                                  print("???????????? button");
                                }, // button pressed
                                child: Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    //color: const Color(0xff7c94b6),
                                    image: DecorationImage(
                                      image: AssetImage('construct.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                    border: Border.all(
                                      color: Colors.deepPurple,
                                      width: 4.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "????????????",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox.fromSize(
                          size: Size(60, 60), // button width and height
                          child: ClipOval(
                            child: Material(
                              child: InkWell(
                                // splash color
                                onTap: () {
                                  print("???????????? button");
                                }, // button pressed
                                child: Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    //color: const Color(0xff7c94b6),
                                    image: DecorationImage(
                                      image: AssetImage('mechanical.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                    border: Border.all(
                                      color: Colors.deepPurple,
                                      width: 4.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "????????????",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox.fromSize(
                          size: Size(60, 60), // button width and height
                          child: ClipOval(
                            child: Material(
                              child: InkWell(
                                // splash color
                                onTap: () {
                                  print("????????? button");
                                }, // button pressed
                                child: Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    //color: const Color(0xff7c94b6),
                                    image: DecorationImage(
                                      image: AssetImage('design.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                    border: Border.all(
                                      color: Colors.deepPurple,
                                      width: 4.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "?????????",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox.fromSize(
                          size: Size(60, 60), // button width and height
                          child: ClipOval(
                            child: Material(
                              child: InkWell(
                                // splash color
                                onTap: () {
                                  print("???????????? button");
                                }, // button pressed
                                child: Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    //color: const Color(0xff7c94b6),
                                    image: DecorationImage(
                                      image: AssetImage('biology.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                    border: Border.all(
                                      color: Colors.deepPurple,
                                      width: 4.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "????????????",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                // Row tile 3
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        SizedBox.fromSize(
                          size: Size(60, 60), // button width and height
                          child: ClipOval(
                            child: Material(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/layout');
                                }, // button pressed
                                child: Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    //color: const Color(0xff7c94b6),
                                    image: DecorationImage(
                                      image: AssetImage('lang.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                    border: Border.all(
                                      color: Colors.deepPurple,
                                      width: 4.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "????????????",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox.fromSize(
                          size: Size(60, 60), // button width and height
                          child: ClipOval(
                            child: Material(
                              child: InkWell(
                                // splash color
                                onTap: () {
                                  print("???????????? button");
                                }, // button pressed
                                child: Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    //color: const Color(0xff7c94b6),
                                    image: DecorationImage(
                                      image: AssetImage('counsel.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                    border: Border.all(
                                      color: Colors.deepPurple,
                                      width: 4.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "????????????",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox.fromSize(
                          size: Size(60, 60), // button width and height
                          child: ClipOval(
                            child: Material(
                              child: InkWell(
                                // splash color
                                onTap: () {
                                  print("ICT?????? button");
                                }, // button pressed
                                child: Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    //color: const Color(0xff7c94b6),
                                    image: DecorationImage(
                                      image: AssetImage('enterpreneur.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                    border: Border.all(
                                      color: Colors.deepPurple,
                                      width: 4.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "ICT??????",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox.fromSize(
                          size: Size(60, 60), // button width and height
                          child: ClipOval(
                            child: Material(
                              child: InkWell(
                                // splash color
                                onTap: () {
                                  print("?????? button");
                                }, // button pressed
                                child: Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    //color: const Color(0xff7c94b6),
                                    image: DecorationImage(
                                      image: AssetImage('etc.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                    border: Border.all(
                                      color: Colors.deepPurple,
                                      width: 4.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "??????",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                // Row tile 1
                SizedBox(height: 50),
                Container(
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 2.0, color: Colors.deepPurple),
                      ),
                      child: Text(
                        '????????? ??????',
                        style: TextStyle(fontSize: 17, color: Colors.black),
                      ),
                      onPressed: () async {
                        Navigator.pushNamed(context, '/chart');
                      }),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
