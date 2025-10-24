import 'package:dio/dio.dart';
import 'models/movie_model.dart';

class MovieRepo {
  final Dio _dio = Dio();
  final String apiKey = '7906db679229c246149e72a36a5f6fd4';
  final String baseUrl = 'https://api.themoviedb.org/3/movie';

  Future<List<Movie>> fetchNowPlaying() async {
    final response = await _dio.get(
      '$baseUrl/now_playing?api_key=$apiKey',
    );

    final List results = response.data['results'];
    return results.map((json) => Movie.fromJson(json)).toList();
  }
}
