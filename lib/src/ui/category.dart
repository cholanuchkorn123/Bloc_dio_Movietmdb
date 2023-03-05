import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_bloc_dio/src/bloc/genresbloc/genre_repository.dart';
import 'package:movie_bloc_dio/src/bloc/genresbloc/genrebloc_bloc.dart';
import 'package:movie_bloc_dio/src/bloc/genresbloc/thegenre_provider.dart';
import 'package:movie_bloc_dio/src/ui/components/pictureframe.dart';
import 'package:movie_bloc_dio/src/ui/components/status.dart';
import 'package:movie_bloc_dio/src/ui/utilities/constants.dart';

import '../bloc/moviebloc/movie_bloc.dart';
import '../bloc/moviebloc/movie_repository.dart';
import '../bloc/moviebloc/movie_state.dart';
import '../bloc/moviebloc/themoviedb_provider.dart';
import '../modal/genre.dart';
import '../modal/movie.dart';
import 'moviedetail.dart';

class Category extends StatefulWidget {
  final int selectindex;
  const Category({super.key, this.selectindex = 28});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int? selectedindex;

  @override
  void initState() {
    super.initState();
    selectedindex = widget.selectindex;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GenreblocBloc(repository: Genrerepository(provider: TheGenreProvider()))..add(Genreeventstart()),
        ),
        BlocProvider(
          create: (context) => MovieBloc(
              movierepository: Movierepository(provider: TheMovidProvider()))
            ..add(MovieEventStarted(movieId: selectedindex!, query: '')),
        ),
      ],
      child: buildgenre(context),
    );
  }

  Widget buildgenre(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        BlocBuilder<GenreblocBloc, GenreblocState>(
          builder: (context, state) {
            if (state is Genreloading) {
              return Status().loading(context);
            } else if (state is Genreloaded) {
              List<Genre> genres = state.genreList;
              return Container(
                height: 60,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      Genre genre = genres[index];

                      return Column(
                        children: [
                          Row(children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedindex = genre.id;
                                  context.read<MovieBloc>()
                                    ..add(MovieEventStarted(
                                        movieId: selectedindex!, query: ''));
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: selectedindex == genre.id
                                        ? Color(0xffFF9E9E)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 2, color: Colors.grey)),
                                child: Text(
                                  genre.name.toString(),
                                  style: stylesmallname,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            )
                          ]),
                        ],
                      );
                    }),
                    separatorBuilder: ((context, index) {
                      return const Divider();
                    }),
                    itemCount: genres.length),
              );
            } else {
              return Status().falied(context);
            }
          },
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          padding: EdgeInsets.only(bottom: 5, right: 15),
          child: Text('Now Showing', style: styleheadname),
        ),
        Container(
          height: 350,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is MovieLoading) {
                return Status().loading(context);
              } else if (state is MovieLoaded) {
                List<Movie> movies = state.movieList;

                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      Movie movie = movies[index];

                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Moviedetialscreen(movie: movie)));
                              },
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 8),
                                  child: Pictureframe(
                                    movie: movie,
                                    baseurl:
                                        'https://image.tmdb.org/t/p/original/',
                                    radius: 15,
                                  )),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    movie.title.toString().length > 30
                                        ? '${movie.title.toString().substring(0, 25)}...'
                                        : movie.title.toString(),
                                    style: TextStyle(
                                        color: Color(0xff3C2A21),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      movie.releaseDate
                                          .toString()
                                          .substring(0, 10),
                                      style: TextStyle(
                                          color: Color(0xff3C2A21),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                    itemCount: movies.length);
              } else {
                // errorตอนดึง
                return Status().falied(context);
              }
            },
          ),
        )
      ],
    );
  }
}
