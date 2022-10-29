import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:surge_movies/data/database/database_repo.dart';
import 'package:surge_movies/data/models/movie.dart';
import 'package:surge_movies/data/network/network_repo.dart' as network_repo;
import 'package:surge_movies/data/network/network_repo.dart';

class MovieProvider extends ChangeNotifier {
  //
  NetworkTaskStatus networkTaskStatus = NetworkTaskStatus.loading;
  final List<Movie> _movieList = [];
  int _page = 1;
  Exception? exception;

  UnmodifiableListView<Movie> get movieList => UnmodifiableListView(_movieList);
  int get page => _page;

  getData({int page = 1, bool localSource = false}) async {
    try {
      if (networkTaskStatus != NetworkTaskStatus.loading) {
        networkStatus(NetworkTaskStatus.loading);
      }
      if (localSource) {
        final databaseMovies = await DatabaseRepo.instance.movies();
        _movieList.addAll(databaseMovies);
      } else {
        final movieResponse = (await network_repo.getMovies(page: page));
        _page = movieResponse.page;
        _movieList.addAll(movieResponse.results);
        DatabaseRepo.instance.insertMovies(movieResponse.results);
      }
      networkStatus(NetworkTaskStatus.success);
    } on Exception catch (e) {
      exception = e;
      networkStatus(NetworkTaskStatus.failure);
    }
  }

  networkStatus(NetworkTaskStatus status) {
    networkTaskStatus = status;
    notifyListeners();
  }
}
