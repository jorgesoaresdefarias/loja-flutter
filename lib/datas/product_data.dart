import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {

  String? category;
  String? id;
  String? title;
  String? description;
  double? price;
  List? images;
  List? sizes;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    title = (snapshot as dynamic).data()["title"];
    description = (snapshot as dynamic).data()["description"];
    price = (snapshot as dynamic).data()["price"];
    images = (snapshot as dynamic).data()["images"];
    sizes = (snapshot as dynamic).data()["sizes"];
  }

  Map<String, dynamic> toResumedMap() {
    return {
      "title":title,
      "description": description,
      "price":price
    };
  }

}