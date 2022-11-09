

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'detail_notify.dart';

class NotificationList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NotificationListState();
  }

}

class NotificationListState extends State<NotificationList> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('notifications').snapshots();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: SpinKitCircle(color: Colors.blueAccent,size: 20,));
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailNotify(object: data)));
              },
              child: ListTile(
                leading: Icon(Icons.message),
                title: Text(data['title']),
                subtitle: Text(data['content']),
              ),
            );
          }).toList(),
        );
      },
    );
  }

}