import 'dart:convert' as convert;
import 'package:surge_movies/data/network/network.dart';
import 'package:test/test.dart';
import 'package:surge_movies/data/models/models.dart';
import 'package:surge_movies/secrets/secrets.dart' as secrets;
import 'package:http/http.dart' as http;

void main() {
  test('Movie response model should be mapped with json response', () async {
    //
    var url = '${secrets.moviesEndpoint}?api_key=${secrets.apiKey}&page=1';
    var res = await http.get(Uri.parse(url));
    var jsonResponse = convert.jsonDecode(res.body);
    var movieResponse = MovieResponse.fromJson(jsonResponse);

    expect(movieResponse.results[0].id, jsonResponse['results'][0]['id']);
    expect(movieResponse.results[10].id, jsonResponse['results'][10]['id']);
    expect(movieResponse.results[5].id, jsonResponse['results'][5]['id']);
    expect(movieResponse.results[7].id, jsonResponse['results'][7]['id']);
    expect(movieResponse.results[1].id, jsonResponse['results'][1]['id']);
  });

  test('Network provider "getMovies()" should be mapped properly', () async {
    //
    var movieResponse = await getMovies(page: 5);
    expect(movieResponse.results[0].voteCount, greaterThan(1));
  });
}
