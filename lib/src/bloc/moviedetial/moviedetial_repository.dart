
import 'package:movie_bloc_dio/src/bloc/moviedetial/the_moviedetialdb_provider.dart';

import 'package:movie_bloc_dio/src/modal/moviedetial.dart';

class Moviedetialrepository {
  final TheMovidetailsDbProvider provider;
  Moviedetialrepository({required this.provider});
  Future<Moviedetial> getmoviedetial(int movieid) async {
    final data = await provider.getmoviedetial(movieid);
    return data;
  }
}
