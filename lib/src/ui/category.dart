import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_bloc_dio/src/bloc/genresbloc/genrebloc_bloc.dart';

import '../bloc/moviebloc/movie_bloc.dart';
import '../bloc/moviebloc/movie_state.dart';
import '../modal/genre.dart';
import '../modal/movie.dart';

class Category extends StatefulWidget {
  final int selectindex;
  Category({this.selectindex = 28});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int? selectedindex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedindex = widget.selectindex;
  }

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GenreblocBloc()..add(Genreeventstart()),
        ),
        BlocProvider(
          create: (context) => MovieBloc()
            ..add(MovieEventStarted(movieId: selectedindex!, query: '')),
        ),
      ],
      child: buildgenre(context),
    );
  }

  Widget buildgenre(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<GenreblocBloc, GenreblocState>(
          builder: (context, state) {
            if (state is Genreloading) {
              return Center(
                  child: Platform.isIOS
                      ? CupertinoActivityIndicator()
                      : CircularProgressIndicator());
            } else if (state is Genreloaded) {
              List<Genre> genres = state.movieList;
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
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: selectedindex == genre.id
                                        ? Colors.deepPurpleAccent
                                        : Colors.deepPurpleAccent.shade100,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Text(
                                  genre.name.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
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
              return Text('แตก');
            }
          },
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.only(bottom: 30),
          child: Text(
            'Now showing',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          height: 250,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              //ตอนดึงข้อมูลยังไม่เสร็จ
              if (state is MovieLoading) {
                return Center();
              } else if (state is MovieLoaded) {
                List<Movie> movies = state.movieList;

                return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      Movie movie = movies[index];

                      return GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                              placeholder: (context, url) => Platform.isAndroid
                                  ? CircularProgressIndicator()
                                  : CupertinoActivityIndicator(),
                              width: 200,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/image/not.jpg'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    separatorBuilder: ((context, index) {
                      return const Divider();
                    }),
                    itemCount: movies.length);
              } else {
                // errorตอนดึง
                return Container(
                    child: Text('ดึงไม่ได้',
                        style: TextStyle(color: Colors.white)));
              }
            },
          ),
        )
      ],
    );
  }

  Widget buildbody(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        //ตอนดึงข้อมูลยังไม่เสร็จ
        if
            //ตอนดึงข้อมูลยังเสร็จแล้ว

            (state is MovieLoaded) {
          List<Movie> movies = state.movieList;
          return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) {
                Movie movie = movies[index];

                return GestureDetector(
                  child: Stack(alignment: Alignment.bottomLeft, children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                        placeholder: (context, url) => Platform.isAndroid
                            ? CircularProgressIndicator()
                            : CupertinoActivityIndicator(),
                        height: 30,
                        width: 50,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/image/not.jpg'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                );
              }),
              separatorBuilder: ((context, index) {
                return const Divider();
              }),
              itemCount: movies.length);
        } else {
          // errorตอนดึง
          return Container(
              child: Text('ดึงไม่ได้', style: TextStyle(color: Colors.white)));
        }
      },
    );
  }
}
