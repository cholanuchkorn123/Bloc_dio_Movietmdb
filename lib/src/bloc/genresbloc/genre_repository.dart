import 'package:movie_bloc_dio/src/bloc/genresbloc/thegenre_provider.dart';


import '../../modal/genre.dart';

class Genrerepository {
  final TheGenreProvider provider;
Genrerepository({required this.provider});
  Future<List<Genre>> getgenrelist() async {
    final data = await provider.getgenre();
    return data;
  }
}
