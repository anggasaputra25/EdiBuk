class Book {
  final String id;
  final String coverImage;
  final String title;
  final String body;
  final String audio;
  final String authorName;
  final String categoryId;

  Book({
    required this.id,
    required this.coverImage,
    required this.title,
    required this.body,
    required this.audio,
    required this.authorName,
    required this.categoryId,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      coverImage: json['cover_image'],
      title: json['title'],
      body: json['body'],
      audio: json['audio'],
      authorName: json['authors']['name'],
      categoryId: json['category_id'],
    );
  }
}
