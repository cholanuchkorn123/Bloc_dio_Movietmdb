import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_bloc_dio/src/bloc/moviedetial/moviedetial_bloc.dart';
import 'package:movie_bloc_dio/src/modal/screemshot.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/moviedetial/moviedetial_repository.dart';
import '../bloc/moviedetial/the_moviedetialdb_provider.dart';
import '../modal/movie.dart';
import '../modal/moviedetial.dart';

class Moviedetialscreen extends StatelessWidget {
  final Movie movie;

  const Moviedetialscreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MoviedetialBloc(Moviedetialrepository(provider: TheMovidetailsDbProvider()))
            ..add(Moviedetialeventstart(movieid: movie.id!)),
        ),
      ],
      child: WillPopScope(
          onWillPop: () async => true,
          child: Scaffold(
              backgroundColor: Color(0xff00425A), body: buildbody(context))),
    );
  }
}

Widget buildbody(context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<MoviedetialBloc, MoviedetialState>(
          builder: (context, state) {
            if (state is Moviedetialloading) {
              return Center(
                  child: Platform.isIOS
                      ? CupertinoActivityIndicator()
                      : CircularProgressIndicator());
            } else if (state is Moviedetialloaded) {
              Moviedetial moviedetial = state.movielist;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/original/${moviedetial.backdropPath}',
                        placeholder: (context, url) => Platform.isAndroid
                            ? CircularProgressIndicator()
                            : CupertinoActivityIndicator(),
                        height: MediaQuery.of(context).size.height / 2,
                        width: double.infinity,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50, left: 20),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Uri url = Uri.https('www.youtube.com',
                                '/embed/${moviedetial.youtube}');
                            await launchUrl(url);
                          },
                          child: Center(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 70),
                                  child: Icon(
                                    Icons.play_circle_outline,
                                    size: 70,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  moviedetial.title,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ]),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      'Overview',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      moviedetial.overview,
                      maxLines: 3,
                      style: TextStyle(color: Colors.white, height: 1.5),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text('Release Date',
                                style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline)),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                moviedetial.releaseDate
                                    .toString()
                                    .substring(0, 10),
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ],
                        ),
                        Expanded(child: Container()),
                        Column(
                          children: [
                            Text('Run Time',
                                style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline)),
                            SizedBox(
                              height: 5,
                            ),
                            Text('${moviedetial.runtime.toString()} m',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Screenshot',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(bottom: 20),
                      height: 160,
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            Screenshot? image =
                                moviedetial.movie?.backdrops![index];
                            return Card(
                              elevation: 3,
                              borderOnForeground: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/w500${image?.imagePath}',
                                  placeholder: (context, url) =>
                                      Platform.isAndroid
                                          ? CircularProgressIndicator()
                                          : CupertinoActivityIndicator(),
                                  width: 180,
                                  height: 350,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage('assets/image/not.jpg'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: ((context, index) {
                            return VerticalDivider(
                              color: Colors.transparent,
                              width: 5,
                            );
                          }),
                          itemCount: moviedetial.movie!.backdrops!.length)),
                ],
              );
            } else {
              return Container(
                child: Text('error'),
              );
            }
          },
        )
      ],
    ),
  );
}
