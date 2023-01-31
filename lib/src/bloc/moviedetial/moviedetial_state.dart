part of 'moviedetial_bloc.dart';

abstract class MoviedetialState extends Equatable {
  const MoviedetialState();

  @override
  List<Object> get props => [];
}

class Moviedetialloading extends MoviedetialState {}

class Moviedetialloaded extends MoviedetialState {
  final Moviedetial movielist;
  Moviedetialloaded({required this.movielist});
   @override
  List<Object> get props => [movielist];
}

class Moviedetialerror extends MoviedetialState {}
