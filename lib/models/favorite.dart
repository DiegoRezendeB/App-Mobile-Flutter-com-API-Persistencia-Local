class Favorite {
  final int movieId;
  final String title;
  final String posterPath;
  double rating;
  String comment;

  Favorite({
    required this.movieId,
    required this.title,
    required this.posterPath,
    this.rating = 0,
    this.comment = '',
  });

  Map<String, dynamic> toJson() => {
        'movieId': movieId,
        'title': title,
        'posterPath': posterPath,
        'rating': rating,
        'comment': comment,
      };

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        movieId: json['movieId'],
        title: json['title'],
        posterPath: json['posterPath'],
        rating: json['rating'],
        comment: json['comment'],
      );
}
