class Playlist {
  final String id;
  final String name;
  final String image;
  final int bookCount;

  Playlist({
    required this.id,
    required this.name,
    required this.image,
    required this.bookCount,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      bookCount:
          (json['playlist_book'] as List).isNotEmpty
              ? (json['playlist_book'] as List)[0]['count'] ?? 0
              : 0,
    );
  }
}
