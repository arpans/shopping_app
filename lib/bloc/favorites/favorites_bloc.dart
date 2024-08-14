import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<LoadFavoritesEvent>(_onLoadFavorites);
  }

  Future<void> _onToggleFavorite(
      ToggleFavoriteEvent event, Emitter<FavoritesState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final favoriteProducts = prefs.getStringList('favorites') ?? [];

    if (favoriteProducts.contains(event.productId)) {
      favoriteProducts.remove(event.productId);
    } else {
      favoriteProducts.add(event.productId);
    }

    prefs.setStringList('favorites', favoriteProducts);
    emit(FavoritesUpdated(favoriteProducts: favoriteProducts));
  }

  Future<void> _onLoadFavorites(
      LoadFavoritesEvent event, Emitter<FavoritesState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final favoriteProducts = prefs.getStringList('favorites') ?? [];
    emit(FavoritesUpdated(favoriteProducts: favoriteProducts));
  }
}