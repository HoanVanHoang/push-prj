

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailNotify extends StatelessWidget {
  Map<String,dynamic>? object = {};

  DetailNotify({this.object});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(object!['title']),),
      body: Center(
        child: Text(object!['content'], style: TextStyle(fontSize: 20)),
      ),
    );
  }

}