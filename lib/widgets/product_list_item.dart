import 'package:flutter/material.dart';
import 'package:shopping_app/models/product.dart';

class ProductListItem extends StatelessWidget {
  final Product product;

  const ProductListItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(product.image, width: 50, height: 50),
      title: Text(product.title),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      trailing: IconButton(
        icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
        onPressed: () {
          // Dispatch an event to toggle the favorite status
          // BlocProvider.of<ProductBloc>(context).add(ToggleFavorite(productId: product.id));
        },
      ),
      onTap: () {
        // Navigate to the product details screen
        Navigator.pushNamed(context, '/product_details', arguments: product);
      },
    );
  }
}
