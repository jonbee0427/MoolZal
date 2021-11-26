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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome!',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: IconButton(onPressed: (){print("Search Button");}, icon: Icon(Icons.search, size: 40,) ),
                  ),

                ],
              ),
              SizedBox(height: 10),
              Text(name, style: TextStyle(fontSize: 20),),
              SizedBox(height: 50,),
              Text(
                'Category',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              // Row tile 1
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
                                  Navigator.pushNamed(context, '/layout');
                                }, // button pressed
                                child: Center(
                                  child:
                                  Image.asset('lang.png', width: 40, height: 40), // icon// text
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("국제어문", style: TextStyle(fontWeight: FontWeight.bold),),
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
                                  print("경영경제 button");
                                }, // button pressed
                                child: Center(
                                  child:
                                  Image.asset('economics.png', width: 40, height: 40), // icon// text
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("경영경제", style: TextStyle(fontWeight: FontWeight.bold),),
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
                                  print("법 button");
                                }, // button pressed
                                child: Center(
                                  child:
                                  Image.asset('law.png', width: 40, height: 40), // icon// text
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("법", style: TextStyle(fontWeight: FontWeight.bold),),
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
                                  print("공연영상 button");
                                }, // button pressed
                                child: Center(
                                  child:
                                  Image.asset('film.png', width: 40, height: 40), // icon// text
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("공연영상", style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                    SizedBox(width: 25,),
                  ],
                ),
              ),
              // Row tile 2
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
                                  print("공간환경 button");
                                }, // button pressed
                                child: Center(
                                  child:
                                  Image.asset('construct.png', width: 40, height: 40), // icon// text
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("공간환경", style: TextStyle(fontWeight: FontWeight.bold),),
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
                                  print("기계제어 button");
                                }, // button pressed
                                child: Center(
                                  child:
                                  Image.asset('mechanical.png', width: 40, height: 40), // icon// text
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("기계제어", style: TextStyle(fontWeight: FontWeight.bold),),
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
                                  print("디자인 button");
                                }, // button pressed
                                child: Center(
                                  child:
                                  Image.asset('design.png', width: 40, height: 40), // icon// text
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("디자인", style: TextStyle(fontWeight: FontWeight.bold),),
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
                                  print("생명과학 button");
                                }, // button pressed
                                child: Center(
                                  child:
                                  Image.asset('biology.png', width: 40, height: 40), // icon// text
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("생명과학", style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                    SizedBox(width: 25,),
                  ],
                ),
              ),
              // Row tile 3
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
                                  print("전산전자 button");
                                }, // button pressed
                                child: Center(
                                  child:
                                  Image.asset('csee.png', width: 40, height: 40), // icon// text
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("전산전자", style: TextStyle(fontWeight: FontWeight.bold),),
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
                                  print("상담심리 button");
                                }, // button pressed
                                child: Center(
                                  child:
                                  Image.asset('counsel.png', width: 40, height: 40), // icon// text
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("상담심리", style: TextStyle(fontWeight: FontWeight.bold),),
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
                                  print("ICT창업 button");
                                }, // button pressed
                                child: Center(
                                  child:
                                  Image.asset('enterpreneur.png', width: 40, height: 40), // icon// text
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("ICT창업", style: TextStyle(fontWeight: FontWeight.bold),),
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
                                  print("기타 button");
                                }, // button pressed
                                child: Center(
                                  child:
                                  Image.asset('etc.png', width: 40, height: 40), // icon// text
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("기타", style: TextStyle(fontWeight: FontWeight.bold),),
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
