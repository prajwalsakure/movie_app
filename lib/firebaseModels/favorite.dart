
class Favorite {
  final int movieId;
  final String title;
  final String poster;

  Favorite({
    required this.movieId,
    required this.title,
    required this.poster,
  });
}

class FavoriteList {
  List<Favorite> favorites;
  FavoriteList(this.favorites);
}
