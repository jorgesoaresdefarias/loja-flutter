import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loja/models/cart_model.dart';
import 'package:loja/models/user_model.dart';
import 'package:loja/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyC2Ftyh8IgJ3Fl-ACz_0oaEvIZbvVjoFSo",
          appId: "1:303059357717:android:89240a00a3c88bc48cfe1c",
          messagingSenderId: "303059357717",
          projectId: "loja-66fb7"));
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
        child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            return ScopedModel<CartModel>(
                model: CartModel(model),
                child: MaterialApp(
                    title: "Flutter's Clothing",
                    theme: ThemeData(
                        primarySwatch: Colors.blue,
                        primaryColor: Color.fromARGB(255, 4, 125, 141)),
                    debugShowCheckedModeBanner: false,
                    home: HomeScreen()));
          },
        ));
  }
}
