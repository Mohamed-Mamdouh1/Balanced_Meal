import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderSummaryPage extends StatefulWidget {
  final Map<String, Map<String, dynamic>> selectedIngredients;
  final double totalCalories;
  final double userCalorieLimit;

  const OrderSummaryPage({
    super.key,
    required this.selectedIngredients,
    required this.totalCalories,
    required this.userCalorieLimit,
  });

  @override
  State<OrderSummaryPage> createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  late Map<String, Map<String, dynamic>> ingredients;
  double localTotalCalories = 0;

  @override
  void initState() {
    super.initState();
    ingredients = Map.from(widget.selectedIngredients);
    localTotalCalories = calculateTotalCalories();
  }

  void increment(String name) {
    setState(() {
      ingredients[name]!['quantity']++;
      localTotalCalories = calculateTotalCalories();
    });
  }

  void decrement(String name) {
    setState(() {
      if (ingredients[name]!['quantity'] > 1) {
        ingredients[name]!['quantity']--;
        localTotalCalories = calculateTotalCalories();
      }
    });
  }

  double getTotalPrice() {
    return ingredients.entries.fold(
      0,
      (sum, e) => sum + (e.value['quantity'] ?? 1) * 12,
    );
  }

  double calculateTotalCalories() {
    double total = 0;
    for (var entry in ingredients.values) {
      final int quantity = entry['quantity'] ?? 1;
      final int calories = entry['calories'] ?? 0;
      total += quantity * calories;
    }
    return total;
  }

  Future<void> _placeOrder(BuildContext context) async {
    final items = ingredients.entries.map((entry) {
      final data = entry.value;
      final qty = data['quantity'] ?? 1;
      return {
        "name": data['food_name'],
        "total_price": qty * 12,
        "quantity": qty,
      };
    }).toList();

    final response = await http.post(
      Uri.parse('https://uz8if7.buildship.run/placeOrder'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'items': items}),
    );
    print(response.body);

    final success =
        response.statusCode == 200 && response.body.contains('true');

    if (success) {
      showSnackBar(context, 'Order placed successfully!', Colors.greenAccent,
          Icons.check_circle);

      await Future.delayed(const Duration(seconds: 2));

      Navigator.of(context).pop();
    } else {
      showSnackBar(
          context, 'Failed to place order', Colors.red, Icons.error_rounded);
    }
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
      BuildContext context,
      String message,
      Color backgroundColor,
      IconData icon,
      ) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              message,
              style: TextStyle(color: Colors.black),
            ),
            Icon(icon, color: Colors.white),
          ],
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: IconButton(
            icon: Icon(Icons.arrow_left),
            onPressed: () {
              Navigator.pop(context, ingredients);
            },
          ),
        ),
        title: const Text('Order summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: ingredients.entries.map((entry) {
                  final data = entry.value;
                  final qty = data['quantity'] ?? 1;
                  return Card(
                    color: Colors.white,

                    child: ListTile(
                      leading: Image.network(
                        data['image_url'],
                        fit: BoxFit.fitHeight,
                        width: 80,

                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.broken_image,
                            size: 80,
                            color: Colors.grey,
                          );
                        },
                      ),
                      title: Text(
                        data['food_name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        '${data['calories']} Cal',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              '\$12',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  style: IconButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.deepOrange,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(5),
                                    iconSize: 18,
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: () {
                                    decrement(entry.key);
                                  },
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '$qty',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  style: IconButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.deepOrange,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(5),
                                    iconSize: 18,
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: () {
                                    increment(entry.key);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),

            const SizedBox(height: 6),

            const SizedBox(height: 12),
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
                      '${localTotalCalories.toStringAsFixed(0)} Cal out of ${widget.userCalorieLimit.toStringAsFixed(0)} Cal',
                      style: const TextStyle(color: Colors.grey),
                    ),

                    Text(
                      ' \$${getTotalPrice().toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: localTotalCalories > widget.userCalorieLimit
                    ? () => _placeOrder(context)
                    : null,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: localTotalCalories <= widget.userCalorieLimit
                      ? Colors.grey
                      : Colors.orange,
                ),
                child: const Text('Confirm'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
