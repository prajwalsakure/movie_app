import 'package:flutter/material.dart';
import 'package:movies_app/models/genre.dart';
import 'package:movies_app/widgets/genreMovie.dart';

class GenreList extends StatefulWidget {
  final List<Genre> genres;
  GenreList({Key? key, required this.genres}) : super(key: key);
  @override
  _GenreListState createState() => _GenreListState(genres);
}

class _GenreListState extends State<GenreList>
    with SingleTickerProviderStateMixin {
  final List<Genre> genres;
  _GenreListState(this.genres);
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: genres.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {}
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 370.0,
        child: DefaultTabController(
          length: genres.length,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: AppBar(
                backgroundColor: Colors.white,
                bottom: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.redAccent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3.0,
                  unselectedLabelColor: Colors.blue,
                  labelColor: Colors.black,
                  isScrollable: true,
                  tabs: genres.map((Genre genre) {
                    return Container(
                        padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                        child: new Text(genre.name.toUpperCase(),
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            )));
                  }).toList(),
                ),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: genres.map((Genre genre) {
                return GenreMovies(
                  genreId: genre.id,
                );
              }).toList(),
            ),
          ),
        ));
  }
}
