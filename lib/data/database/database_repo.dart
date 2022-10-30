import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:surge_movies/data/models/movie.dart';

class DatabaseRepo {
  //
  DatabaseRepo._();
  static final instance = DatabaseRepo._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('movies.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final databasePath = await getDatabasesPath();
    return await openDatabase(
      join(databasePath, filePath),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE movies(
            id INTEGER PRIMARY KEY,
            adult BOOLEAN,
            overview TEXT,
            release_date TEXT,
            genre_ids TEXT,
            original_title TEXT,
            original_language TEXT,
            title TEXT,
            popularity INTEGER,
            vote_count INTEGER,
            video BOOLEAN,
            vote_average INTEGER,
            poster_path TEXT,
            backdrop_path TEXT,
            timestamp INTEGER
          )
          ''',
        );
      },
      version: 1,
    );
  }

  Future<void> insertMovie(Movie movie) async {
    //
    final db = await database;
    await db.insert(
      'movies',
      {
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        ...movie.toMap(),
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> insertMovies(List<Movie> movies) async {
    for (int i = 0; i < movies.length; i++) {
      await insertMovie(movies[i]);
    }
  }

  Future<List<Movie>> movies({int page = 1}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'movies',
      orderBy: 'timestamp ASC',
      limit: 20,
      offset: (page - 1) * 20,
    );
    return List.generate(maps.length, (i) {
      return Movie.fromMap(maps[i]);
    });
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> clear() async {
    final db = await instance.database;
    db.execute('delete from movies');
  }
}
