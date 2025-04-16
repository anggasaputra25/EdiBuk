class Author {
  final String id;
  final String name;
  final String image;

  Author({required this.id, required this.name, required this.image});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(id: json['id'], name: json['name'], image: json['image']);
  }
}