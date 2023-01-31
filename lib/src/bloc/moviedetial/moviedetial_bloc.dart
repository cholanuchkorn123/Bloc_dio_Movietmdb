import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'moviedetial_event.dart';
part 'moviedetial_state.dart';

class MoviedetialBloc extends Bloc<MoviedetialEvent, MoviedetialState> {
  MoviedetialBloc() : super(MoviedetialInitial()) {
    on<MoviedetialEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
