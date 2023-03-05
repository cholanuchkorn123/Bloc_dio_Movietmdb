import 'package:movie_bloc_dio/src/services/api_services.dart';

import '../../modal/movie.dart';

class TheMovidProvider {
  Future<List<Movie>> getmovietoprate() async {
    final service = Apiservies();
    try {
      final moviedata = await service.gettoprate();
      return moviedata;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Movie>> getmoviebygenre(int movieid) async {
    final service = Apiservies();
    try {
      final moviedata = await service.getbygenre(movieid);
      return moviedata;
    } catch (e) {
      throw Exception(e);
    }
  }
}
