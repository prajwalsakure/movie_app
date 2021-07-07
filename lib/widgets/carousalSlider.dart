import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/bloc/movie_list_bloc.dart';
import 'package:movies_app/models/movieDetails.dart';
import 'package:movies_app/models/movieList.dart';
import 'package:movies_app/models/movieListResponse.dart';
import 'package:movies_app/screens/detailsScreen.dart';

class carousalSliders extends StatefulWidget {
  @override
  _carousalSlidersState createState() => _carousalSlidersState();
}

class _carousalSlidersState extends State<carousalSliders> {
  @override
  void initState() {
    super.initState();
    movieListBloc..fetchMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieListResponse>(
      stream: movieListBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieListResponse> snapshot) {
        if (snapshot.hasData) {
          return _buildCarouselSlider(snapshot.data!);
        } else {
          return Center(child: Text("Please Do something"));
        }
      },
    );
  }

  Widget _buildCarouselSlider(MovieListResponse data) {
    List<Movie> movie = data.movies;

    if (movie.length == 0) {
      return Center(child: Text("Please Do something"));
    } else {
      return CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 16 / 9,
          viewportFraction: 0.43,
          enableInfiniteScroll: true,
          height: 300.0,
          autoPlay: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          // enlargeCenterPage: true,
        ),
        items: movie.take(8).toList().map((i) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetails(movie: i),
                    ),
                  );
                },
                child: Container(
                  child: Column(
                    children: [
                      Hero(
                        tag: i.id,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          // width: 160,
                          height: 250,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.cyanAccent,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w500" +
                                        i.poster),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 40,
                        child: Text(
                          i.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              );
              //
            },
          );
        }).toList(),
      );
    }
  }
}
