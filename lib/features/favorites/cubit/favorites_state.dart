import 'package:equatable/equatable.dart';
import '../../data/models/favorite_model.dart';

class FavoritesState extends Equatable {
  final List<FavoriteQuote> favorites;
  final bool isLoading;

  const FavoritesState({this.favorites = const [], this.isLoading = false});

  FavoritesState copyWith({List<FavoriteQuote>? favorites, bool? isLoading}) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [favorites, isLoading];
}
