part of 'genrebloc_bloc.dart';

abstract class GenreblocState extends Equatable {
  const GenreblocState();
  
  @override
  List<Object> get props => [];
}

class Genreloading extends GenreblocState {}
class Genreloaded extends GenreblocState {
   final List<Genre> movieList;
  const Genreloaded({required this.movieList});

  @override
  List<Object> get props => [movieList];
}
class Genreerror extends GenreblocState {}