import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageTile extends StatelessWidget {
  final String message;
  final String sender;
  final String time;
  final String photo;
  final bool sentByMe;

  MessageTile(
      {required this.message,
      required this.sender,
      required this.time,
      required this.photo,
      required this.sentByMe});

  Widget _buildContent() {
    return Text(message,
        textAlign: TextAlign.start,
        style: TextStyle(
            fontSize: 15.0, color: sentByMe ? Colors.white : Colors.black));
  }

  @override
  Widget build(BuildContext context) {
    DateTime sentTime = DateTime.parse(time);
    DateTime currentTime = DateTime.now();

    final date1 = DateFormat('yyyy-MM-dd').format(currentTime);
    final date2 = DateFormat('yyyy-MM-dd').format(sentTime);

    final form = new DateFormat().add_yMd().add_jm();

    return Column(
      children: [
        // date1 == date2 ? Text(date2) : Text(date1),
        Container(
          padding: EdgeInsets.only(
              top: 10,
              bottom: 5,
              left: sentByMe ? 0 : 10,
              right: sentByMe ? 10 : 0),
          child: sentByMe
              ?
              //내가 보낸 msg - 오른쪽 정렬 & Customization
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    //채팅 시간 출력 text
                    Text(
                      form.format(sentTime),
                      style: TextStyle(fontSize: 13),
                    ),
                    //채팅 말풍선
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.50),
                      margin: EdgeInsets.only(left: 5),
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(23),
                            topRight: Radius.circular(23),
                            bottomLeft: Radius.circular(23),
                          ),
                          color: Colors.deepPurple,
                          border:
                              Border.all(color: Color.fromARGB(10, 0, 0, 0))),
                      //메세지 내용 출력
                      child: Column(
                        children: <Widget>[
                          _buildContent(),
                        ],
                      ),
                    ),
                  ],
                )
              :
              //다른 사람이 보낸 msg - 왼쪽 정렬 & Customization
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //유저 프로필 사진
                    CircleAvatar(
                      backgroundImage: NetworkImage(photo),
                      radius: 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        //User Name
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(sender,
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                        ),
                        //채팅 말풍선
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.40),
                              margin:
                                  EdgeInsets.only(top: 5, left: 5, right: 5),
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(23),
                                      bottomLeft: Radius.circular(23),
                                      bottomRight: Radius.circular(23)),
                                  color: Color.fromARGB(20, 0, 0, 0),
                                  border: Border.all(
                                      color: Color.fromARGB(10, 0, 0, 0))),
                              //메세지 내용 출력
                              child: Column(
                                children: <Widget>[
                                  _buildContent(),
                                ],
                              ),
                            ),
                            //채팅 시간 출력 text
                            Text(
                              form.format(sentTime),
                              style: TextStyle(fontSize: 13),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
