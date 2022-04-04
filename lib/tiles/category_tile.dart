import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/category_screen.dart';

class CategoryTile extends StatelessWidget {
  
  final DocumentSnapshot snapshot;

  CategoryTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage((snapshot as dynamic).data()['icon']),
      ),
      title: Text((snapshot as dynamic).data()['title']),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CategoryScreen(snapshot)));
      },
    );
  }
}