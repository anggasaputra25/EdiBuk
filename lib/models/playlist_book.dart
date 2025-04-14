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
