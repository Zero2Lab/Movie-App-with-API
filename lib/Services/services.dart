import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/Model.dart';

const apikey = "47e2c2da80d47a58ddc0ebdf26f123ed";

class ApiServices {
  final nowShowingApi = "https://api.themoviedb.org/3/movie/now_playing?api_key=$apikey";

  Future<List<Movie>> getNowShowing() async {
    Uri url = Uri.parse(nowShowingApi);
    final rs = await http.get(url);
    
      if (rs.statusCode == 200) {
        final List<dynamic> data = json.decode(rs.body)['results'];
        List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
        return movies;
      } else {
        throw Exception("failed to fetch movies");
      }
  }

  final upComingApi = "https://api.themoviedb.org/3/movie/upcoming?api_key=$apikey";

    Future<List<Movie>> getUpComing() async {
    Uri url = Uri.parse(upComingApi);
    final rs = await http.get(url);
    
      if (rs.statusCode == 200) {
        final List<dynamic> data = json.decode(rs.body)['results'];
        List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
        return movies;
      } else {
        throw Exception("failed to fetch movies");
      }
  }

  final popularApi ="https://api.themoviedb.org/3/movie/popular?api_key=$apikey";

      Future<List<Movie>> getPopular() async {
    Uri url = Uri.parse(popularApi);
    final rs = await http.get(url);

    if (rs.statusCode == 200) {
      final List<dynamic> data = json.decode(rs.body)['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception("Failed to fetch movies");
    }
  } 

}
