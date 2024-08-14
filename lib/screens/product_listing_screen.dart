import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/bloc/favorites/favorites_bloc.dart';
import 'package:shopping_app/bloc/product/product_bloc.dart';
import 'package:shopping_app/repositories/product_repository.dart';

class ProductListingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Listing'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      // appBar: AppBar(
      //   title: const Text('Product Listing'),
      // ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProductBloc(context.read<ProductRepository>())
              ..add(FetchProducts()),
          ),
          BlocProvider(
            create: (context) => FavoritesBloc()..add(LoadFavoritesEvent()),
          ),
        ],
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              return BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, favoritesState) {
                  final favoritesBloc = context.read<FavoritesBloc>();
                  List<String> favoriteProducts = [];
                  if (favoritesState is FavoritesUpdated) {
                    favoriteProducts = favoritesState.favoriteProducts;
                  }
                  return ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      final isFavorite =
                          favoriteProducts.contains(product['id'].toString());
                      return ListTile(
                        leading: Image.network(product['image']),
                        title: Text(product['title']),
                        subtitle: Text("\$${product['price']}"),
                        trailing: IconButton(
                          icon: Icon(isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border),
                          onPressed: () {
                            favoritesBloc.add(ToggleFavoriteEvent(
                                productId: product['id'].toString()));
                          },
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/productDetail',
                            arguments: product,
                          );
                        },
                      );
                    },
                  );
                },
              );
            } else if (state is ProductError) {
              return Center(
                  child: Text('Failed to load products: ${state.message}'));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
