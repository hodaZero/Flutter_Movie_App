import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/cubit/movie_cubit.dart';
import '../../../logic/cubit/movie_state.dart';
import '../../../logic/cubit/wishlist_cubit.dart';
import '../../../data/models/movie_model.dart';
import 'movie_details_page.dart';
import 'wishlist_page.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
        actions: [
          BlocBuilder<WishlistCubit, List<Movie>>(
            builder: (context, wishlist) {
              final hasFavorites = wishlist.isNotEmpty;
              return IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: hasFavorites ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const WishlistPage()),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.6,
                ),
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return MovieGridCard(movie: movie, index: index);
                },
              ),
            );
          } else if (state is MovieError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text("No Data"));
        },
      ),
    );
  }
}

class MovieGridCard extends StatefulWidget {
  final Movie movie;
  final int index;

  const MovieGridCard({super.key, required this.movie, required this.index});

  @override
  State<MovieGridCard> createState() => _MovieGridCardState();
}

class _MovieGridCardState extends State<MovieGridCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    final curved = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(curved);
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curved);

    Future.delayed(Duration(milliseconds: 50 * widget.index), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFav = context.watch<WishlistCubit>().isInWishlist(widget.movie);

    return FadeTransition(
      opacity: _opacityAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MovieDetailsPage(movie: widget.movie),
              ),
            );
          },
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Hero(
                      tag: widget.movie.id,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w200${widget.movie.posterPath}',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
              Positioned(
                top: 8,
                right: 8,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white70,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : Colors.grey,
                      size: 18,
                    ),
                    onPressed: () {
                      context.read<WishlistCubit>().toggleWishlist(widget.movie);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
