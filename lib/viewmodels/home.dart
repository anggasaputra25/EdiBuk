import 'package:edibuk/models/author.dart';
import 'package:edibuk/models/book.dart';
import 'package:edibuk/repositories/auth.dart';
import 'package:edibuk/repositories/author.dart';
import 'package:edibuk/repositories/book.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final BookRepository _bookRepository = BookRepository();
  final AuthorRepository _authorRepository = AuthorRepository();

  List<Book> books = [];
  List<Author> authors = [];
  String? username;

  HomeViewModel() {
    loadHomeData();
  }

  Future<void> loadHomeData() async {
    username = await _authRepository.fetchUsername();
    books = await _bookRepository.fetchBooks();
    authors = await _authorRepository.fetchAuthors();
    notifyListeners();
  }
}
