import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movies_app/bloc/search_bloc.dart';
import 'package:movies_app/models/movieDetails.dart';
import 'package:movies_app/models/movieList.dart';
import 'package:movies_app/models/searchResponse.dart';
import 'package:movies_app/screens/detailsScreen.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechSearch extends StatefulWidget {
  @override
  _SpeechSearchState createState() => _SpeechSearchState();
}

class _SpeechSearchState extends State<SpeechSearch> {
  searchMovie(String movieName) {
    searchListBloc..searchMovieList(movieName);
  }

  late stt.SpeechToText _speech;
  bool _isListening = false;
  late String _text = "";
  double _confidence = 1.0;
  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _listen();
  }

  // search after 5 seconds
  _SpeechSearchState() {
    Timer(
        Duration(seconds: 5),
        () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VoiceSearchInit(mytext: _text))));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Text(
          _text,
          style: TextStyle(fontSize: 32, color: Colors.black),
        ),
      ),
    ));
  }

  //
  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
            onResult: (val) => setState(() {
                  _text = val.recognizedWords;
                  if (val.hasConfidenceRating && val.confidence > 0) {
                    _confidence = val.confidence;
                  }
                }));
      } else {
        setState(() => _isListening = false);
        _speech.stop();
      }
    }
  }
}

//new Statefull class for the search results

class VoiceSearchInit extends StatefulWidget {
  final String mytext;
  VoiceSearchInit({Key? key, required this.mytext}) : super(key: key);

  @override
  _VoiceSearchInitState createState() => _VoiceSearchInitState(mytext);
}

class _VoiceSearchInitState extends State<VoiceSearchInit> {
  final String mytext;

  _VoiceSearchInitState(this.mytext);

  searchMovie(String movie) {
    searchListBloc..searchMovieList(movie);
  }

  @override
  void initState() {
    super.initState();
    searchMovie(mytext);
    searchController = TextEditingController(text: mytext);
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          title: mytext == ""
              ? TextField(
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
                )
              : TextField(
                  // mytext, style: TextStyle(color: Colors.black),
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
