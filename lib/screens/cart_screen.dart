import 'package:flutter/material.dart';
import 'package:loja/models/cart_model.dart';
import 'package:loja/models/user_model.dart';
import 'package:loja/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

import '../tiles/cart_tile.dart';
import '../widgets/cart_price.dart';
import '../widgets/dicount_card.dart';
import '../widgets/ship_card.dart';
import 'order_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int p = model.products.length;
                return Text(
                  "${p == 0 ? "0" : p} ${p == 1 ? "ITEM" : "ITENS"}",
                  style: TextStyle(fontSize: 13),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isLoading && UserModel.of(context).isLoggedIn()) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!UserModel.of(context).isLoggedIn()) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Faça o login para adicionar produtos!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16,),
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                  }, child: Text("Entrar", style: TextStyle(fontSize: 18),))
                ],
              ),
            );
          } else if (model.products == null || model.products.length ==0 ) {
            return Center(
              child: Text("Nenhum produto no carrinho!",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,),
            );
          }else {
            return ListView(
              children: <Widget> [
                Column(
                  children: model.products.map((product) {
                    return CartTile(product);
                  }).toList(),
                ),
                DiscountCard(), 
                ShipCard(),
                CartPrice(() async {
                  String orderId = await model.finishOrder();
                  if(orderId != null ){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OrderScreen(orderId)));
                  }
                })
              ],
            );
          }
        },
      ),
    );
  }
}
