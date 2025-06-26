import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../models/favorite.dart';
import '../providers/movie_provider.dart';
import 'rating_dialog.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<MovieProvider>();
    final isFav = prov.isFav(movie.id);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/movie', arguments: movie);
      },
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 80),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                movie.title,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  visualDensity: VisualDensity.compact,
                  iconSize: 22,
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.redAccent : Colors.white70,
                  ),
                  onPressed: () {
                    if (isFav) {
                      prov.removeFavorite(movie.id);
                    } else {
                      prov.addFavorite(Favorite(
                        movieId: movie.id,
                        title: movie.title,
                        posterPath: movie.posterPath,
                      ));
                    }
                  },
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  iconSize: 22,
                  icon: const Icon(Icons.star, color: Colors.amber),
                  onPressed: () {
                    final fav = Favorite(
                      movieId: movie.id,
                      title: movie.title,
                      posterPath: movie.posterPath,
                    );
                    showDialog(
                      context: context,
                      builder: (context) => RatingDialog(fav: fav),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
