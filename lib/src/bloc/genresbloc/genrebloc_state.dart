part of 'genrebloc_bloc.dart';

abstract class GenreblocState extends Equatable {
  const GenreblocState();
  
  @override
  List<Object> get props => [];
}

class Genreloading extends GenreblocState {}
class Genreloaded extends GenreblocState {
   final List<Genre> genreList;
  const Genreloaded({required this.genreList});

  @override
  List<Object> get props => [genreList];
}
class Genreerror extends GenreblocState {}