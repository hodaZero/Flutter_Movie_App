import 'package:flutter/material.dart';
import 'package:my_last/data/models/movie_model.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;
  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Hero(
              tag: movie.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  width: double.infinity,
                  height: 400,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              movie.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('🗓️ Release: ${movie.releaseDate}'),
            const SizedBox(height: 10),
            Text('⭐ Rating: ${movie.voteAverage}'),
            const SizedBox(height: 20),
            Text(
              movie.overview,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}