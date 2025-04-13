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

class Author {
  final String id;
  final String name;
  final String image;

  Author({required this.id, required this.name, required this.image});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(id: json['id'], name: json['name'], image: json['image']);
  }
}

class Category {
  final String id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], name: json['name']);
  }
}

class UserProfile {
  final String id;
  final String username;
  final String? profileImage;

  UserProfile({required this.id, required this.username, this.profileImage});
}

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
      bookCount: (json['playlist_book'] as Map<String, dynamic>)['count'] ?? 0,
    );
  }
}

class PlaylistBook {
  final String id;
  final String playlistId;
  final String bookId;

  PlaylistBook({
    required this.id,
    required this.playlistId,
    required this.bookId,
  });

  factory PlaylistBook.fromJson(Map<String, dynamic> json) {
    return PlaylistBook(
      id: json['id'],
      playlistId: json['playlist_id'],
      bookId: json['book_id'],
    );
  }
}
