import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie.dart';
import '../models/favorite.dart';
import '../services/api_service.dart';

class MovieProvider extends ChangeNotifier {
  final ApiService _api = ApiService();
  List<Movie> _movies = [];
  List<Favorite> _favorites = [];

  List<Movie> get movies => _movies;
  List<Favorite> get favorites => _favorites;

  MovieProvider() {
    _loadFavorites();
  }

  Future<void> fetchMovies() async {
    _movies = await _api.fetchPopular();
    notifyListeners();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favString = prefs.getString('favorites') ?? '[]';
    final List decoded = json.decode(favString);
    _favorites =
        decoded.map((j) => Favorite.fromJson(j as Map<String, dynamic>)).toList();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = json.encode(_favorites.map((f) => f.toJson()).toList());
    await prefs.setString('favorites', encoded);
  }

  bool isFav(int id) => _favorites.any((f) => f.movieId == id);

  Future<void> addFavorite(Favorite fav) async {
    _favorites.add(fav);
    await _saveFavorites();
    notifyListeners();
  }

  Future<void> updateFavorite(Favorite fav) async {
    final idx = _favorites.indexWhere((f) => f.movieId == fav.movieId);
    if (idx >= 0) {
      _favorites[idx] = fav;
      await _saveFavorites();
      notifyListeners();
    }
  }

  Future<void> removeFavorite(int movieId) async {
    _favorites.removeWhere((f) => f.movieId == movieId);
    await _saveFavorites();
    notifyListeners();
  }
}
