import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_bloc_dio/src/services/api_services.dart';

import '../../modal/movie.dart';
import 'movie_state.dart';

part 'movie_event.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieLoading()) {
    on<MovieEventStarted>((event, emit) async {
      final service = Apiservies();

      try {
        MovieLoading();
        List<Movie> movieList;

        if (event.movieId == 0) {
          movieList = await service.gettoprate();

          emit(MovieLoaded(movieList: movieList));
        } else {
          movieList = await service.getbygenre(event.movieId);
           emit(MovieLoaded(movieList: movieList));
        }
      } catch (e) {
        print('this is $e');
        MovieError();
      }
    });
  }
}
