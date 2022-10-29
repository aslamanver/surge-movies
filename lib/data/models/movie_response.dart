import 'package:surge_movies/data/models/movie.dart';

class MovieResponse {
  final num totalPages;
  final num totalResults;
  final int page;
  final List<Movie> results;

  MovieResponse({
    required this.totalPages,
    required this.totalResults,
    required this.page,
    required this.results,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    return MovieResponse(
      totalPages: json['total_pages'] as num,
      totalResults: json['total_results'] as num,
      page: json['page'] as int,
      results: List<dynamic>.from(json['results'])
          .map((e) => Movie.fromMap(e))
          .toList(),
    );
  }
}
