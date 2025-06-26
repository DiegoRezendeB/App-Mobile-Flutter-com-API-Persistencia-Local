import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../models/favorite.dart';
import '../widgets/rating_dialog.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool _ordenarPorNota = false;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<MovieProvider>();
    List<Favorite> favs = List.from(prov.favorites);

    if (_ordenarPorNota) {
      favs.sort((a, b) => b.rating.compareTo(a.rating));
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Meus Favoritos'),
        actions: [
          IconButton(
            tooltip: 'Ordenar por nota',
            icon: Icon(
              _ordenarPorNota ? Icons.sort_by_alpha : Icons.star,
              color: Colors.amber,
            ),
            onPressed: () {
              setState(() => _ordenarPorNota = !_ordenarPorNota);
            },
          ),
        ],
      ),
      body: favs.isEmpty
          ? const Center(child: Text('Nenhum favorito ainda'))
          : ListView.builder(
              key: _listKey,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: favs.length,
              itemBuilder: (context, index) {
                final fav = favs[index];

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Card(
                    color: Theme.of(context).cardColor,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w200${fav.posterPath}',
                          width: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.broken_image),
                        ),
                      ),
                      title: Text(
                        fav.title,
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Row(
                            children: List.generate(5, (i) {
                              return Icon(
                                Icons.star,
                                size: 18,
                                color: i < fav.rating ? Colors.amber : Colors.grey,
                              );
                            }),
                          ),
                          if (fav.comment.trim().isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                fav.comment,
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                      ),
                      trailing: Wrap(
                        spacing: 4,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blueAccent),
                            onPressed: () async {
                              final updated = await showDialog<Favorite>(
                                context: context,
                                builder: (_) => RatingDialog(fav: fav),
                              );
                              if (updated != null) {
                                prov.updateFavorite(updated);
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () {
                              prov.removeFavorite(fav.movieId);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
