import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const String apiKey = '4021bdef795c8a0ea3c125eadfe4ecf4';

class ApiService {
  final String _base = 'https://api.themoviedb.org/3';

  Future<List<Movie>> fetchPopular() async {
    final url = '$_base/movie/popular?api_key=$apiKey&language=pt-BR';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      return (data['results'] as List)
          .map((j) => Movie.fromJson(j))
          .toList();
    } else {
      throw Exception('Erro ao buscar populares');
    }
  }
}
