part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ToggleFavoriteEvent extends FavoritesEvent {
  final String productId;

  ToggleFavoriteEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}

class LoadFavoritesEvent extends FavoritesEvent {}
