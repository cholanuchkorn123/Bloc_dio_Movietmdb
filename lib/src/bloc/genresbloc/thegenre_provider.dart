import 'package:movie_bloc_dio/src/services/api_services.dart';

import '../../modal/genre.dart';


class TheGenreProvider {
  Future<List<Genre>> getgenre() async {
    final service = Apiservies();
    try {
      final genrelistdata = await service.getgenre();
      return genrelistdata;
    } catch (e) {
      throw Exception(e);
    }
  }

 
}
