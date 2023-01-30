part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class MovieEventStarted extends MovieEvent {
  final int movieId;
  final String? query;

  const MovieEventStarted({this.query,required this.movieId});

  @override
  List<Object> get props => [];
}