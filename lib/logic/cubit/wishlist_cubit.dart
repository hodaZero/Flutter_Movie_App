import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/movie_model.dart';
import '../../data/wishlist_helper.dart';

class WishlistCubit extends Cubit<List<Movie>> {
  final SharedPreferences prefs;

  WishlistCubit(this.prefs) : super(WishlistHelper.getWishlist(prefs));

  void toggleWishlist(Movie movie) {
    final current = List<Movie>.from(state);
    if (current.any((m) => m.id == movie.id)) {
      current.removeWhere((m) => m.id == movie.id);
    } else {
      current.add(movie);
    }
    WishlistHelper.saveWishlist(prefs, current);
    emit(current);
  }

  bool isInWishlist(Movie movie) {
    return state.any((m) => m.id == movie.id);
  }

  void clearWishlist() {
    WishlistHelper.saveWishlist(prefs, []);
    emit([]);
  }
}
