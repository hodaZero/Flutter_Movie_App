import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/cubit/wishlist_cubit.dart';
import '../../../data/models/movie_model.dart';
import 'movie_details_page.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistCubit>().state;

    return Scaffold(
      appBar: AppBar(title: const Text("❤️ My Wishlist")),
      body: wishlist.isEmpty
          ? const Center(child: Text("No movies added yet"))
          : ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final movie = wishlist[index];
                final cubit = context.read<WishlistCubit>();

                return ListTile(
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(movie.title),
                  subtitle: Text('⭐ ${movie.voteAverage}'),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      cubit.toggleWishlist(movie); // delete from wishlist
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MovieDetailsPage(movie: movie),
                      ),
                    );
                  },
                ); 
              },
            ),
    );
  }
}
