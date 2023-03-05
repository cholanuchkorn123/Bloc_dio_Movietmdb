
import 'package:movie_bloc_dio/src/modal/moviedetial.dart';
import 'package:movie_bloc_dio/src/services/api_services.dart';

class TheMovidetailsDbProvider {
  Future<Moviedetial> getmoviedetial(int movieid) async {
    final service = Apiservies();
    try {
      final moviedata = await service.getmoviedetial(movieid);
      return moviedata;
    } catch (e) {
      throw Exception(e);
    }
  }
}
