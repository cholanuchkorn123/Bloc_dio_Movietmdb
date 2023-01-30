part of 'genrebloc_bloc.dart';

abstract class GenreblocEvent extends Equatable {
  const GenreblocEvent();


}
class Genreeventstart extends GenreblocEvent{
  @override
  List<Object> get props => [];
}