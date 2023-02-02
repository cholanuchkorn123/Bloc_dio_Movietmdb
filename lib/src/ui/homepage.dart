import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_bloc_dio/src/ui/moviedetail.dart';

import 'dart:io';

import '../bloc/moviebloc/movie_bloc.dart';
import '../bloc/moviebloc/movie_state.dart';
import '../modal/movie.dart';
import 'category.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final moviebloc = BlocProvider(
        create: (context) =>
            MovieBloc()..add(MovieEventStarted(query: '', movieId: 0)));
    return MultiBlocProvider(
        providers: [
          moviebloc,
        ],
        child: Scaffold(
          backgroundColor: Color(0xffC85C8E),
          body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xffC85C8E), Color(0xffFFB26B)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight)),
              child: buildbody(context)),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xffC85C8E),
            // title: Text(
            //   'Movie Show',
            //   style: TextStyle(
            //       color: Colors.deepPurpleAccent,
            //       fontSize: 25,
            //       fontWeight: FontWeight.w600),
            // ),
            actions: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  backgroundColor: Colors.purple.shade200,
                                  content: Text(
                                    'Coming Soon',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                ));
                      },
                      child: Container(
                        child: Icon(
                          Icons.person,
                          color: Color(0xffD9ACF5),
                          size: 30,
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  backgroundColor: Colors.purple.shade200,
                                  content: Text(
                                    'Coming Soon',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                ));
                      },
                      child: Container(
                        child: Icon(
                          Icons.menu,
                          color: Color(0xffD9ACF5),
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              // Container(
              //   padding: EdgeInsets.only(right: 10),
              //   child: CircleAvatar(
              //       radius: 25,
              //       backgroundImage: AssetImage('assets/image/movie.jpg')),
              // )
            ],
          ),
        ));
  }

  Widget buildbody(BuildContext context) {
    return
        //สร้างเอาไว้ใช้ responsive design ได้ตามwidth
        LayoutBuilder(
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
                return Center(
                    child: Platform.isIOS
                        ? CupertinoActivityIndicator()
                        : CircularProgressIndicator());
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
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                                    placeholder: (context, url) =>
                                        Platform.isAndroid
                                            ? CircularProgressIndicator()
                                            : CupertinoActivityIndicator(),
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/image/not.jpg'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10,
                                    right: 15,
                                  ),
                                  child: Text(
                                    movie.title.toString().toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ]),
                        );
                      }),
                      options: CarouselOptions(
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 5),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        pauseAutoPlayOnTouch: true,
                        viewportFraction: 0.8,
                        enlargeCenterPage: true,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      child: Category(),
                    ),
                  ],
                );
              } else {
                // errorตอนดึง
                return Container(child: Text('ดึงไม่ได้'));
              }
            },
          )
        ]),
      ));
    });
  }
}
