import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movies_app/bloc/search_bloc.dart';
import 'package:movies_app/models/movieDetails.dart';
import 'package:movies_app/models/movieList.dart';
import 'package:movies_app/models/searchResponse.dart';
import 'package:movies_app/screens/detailsScreen.dart';

class search extends StatefulWidget {
  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<search> {
  TextEditingController searchController = TextEditingController();
  Icon actionIcon = Icon(Icons.search);
  searchMovie(String movieName) {
    searchListBloc..searchMovieList(movieName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          autofocus: true,
          controller: searchController,
          decoration: InputDecoration(
              hintText: "Search Movies ...",
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  searchController.text = "";
                },
              )),

          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          onEditingComplete: () => searchMovie(searchController.text),

          // maxLength: 50,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              alignment: Alignment.centerRight,
              onPressed: () => searchMovie(searchController.text),
              icon: Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<SearchResponse>(
            stream: searchListBloc.subject.stream,
            builder: (context, AsyncSnapshot<SearchResponse> snapshot) {
              if (snapshot.hasData) {
                return _buildMainWidget(snapshot.data!);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}

Widget _buildMainWidget(SearchResponse body) {
  List<Movie> movies = body.movie;
  if (movies.length == 0) {
    return Center(child: CircularProgressIndicator());
  } else {
    return ListView.separated(
      separatorBuilder: (_, __) => Divider(
        height: 20,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetails(movie: movies[index]),
              ),
            );
          },
          child: Container(
            child: Row(
              children: [
                Text(
                  movies[index].title,
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  softWrap: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// class DataSearch extends SearchDelegate<String> {
//   final names = [
//     "Prajwal",
//     "Anuj",
//     "Aman",
//     "Sankey",
//     "Samyak",
//     "saurabh",
//     "Mayur"
//   ];

//   final recentNames = ["Anuj", "Prajwal", "Samyak"];
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//           icon: Icon(Icons.clear),
//           onPressed: () {
//             query = "";
//           })
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//         icon: AnimatedIcon(
//             icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
//         color: Colors.green,
//         onPressed: () {
//           close(context, '');
//         });
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     var name = names
//         .where(
//             (element) => element.toLowerCase().startsWith(query.toLowerCase()))
//         .firstWhere(
//             (element) => element.toLowerCase().contains(query.toLowerCase()));
//     return Center(
//       child: Container(
//         height: 100,
//         width: 100,
//         child: Card(
//           color: Colors.blueAccent,
//           child: Center(
//             child: Text("This is $name"),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggestionList = query.isEmpty
//         ? recentNames
//         : names
//             .where((element) =>
//                 element.toLowerCase().startsWith(query.toLowerCase()))
//             .toList();
//     return ListView.builder(
//       itemBuilder: (context, index) => ListTile(
//           contentPadding: EdgeInsets.all(7),
//           onTap: () {
//             // showResults(context);
//             // Navigator.of(context).pushNamed(Details.routeName);
//           },
//           leading: Image.network(
//               'https://m.media-amazon.com/images/M/MV5BMjMyNDkzMzI1OF5BMl5BanBnXkFtZTgwODcxODg5MjI@._V1_.jpg'),
//           title: RichText(
//               text: TextSpan(
//             text: suggestionList[index].substring(0, query.length),
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//             children: [
//               TextSpan(
//                   text: suggestionList[index].substring(query.length),
//                   style: TextStyle(color: Colors.grey))
//             ],
//           ))),
//       itemCount: suggestionList.length,
//     );
//   }
// }
