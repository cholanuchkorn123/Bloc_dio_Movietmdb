import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_bloc_dio/src/modal/moviedetial.dart';
import 'package:movie_bloc_dio/src/services/api_services.dart';

part 'moviedetial_event.dart';
part 'moviedetial_state.dart';

class MoviedetialBloc extends Bloc<MoviedetialEvent, MoviedetialState> {
  MoviedetialBloc() : super(Moviedetialloading()) {
    on<Moviedetialeventstart>((event, emit) async {
      final service = Apiservies();
      try {
        Moviedetialloading();
        final moviedata = await service.getmoviedetial(event.movieid);
        emit(Moviedetialloaded(movielist: moviedata));
      } catch (e) {
        print(e);
      }
    });
  }
}
