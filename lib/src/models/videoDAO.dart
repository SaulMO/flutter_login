class Video {
  int id;
  List<Result> results;

  Video({
    this.id,
    this.results,
  });
}

class Result {
  String id;
  String iso6391;
  String iso31661;
  String key;
  String name;
  String site;
  int size;
  String type;

  factory Result.fromJSON(Map<String, dynamic> json) {
    return Result(
      id: json["id"],
      iso6391: json["iso_639_1"],
      iso31661: json["iso_3166_1"],
      key: json["key"],
      name: json["name"],
      site: json["site"],
      size: json["size"],
      type: json["type"],
    );
  }

  Result({
    this.id,
    this.iso6391,
    this.iso31661,
    this.key,
    this.name,
    this.site,
    this.size,
    this.type,
  });
}

enum OriginalLanguage { EN, JA, FR, KO }
