import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  PlaceTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 100,
            child: Image.network(
              (snapshot.data() as dynamic)["image"],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                Text(
                  (snapshot.data() as dynamic)["title"],
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                  ),
                ),
                Text(
                  (snapshot.data() as dynamic)["address"],
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[ 
              TextButton(onPressed: () {
                launch("https://www.google.com/maps/search/?api=1&query=${(snapshot.data() as dynamic)["lat"]},"
                      "${(snapshot.data() as dynamic)["long"]}");
              }, child: Text("Ver no Mapa")),
              TextButton(onPressed: (){
                launch("tel:${(snapshot.data() as dynamic)["phone"]}");
              }, child: Text("Ligar"))
            ],
          )
        ],
      ),
    );
  }
}
