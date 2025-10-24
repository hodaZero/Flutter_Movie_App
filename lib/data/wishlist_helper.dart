import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/movie_model.dart';

class WishlistHelper {
  static const String key = 'wishlist';

  static List<Movie> getWishlist(SharedPreferences prefs) {
    final jsonString = prefs.getString(key);
    if (jsonString == null) return [];
    final List list = json.decode(jsonString);
    return list.map((e) => Movie.fromJson(e)).toList();
  }

  static void saveWishlist(SharedPreferences prefs, List<Movie> movies) {
    final jsonString = json.encode(movies.map((e) => e.toJson()).toList());
    prefs.setString(key, jsonString);
  }
}
