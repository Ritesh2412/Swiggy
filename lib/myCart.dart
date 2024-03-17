import 'package:flutter/material.dart';
import 'package:flutter_application_fundsroom/main.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key, required this.foodItem, required this.foodName})
      : super(key: key);

  final List<List<String>> foodItem;
  final String foodName;

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Column(
          children: [
            Text(widget.foodName),
            Text(widget.foodItem.toList().toString()),
          ],
        ));
  }
}
