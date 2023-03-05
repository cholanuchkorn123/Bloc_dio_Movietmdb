import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_bloc_dio/src/bloc/genresbloc/genre_repository.dart';
import 'package:movie_bloc_dio/src/modal/genre.dart';
import 'package:movie_bloc_dio/src/services/api_services.dart';

part 'genrebloc_event.dart';
part 'genrebloc_state.dart';

class GenreblocBloc extends Bloc<GenreblocEvent, GenreblocState> {
  final Genrerepository repository;
  GenreblocBloc({required this.repository}) : super(Genreloading()) {
    on<GenreblocEvent>((event, emit) async {
      try {
        Genreloading();
        var listgenre = await repository.getgenrelist();
        emit(Genreloaded(genreList: listgenre));
      } catch (e) {
        throw Exception(e);
      }
    });
  }
}
