import 'dart:math';

import 'package:dio/dio.dart';
import 'package:movie_bloc_dio/src/modal/genre.dart';
import 'package:movie_bloc_dio/src/modal/moviedetial.dart';

import '../modal/image.dart';
import '../modal/movie.dart';

class Apiservies {
  final Dio dio = Dio();
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = 'api_key=a55258223c93ec62405d7a0d8825af53';

  Future<List<Movie>> gettoprate() async {
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

  Future<Moviedetial> getmoviedetial(int movieid) async {
    try {
      final response = await dio.get('$baseUrl/movie/$movieid?$apiKey');
      Moviedetial movielist = Moviedetial.fromJson(response.data);
      movielist.youtube = await getyoutube(movieid);
      movielist.movie = await getmovieimg(movieid);
      return movielist;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> getyoutube(int id) async {
    try {
      final response = await dio.get('$baseUrl/movie/$id/videos?$apiKey');
      var youtubeId = response.data['results'][0]['key'];
      return youtubeId;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<MovieImage> getmovieimg(int movieId) async {
    try {
      final response = await dio.get('$baseUrl/movie/$movieId/images?$apiKey');
      return MovieImage.fromJson(response.data);
    } catch (error) {
      throw Exception(e);
    }
  }
}
