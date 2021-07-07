import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_app/bloc/movies_by_genre.dart';
import 'package:movies_app/models/movieList.dart';
import 'package:movies_app/models/movieListResponse.dart';
import 'package:movies_app/screens/detailsScreen.dart';

class GenreMovies extends StatefulWidget {
  final int genreId;
  GenreMovies({Key? key, required this.genreId}) : super(key: key);
  @override
  _GenreMoviesState createState() => _GenreMoviesState(genreId);
}

class _GenreMoviesState extends State<GenreMovies> {
  final int genreId;
  _GenreMoviesState(this.genreId);
  @override
  void initState() {
    super.initState();
    movieListByGenreBloc..getMoviesByGenre(genreId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieListResponse>(
        stream: movieListByGenreBloc.subject.stream,
        builder: (context, AsyncSnapshot<MovieListResponse> snapshot) {
          if (snapshot.hasData) {
            return _buildMainWidget(snapshot.data!);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _buildMainWidget(MovieListResponse data) {
    List<Movie> movies = data.movies;
    return Container(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MovieDetails(movie: movies[index])));
                        },
                        child: Card(
                          elevation: 2,
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width / 2.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8)),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "https://image.tmdb.org/t/p/w500" +
                                                movies[index].poster))),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                height: 100,
                                width: MediaQuery.of(context).size.width / 2.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(movies[index].title,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: true),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Container(
                                      width: 172,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RatingBarIndicator(
                                                rating:
                                                    movies[index].rating / 2,
                                                itemBuilder: (context, index) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.lightBlue,
                                                ),
                                                itemCount: 5,
                                                itemSize: 16.0,
                                                direction: Axis.horizontal,
                                              ),
                                              Text(
                                                "2.4k reviews",
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Container(child: Text("this is it"))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
