
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja/datas/product_data.dart';

class CartProduct {

  String cid = "";
  String category = "";
  String pid = "";

  int quantity = 0;
  String size = "";

  late ProductData productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot document) {
    cid = document.id;
    category = (document.data() as dynamic)["category"];
    pid = (document.data() as dynamic)["pid"];
    quantity = (document.data() as dynamic)["quantity"];
    size =  (document.data() as dynamic)["size"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "pid": pid,
      "quantity": quantity,
      "size": size,
      "product": productData.toResumedMap()
    };
  }

}