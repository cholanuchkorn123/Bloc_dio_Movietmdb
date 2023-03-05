
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_bloc_dio/src/bloc/moviebloc/movie_repository.dart';
import 'package:movie_bloc_dio/src/bloc/moviebloc/themoviedb_provider.dart';
import 'package:movie_bloc_dio/src/ui/components/status.dart';
import 'package:movie_bloc_dio/src/ui/moviedetail.dart';
import 'package:movie_bloc_dio/src/ui/utilities/constants.dart';



import '../bloc/moviebloc/movie_bloc.dart';
import '../bloc/moviebloc/movie_state.dart';
import '../modal/movie.dart';
import 'category.dart';
import 'components/pictureframe.dart';
import 'components/showalert.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final moviebloc = BlocProvider(
        create: (context) =>
            MovieBloc(movierepository: Movierepository(provider: TheMovidProvider()))..add(const MovieEventStarted(query: '', movieId: 0)));
    return MultiBlocProvider(
        providers: [
          moviebloc,
        ],
        child: Scaffold(
          backgroundColor:const Color(0xffC85C8E),
          body: MediaQuery.of(context).orientation == Orientation.portrait? Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xffC85C8E), Color(0xffFFB26B)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight)),
              child: buildbody(context)):Center(child: Text('Coming soon'),),
          appBar: AppBar(
            elevation: 0,
            backgroundColor:const Color(0xffC85C8E),
            actions: [
              Container(
                padding:const EdgeInsets.symmetric(horizontal: 15),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Showdialog(context, 'Comingsoon');
                      },
                      child: const Icon(
                        Icons.person,
                        color: Color(0xffD9ACF5),
                        size: 30,
                      ),
                    ),
                    Expanded(child: Container()),
                    GestureDetector(
                      onTap: () {
                        Showdialog(context, 'Comingsoon');
                      },
                      child: const Icon(
                        Icons.menu,
                        color: Color(0xffD9ACF5),
                        size: 30,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget buildbody(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SingleChildScrollView(
          child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: constraints.maxHeight,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              //ตอนดึงข้อมูลยังไม่เสร็จ
              if (state is MovieLoading) {
                return Status().loading(context);
              } else if
                  //ตอนดึงข้อมูลยังเสร็จแล้ว

                  (state is MovieLoaded) {
                List<Movie> movies = state.movieList;
                return Column(
                  children: [
                    CarouselSlider.builder(
                      itemCount: movies.length,
                      itemBuilder: ((context, index, realIndex) {
                        Movie movie = movies[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Moviedetialscreen(movie: movie)));
                          },
                          child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Pictureframe(
                                  movie: movie,
                                  baseurl:
                                      'https://image.tmdb.org/t/p/original/',
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                ),
                                Padding(
                                  padding:const EdgeInsets.only(
                                    bottom: 10,
                                    right: 15,
                                  ),
                                  child: Text(
                                    movie.title.toString().toUpperCase(),
                                    style: ktextinpicture,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ]),
                        );
                      }),
                      options: CarouselOptions(
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval:const Duration(seconds: 5),
                        autoPlayAnimationDuration:const  Duration(milliseconds: 800),
                        pauseAutoPlayOnTouch: true,
                        viewportFraction: 0.8,
                        enlargeCenterPage: true,
                      ),
                    ),
                    const Padding(
                      padding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      child:Category(),
                    ),
                  ],
                );
              } else {
                // errorตอนดึง
                return Status().falied(context);
              }
            },
          )
        ]),
      ));
    });
  }
}
