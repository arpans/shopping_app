part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesUpdated extends FavoritesState {
  final List<String> favoriteProducts;

  FavoritesUpdated({required this.favoriteProducts});

  @override
  List<Object> get props => [favoriteProducts];
}
