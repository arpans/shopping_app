import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(title: Text(product['title'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product['image']),
            const SizedBox(height: 16),
            Text("\$${product['price']}", style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            Text(product['description']),
            // Add more product details here (e.g., specifications, reviews)
          ],
        ),
      ),
    );
  }
}
