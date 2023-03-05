import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_bloc_dio/src/bloc/moviedetial/moviedetial_repository.dart';
import 'package:movie_bloc_dio/src/modal/moviedetial.dart';

part 'moviedetial_event.dart';
part 'moviedetial_state.dart';

class MoviedetialBloc extends Bloc<MoviedetialEvent, MoviedetialState> {
  final Moviedetialrepository moviedetialrepository;
  MoviedetialBloc(this.moviedetialrepository) : super(Moviedetialloading()) {
    on<Moviedetialeventstart>((event, emit) async {
      try {
        Moviedetialloading();

        var moviedetial =
            await moviedetialrepository.getmoviedetial(event.movieid);
     
        emit(Moviedetialloaded(movielist: moviedetial));
      } catch (e) {
        throw Exception(e);
      }
    });
  }
}
