part of 'moviedetial_bloc.dart';

abstract class MoviedetialEvent extends Equatable {
  const MoviedetialEvent();

  @override
  List<Object> get props => [];
}

class Moviedetialeventstart extends MoviedetialEvent {
  final int movieid;
  Moviedetialeventstart({required this.movieid});
  @override
  List<Object> get props => [];
}
