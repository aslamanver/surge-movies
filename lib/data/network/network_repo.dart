import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:surge_movies/data/models/movie_response.dart';
import 'package:surge_movies/secrets/secrets.dart' as secrets;
import 'package:surge_movies/data/network/network_exceptions.dart';

// https://www.themoviedb.org/talk/590ca6eac3a36865190008be {"errors":["page must be less than or equal to 1000"]}

enum NetworkTaskStatus {
  loading,
  success,
  failure,
}

Future<MovieResponse> getMovies({var page = 1}) async {
  var url = '${secrets.moviesEndpoint}?api_key=${secrets.apiKey}&page=$page';
  var response = await _startHTTP(url);
  if (response.statusCode == 200) {
    return MovieResponse.fromJson(convert.jsonDecode(response.body));
  } else {
    throw APIException(
      response.statusCode,
      response.body,
    );
  }
}

Future<Response> _startHTTP(url) async {
  try {
    return await http.get(Uri.parse(url));
  } on TimeoutException catch (e) {
    throw NetworkException(e);
  } on SocketException catch (e) {
    throw NetworkException(e);
  } catch (e) {
    rethrow;
  }
}
