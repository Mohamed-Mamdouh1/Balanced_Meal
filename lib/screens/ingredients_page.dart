import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/ingredient_card.dart';
import 'order_summary_page.dart';

class CreateOrderPage extends StatefulWidget {
  final double userCalorieLimit;

  const CreateOrderPage({required this.userCalorieLimit, super.key});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  final Map<String, Map<String, dynamic>> selectedIngredients = {};
  double totalCalories = 0;

  void _incrementIngredient(Map<String, dynamic> ingredient) {
    final name = ingredient['food_name'];
    setState(() {
      if (selectedIngredients.containsKey(name)) {
        selectedIngredients[name]!['quantity']++;
      } else {
        selectedIngredients[name] = {...ingredient, 'quantity': 1};
      }
      totalCalories += ingredient['calories'];
    });
  }

  void _decrementIngredient(Map<String, dynamic> ingredient) {
    final name = ingredient['food_name'];
    if (!selectedIngredients.containsKey(name)) return;
    setState(() {
      final currentQty = selectedIngredients[name]!['quantity'];
      if (currentQty == 1) {
        totalCalories -= ingredient['calories'];
        selectedIngredients.remove(name);
      } else {
        selectedIngredients[name]!['quantity']--;
        totalCalories -= ingredient['calories'];
      }
    });
  }

  int _getQuantity(String foodName) {
    final ingredient = selectedIngredients[foodName];
    if (ingredient != null && ingredient['quantity'] is int) {
      return ingredient['quantity'] as int;
    }
    return 0;
  }

  double getTotalPrice() {
    double price = 0;
    for (var entry in selectedIngredients.entries) {
      int qty = entry.value['quantity'] ?? 1;
      price += qty * 12;
    }
    return price;
  }

  void _goToSummaryPage() async {
    final updatedIngredients = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OrderSummaryPage(
          selectedIngredients: selectedIngredients,
          totalCalories: totalCalories,
          userCalorieLimit: widget.userCalorieLimit,
        ),
      ),
    );

    if (updatedIngredients != null) {
      setState(() {
        selectedIngredients
          ..clear()
          ..addAll(updatedIngredients);
        totalCalories = selectedIngredients.entries.fold(
          0.0,
          (sum, e) =>
              sum + (e.value['quantity'] ?? 1) * (e.value['calories'] ?? 0),
        );
      });
    }
  }

  Future<List<Map<String, dynamic>>> fetchCategory(String categoryName) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(categoryName)
        .get();

    return snapshot.docs
        .map((doc) => doc.data())
        .toList();
  }

  Widget buildCategory(String title, List<Map<String, dynamic>> ingredients) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: ingredients.length,
            itemBuilder: (context, index) {
              final item = ingredients[index];
              return IngredientCard(
                name: item['food_name'],
                imageUrl: item['image_url'],
                calories: item['calories'],
                quantity: _getQuantity(item['food_name']),
                onIncrement: () => _incrementIngredient(item),
                onDecrement: () => _decrementIngredient(item),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_left)),
          title: const Text('Create your order')),
      body: FutureBuilder(
        future: Future.wait([
          fetchCategory('Vegetables'),
          fetchCategory(' Meats'),
          fetchCategory('Carbs'),
        ]),
        builder:
            (
              context,
              AsyncSnapshot<List<List<Map<String, dynamic>>>> snapshot,
            ) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final vegetables = snapshot.data![0];
              final meats = snapshot.data![1];
              final carbs = snapshot.data![2];

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          buildCategory('Vegetables', vegetables),
                          buildCategory('Meats', meats),
                          buildCategory('Carbs', carbs),
                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Cal: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Price: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${totalCalories.toStringAsFixed(0)}"
                              " Cal out of ${widget.userCalorieLimit.toStringAsFixed(0)} Cal",

                              style: const TextStyle(color: Colors.grey),
                            ),

                            Text(
                              '${getTotalPrice().toStringAsFixed(2)} EGP',
                              style: const TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: totalCalories >= widget.userCalorieLimit
                            ? _goToSummaryPage
                            : null,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor:
                              totalCalories <= widget.userCalorieLimit
                              ? Colors.grey
                              : Colors.orange,
                        ),
                        child: const Text('Place order'),
                      ),
                    ),
                  ],
                ),
              );
            },
      ),
    );
  }
}
