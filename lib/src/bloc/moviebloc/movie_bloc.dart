import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_bloc_dio/src/bloc/moviebloc/movie_repository.dart';
import 'package:movie_bloc_dio/src/bloc/moviebloc/themoviedb_provider.dart';
import 'package:movie_bloc_dio/src/services/api_services.dart';

import '../../modal/movie.dart';
import 'movie_state.dart';

part 'movie_event.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final Movierepository movierepository;
  MovieBloc({required this.movierepository}) : super(MovieLoading()) {
    on<MovieEventStarted>((event, emit) async {
      try {
        MovieLoading();
        var listmoviedata = await movierepository.getmovielist(event.movieId);
        emit(MovieLoaded(movieList: listmoviedata));
      } catch (e) {
        MovieError();
      }
    });
  }
}
