import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_bloc_dio/src/bloc/moviedetial/moviedetial_bloc.dart';

import '../modal/movie.dart';

class Moviedetialscreen extends StatelessWidget {
  final Movie movie;

  const Moviedetialscreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              MoviedetialBloc()..add(Moviedetialeventstart(movieid: movie.id!)),
        ),
      ],
      child: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.arrow_back_ios_new_outlined),
            backgroundColor: Colors.transparent,
          ),
          body: buildbody(context)),
    );
  }
}

Widget buildbody(context) {
  return Column(
    children: [
      BlocBuilder<MoviedetialBloc, MoviedetialState>(
        builder: (context, state) {
          if (state is Moviedetialloading) {
            return Container(
              child: Text('isloading'),
            );
          } else if (state is Moviedetialloaded) {
            return Container(
              child: Text('loaded'),
            );
          } else {
            return Container(
              child: Text('error'),
            );
          }
        },
      )
    ],
  );
}
