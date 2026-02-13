import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/favorite_model.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesState()) {
    loadFavorites();
  }

  void addFavorite(String text) {
    if (!state.favorites.any((q) => q.text == text)) {
      final newFavorites = List<FavoriteQuote>.from(state.favorites)
        ..add(FavoriteQuote(text: text, addedAt: DateTime.now()));
      emit(state.copyWith(favorites: newFavorites));
      saveFavorites(newFavorites);
    }
  }

  void removeFavorite(String text) {
    final newFavorites = state.favorites.where((q) => q.text != text).toList();
    emit(state.copyWith(favorites: newFavorites));
    saveFavorites(newFavorites);
  }

  bool isFavorite(String text) {
    return state.favorites.any((q) => q.text == text);
  }

  Future<void> saveFavorites(List<FavoriteQuote> favorites) async {
    // Implementation for Hive or SharedPreferences can be added here as in the original provider
  }

  Future<void> loadFavorites() async {
    emit(state.copyWith(isLoading: true));
    // Implementation for loading can be added here
    emit(state.copyWith(isLoading: false));
  }
}
