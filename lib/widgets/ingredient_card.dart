import 'package:flutter/material.dart';

class IngredientCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final int calories;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const IngredientCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.calories,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: quantity > 0 ? Colors.orange : Colors.grey,width: 3),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        mainAxisAlignment:  MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(imageUrl, height: 80,width: double.infinity, fit: BoxFit.fitWidth),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: 80,child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, maxLines: 1)),
              Text('$calories Cal', style: const TextStyle(color: Colors.grey)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('12 EGP'),
              quantity == 0
                  ? ElevatedButton(
                onPressed: onIncrement,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Add',style: TextStyle(color: Colors.white)),
              )
                  : Row(
                children: [
                  IconButton(
                    onPressed: onDecrement,
                    icon: const Icon(Icons.remove_circle, color: Colors.orange),
                  ),
                  Text(quantity.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  IconButton(
                    onPressed: onIncrement,
                    icon: const Icon(Icons.add_circle, color: Colors.orange),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
