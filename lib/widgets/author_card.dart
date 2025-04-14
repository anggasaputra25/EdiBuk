import 'package:flutter/material.dart';
import 'package:edibuk/models/author.dart';

class AuthorList extends StatelessWidget {
  final List<Author> authors;

  const AuthorList({super.key, required this.authors});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: authors.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final author = authors[index];
          return Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(author.image ?? ''),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: 70,
                child: Text(
                  author.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
