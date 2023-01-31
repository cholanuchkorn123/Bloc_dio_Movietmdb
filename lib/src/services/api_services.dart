import 'package:dio/dio.dart';
import 'package:movie_bloc_dio/src/modal/genre.dart';
import 'package:movie_bloc_dio/src/modal/moviedetial.dart';

import '../modal/movie.dart';

class Apiservies {
  final Dio dio = Dio();
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = '';

  Future<List<Movie>> gettoprate() async {
    print('$baseUrl/movie/20?$apiKey');
    try {
      final response = await dio.get('$baseUrl/movie/now_playing?$apiKey');

      var movies = response.data['results'] as List;

      List<Movie> movieslist =
          movies.map((data) => Movie.fromJson(data)).toList();

      return movieslist;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Genre>> getgenre() async {
    try {
      final response = await dio.get('$baseUrl/genre/movie/list?$apiKey');

      var movies = response.data['genres'] as List;

      List<Genre> movieslist =
          movies.map((data) => Genre.fromJson(data)).toList();

      return movieslist;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Movie>> getbygenre(num genreid) async {
    try {
      final response =
          await dio.get('$baseUrl/discover/movie?with_genres=$genreid&$apiKey');

      var movies = response.data['results'] as List;

      List<Movie> movieslist =
          movies.map((data) => Movie.fromJson(data)).toList();

      return movieslist;
    } catch (e) {
      throw Exception(e);
    }
  }
  Future<List<Moviedetial>> getmoviedetial(num movieid) async {
    try {
      final response =
          await dio.get('$baseUrl/movie/$movieid?$apiKey');

      var movies = response.data['results'] as List;

      List<Moviedetial> movieslist =
          movies.map((data) => Moviedetial.fromJson(data)).toList();

      return movieslist;
    } catch (e) {
      throw Exception(e);
    }
  }
}
