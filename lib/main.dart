import 'package:flutter/material.dart';
import './myCart.dart';

void main() {
  runApp(MyApp());
}

class FoodItem {
  final String name;
  final List<String> ingredients;

  FoodItem({required this.name, required this.ingredients});
}

class MyApp extends StatelessWidget {
  final List<FoodItem> foodItems = [
    FoodItem(name: 'Aallo Paratha', ingredients: ['Potato', 'Flour', 'Spices']),
    FoodItem(name: 'Pizza', ingredients: ['Cheese', 'Tomato', 'Dough']),
    FoodItem(
        name: 'Burger',
        ingredients: ['aloo Patty', 'Lettuce', 'Tomato', 'Bun']),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swiggy Ingredient Selection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IngredientSelectionPage(foodItems: foodItems),
    );
  }
}

class IngredientSelectionPage extends StatefulWidget {
  final List<FoodItem> foodItems;

  IngredientSelectionPage({required this.foodItems});

  @override
  _IngredientSelectionPageState createState() =>
      _IngredientSelectionPageState();
}

class _IngredientSelectionPageState extends State<IngredientSelectionPage> {
  List<List<String>> selectedIngredients = [];
  String Name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swiggy Ingredient Selection'),
      ),
      body: ListView.builder(
        itemCount: widget.foodItems.length,
        itemBuilder: (context, index) {
          final foodItem = widget.foodItems[index];
          return ListTile(
            title: Text(foodItem.name),
            onTap: () {
              _showIngredientSelectionDialog(foodItem);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Place order with selected ingredients
          // For demonstration, just print selected ingredients
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyCart(
                foodItem: selectedIngredients,
                foodName: Name,
              ),
            ),
          );
          print('Selected Ingredients: $selectedIngredients');

          print(Name);
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }

  void _showIngredientSelectionDialog(FoodItem foodItem) {
    List<String> currentSelectedIngredients = [];
    String selectedName = "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool isSelected = false;
        return AlertDialog(
          title: Text('Select Ingredients'),
          content: SingleChildScrollView(
            child: ListBody(
              children: foodItem.ingredients.map((ingredient) {
                return CheckboxListTile(
                  title: Text(ingredient),
                  selected: isSelected,
                  value: isSelected,
                  onChanged: (bool? val) {
                    setState(() {
                      if (val != null && val) {
                        isSelected != isSelected;
                        selectedName = foodItem.name;
                        currentSelectedIngredients.add(ingredient);
                      } else {
                        currentSelectedIngredients.remove(ingredient);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Done'),
              onPressed: () {
                setState(() {
                  selectedIngredients.add(currentSelectedIngredients);
                  Name = selectedName;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
