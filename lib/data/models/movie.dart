import 'package:surge_movies/utils/extensions.dart';

class Movie {
  final bool adult;
  final String overview;
  final String releaseDate;
  final List<num> genreIds;
  final num id;
  final String originalTitle;
  final String originalLanguage;
  final String title;
  final num popularity;
  final num voteCount;
  final bool video;
  final num voteAverage;
  final String? posterPath;
  final String? backdropPath;

  Movie({
    required this.id,
    required this.adult,
    required this.overview,
    required this.releaseDate,
    required this.genreIds,
    required this.originalTitle,
    required this.originalLanguage,
    required this.title,
    required this.popularity,
    required this.voteCount,
    required this.video,
    required this.voteAverage,
    this.posterPath,
    this.backdropPath,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    // Caching image
    // if (map['poster_path'] != null) {
    //   DefaultCacheManager().getFileStream(
    //     '${secrets.imageEndpoint}${map['poster_path']}',
    //   );
    // }
    return Movie(
      id: map['id'] as num,
      adult: asBool(map['adult']),
      overview: map['overview'].toString(),
      releaseDate: map['release_date'].toString(),
      genreIds: map['genre_ids'] is List<dynamic>
          ? List<dynamic>.from(
              map['genre_ids'],
            ).map((e) => e as num).toList()
          : map['genre_ids'].toString().isEmpty ? [] : map['genre_ids']
              .toString()
              .split(',')
              .map((e) => num.parse(e))
              .toList(),
      originalTitle: map['original_title'].toString(),
      originalLanguage: map['original_language'].toString(),
      title: map['title'].toString(),
      popularity: map['popularity'] as num,
      voteCount: map['vote_count'] as num,
      video: asBool(map['video']),
      voteAverage: map['vote_average'] as num,
      posterPath: map['poster_path'].toString(),
      backdropPath: map['backdrop_path'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'adult': adult,
      'overview': overview,
      'release_date': releaseDate,
      'genre_ids': genreIds.join(','),
      'original_title': originalTitle,
      'original_language': originalLanguage,
      'title': title,
      'popularity': popularity,
      'vote_count': voteCount,
      'video': video,
      'vote_average': voteAverage,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
    };
  }
}
