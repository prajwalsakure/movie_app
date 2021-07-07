import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_app/bloc/movie_list_bloc.dart';
import 'package:movies_app/models/movieList.dart';
import 'package:movies_app/models/movieListResponse.dart';
import 'package:movies_app/screens/detailsScreen.dart';

class ViewAllScreen extends StatefulWidget {
  @override
  _ViewAllScreenState createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  @override
  void initState() {
    super.initState();
    movieListBloc..fetchMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Recommended movies",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 7,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
      ),
      body: SafeArea(
        child: StreamBuilder<MovieListResponse>(
          stream: movieListBloc.subject.stream,
          builder: (context, AsyncSnapshot<MovieListResponse> snapshot) {
            if (snapshot.hasData)
              return _buildList(snapshot.data!);
            else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildList(MovieListResponse data) {
    List<Movie> movies = data.movies;

    if (movies.length == 0) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Builder(builder: (BuildContext context) {
        return Container(
            child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MovieDetails(movie: movies[index]),
                        ),
                      );
                    },
                    child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 5),
                        child: Row(children: [
                          Hero(
                            tag: movies[index].id,
                            child: Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          "https://image.tmdb.org/t/p/w500" +
                                              movies[index].poster))),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            height: 150,
                            width: MediaQuery.of(context).size.width / 2.2,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(movies[index].title,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      softWrap: false),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      child: Text(movies[index].overview,
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          softWrap: true)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RatingBarIndicator(
                                            rating: movies[index].rating / 2,
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star,
                                              color: Colors.lightBlue,
                                            ),
                                            itemCount: 5,
                                            itemSize: 18.0,
                                            direction: Axis.horizontal,
                                          ),
                                          Text(movies[index].rating.toString())
                                        ]),
                                  )
                                ]),
                          ),
                        ])),
                  );
                }));
      });
    }
  }
}
