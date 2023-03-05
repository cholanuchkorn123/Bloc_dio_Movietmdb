import 'package:movie_bloc_dio/src/bloc/moviebloc/themoviedb_provider.dart';

import 'package:movie_bloc_dio/src/modal/movie.dart';

class Movierepository {
  final TheMovidProvider provider;
  Movierepository({required this.provider});
  Future<List<Movie>> getmovielist(int movieid) async {
   final data;
    if (movieid == 0) {
      data =await provider.getmovietoprate();
    } else {
      data =await provider.getmoviebygenre(movieid);
    }
    return data;
  }
}
