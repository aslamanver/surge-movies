import 'dart:async';
import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:surge_movies/data/database/database_repo.dart';
import 'package:surge_movies/data/models/movie.dart';
import 'package:surge_movies/data/network/network.dart';
import 'package:surge_movies/secrets/secrets.dart' as secrets;

class MovieProvider extends ChangeNotifier {
  //
  NetworkTaskStatus networkTaskStatus = NetworkTaskStatus.loading;
  final List<Movie> _movieList = [];
  int _page = 1;
  Exception? exception;
  bool _isLocalData = false;

  UnmodifiableListView<Movie> get movieList => UnmodifiableListView(_movieList);
  int get page => _page;
  bool get isLocalData => _isLocalData;

  bool _isOffline = false;
  bool get isOffline => _isOffline;
  StreamSubscription<ConnectivityResult>? _subscription;

  void activateConnectivityListener() {
    //
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      checkConnectivity();
    });

    Connectivity().checkConnectivity().then((result) {
      checkConnectivity();
    });
  }

  void deactivateConnectivityListener() {
    _subscription?.cancel();
  }

  void checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    _isOffline = connectivityResult == ConnectivityResult.none;
    notifyListeners();
  }

  getData({int page = 1}) async {
    try {
      _isLocalData = false;
      if (networkTaskStatus != NetworkTaskStatus.loading) {
        networkStatus(NetworkTaskStatus.loading);
      }
      final movieResponse = (await getMovies(page: page));
      _page = movieResponse.page;
      _movieList.addAll(movieResponse.results);
      DatabaseRepo.instance.insertMovies(movieResponse.results);
      networkStatus(NetworkTaskStatus.success);
    } on Exception catch (e) {
      if (e is NetworkException) {
        final databaseMovies = await DatabaseRepo.instance.movies(page: page);
        if (databaseMovies.isEmpty) {
          exception = e;
          networkStatus(NetworkTaskStatus.failure);
        } else {
          // _movieList.clear();
          _movieList.addAll(databaseMovies);
          _isLocalData = true;
          _page = page;
          networkStatus(NetworkTaskStatus.success);
        }
      } else {
        exception = e;
        networkStatus(NetworkTaskStatus.failure);
      }
    }
  }

  networkStatus(NetworkTaskStatus status) {
    networkTaskStatus = status;
    notifyListeners();
  }

  reset() {
    _page = 1;
    _movieList.clear();
    networkTaskStatus = NetworkTaskStatus.success;
    notifyListeners();
  }

  clearLocalData() async {
    // final databaseMovies = await DatabaseRepo.instance.movies();
    // for (var movie in databaseMovies) {
    //   // await CachedNetworkImage.evictFromCache(
    //   //   '${secrets.imageEndpoint}${movie.posterPath}',
    //   // );
    //   DefaultCacheManager().removeFile(
    //     '${secrets.imageEndpoint}${movie.posterPath}',
    //   );
    // }
    networkStatus(NetworkTaskStatus.loading);
    // DefaultCacheManager().emptyCache();
    DatabaseRepo.instance.clear();
    reset();
  }
}
