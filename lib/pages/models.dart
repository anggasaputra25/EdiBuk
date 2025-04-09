class Book {  
  final String id;  
  final String coverImage;  
  final String title;  
  final String body;  
  final String audio;  
  final String authorId;
  final String categoryId;

  Book({  
    required this.id,  
    required this.coverImage,  
    required this.title,  
    required this.body,  
    required this.audio,  
    required this.authorId,  
    required this.categoryId,  
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],  
      coverImage: json['cover_image'],
      title: json['title'],
      body: json['body'],
      audio: json['audio'],
      authorId: json['author_id'],
      categoryId: json['category_id'],
    );
  }
}
class Author {
  final String id;
  final String name;
  final String image;

  Author({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
class Category {
  final String id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}

class UserProfile {
  final String id;
  final String username;
  final String? profileImage;

  UserProfile({
    required this.id,
    required this.username,
    this.profileImage,
  });
}
