import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_bloc_dio/src/modal/genre.dart';
import 'package:movie_bloc_dio/src/services/api_services.dart';

part 'genrebloc_event.dart';
part 'genrebloc_state.dart';

class GenreblocBloc extends Bloc<GenreblocEvent, GenreblocState> {
  GenreblocBloc() : super(Genreloading()) {
    on<GenreblocEvent>((event, emit) async {
      final service = Apiservies();
      try {
        Genreloading();
        List<Genre> genrelist = await service.getgenre();
        emit(Genreloaded(movieList: genrelist));
      } catch (e) {
        print('this is genre error $e');
      }
    });
  }
}
