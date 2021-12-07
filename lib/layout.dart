import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import 'package:moolzal/addpost.dart';
import 'package:moolzal/home.dart';
import 'package:moolzal/myprofile.dart';

class Layout extends StatefulWidget {
  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selected = 0;
  final _pageOptions = [Home(), AddPost(), myprofile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[_selected],
      bottomNavigationBar: _selected == 0 || _selected == 1 || _selected == 2
          // selectedPage == 3 ||
          // selectedPage == 4
          ? ConvexAppBar(
        backgroundColor: Colors.deepPurple,
              items: [
                TabItem(
                  icon: Icons.home,
                  title: '홈',
                ),
                TabItem(icon: Icons.add, title: '게시글 추가'),
                TabItem(icon: Icons.person, title: '마이페이지'),
                // TabItem(icon: Icons.person, title: '프로필'),
              ],
              onTap: (int i) {
                setState(() {
                  _selected = i;
                });
              },
            )
          : null,
    );
  }
}
