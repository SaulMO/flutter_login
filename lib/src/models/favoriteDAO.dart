//"CREATE TABLE tbl_favoritas(id INTEGER PRIMARY KEY, posterPath text, backdropPath text, title text, adult integer, voteAverage numeric, overview text, releaseDate text, favorite integer)"
class FavoriteDAO {
  String posterPath;
  String backdropPath;
  String title;
  int adult;
  double voteAverage;
  String overview;
  String releaseDate;
  int favorite;
  String get getPosterPath => posterPath;

  set setPosterPath(String posterPath) => this.posterPath = posterPath;

  String get getBackdropPath => backdropPath;

  set setBackdropPath(String backdropPath) => this.backdropPath = backdropPath;

  String get getTitle => title;

  set setTitle(String title) => this.title = title;

  int get getAdult => adult;

  set setAdult(int adult) => this.adult = adult;

  double get getVoteAverage => voteAverage;

  set setVoteAverage(double voteAverage) => this.voteAverage = voteAverage;

  String get getOverview => overview;

  set setOverview(String overview) => this.overview = overview;

  String get getReleaseDate => releaseDate;

  set setReleaseDate(String releaseDate) => this.releaseDate = releaseDate;

  int get getFavorite => favorite;

  set setFavorite(int favorite) => this.favorite = favorite;

  FavoriteDAO(
      {this.posterPath,
      this.backdropPath,
      this.title,
      this.adult,
      this.voteAverage,
      this.overview,
      this.releaseDate,
      this.favorite});
  factory FavoriteDAO.fromJSON(Map<String, dynamic> map) {
    return FavoriteDAO(
        posterPath: map['posterPath'],
        backdropPath: map['backdropPath'],
        title: map['title'],
        adult: map['adult'],
        voteAverage: map['voteAverage'],
        overview: map['overview'],
        releaseDate: map['releaseDate'],
        favorite: map['favorite']);
  }
  Map<String, dynamic> toJSON() {
    return {
      "posterPath": posterPath,
      "backdropPath": backdropPath,
      "title": title,
      "adult": adult,
      "voteAverage": voteAverage,
      "overview": overview,
      "releaseDate": releaseDate,
      "favorite": favorite
    };
  }
}
