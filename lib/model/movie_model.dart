class Movie {
  final int id;
  final String title;
  final String director;
  final String year;

  Movie({required this.id, required this.title, required this.director, required this.year});

  factory Movie.fromJson(Map<dynamic, dynamic> json) {
    return Movie(
      title: json['title'],
      director: json['director'],
      year: json['year'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'director': director,
      'year': year,
      'id': id,
    };
  }
}
