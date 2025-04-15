import 'package:edibuk/models/author.dart';
import 'package:edibuk/models/book.dart';
import 'package:edibuk/models/category.dart';
import 'package:edibuk/repositories/auth.dart';
import 'package:edibuk/repositories/author.dart';
import 'package:edibuk/repositories/book.dart';
import 'package:edibuk/repositories/category.dart';
import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final BookRepository _bookRepository = BookRepository();
  final AuthorRepository _authorRepository = AuthorRepository();
  final CategoryRepository _categoryRepository = CategoryRepository();

  List<Book> books = [];
  List<Author> authors = [];
  List<Category> categories = [];
  String? username;

  SearchViewModel() {
    loadSearchData();
  }

  Future<void> loadSearchData() async {
    username = await _authRepository.fetchUsername();
    books = await _bookRepository.fetchBooks();
    authors = await _authorRepository.fetchAuthors();
    categories = await _categoryRepository.fetchCategories();
    notifyListeners();
  }

  Book get emptyBook => Book(
    id: '',
    title: '',
    body: '',
    audio: '',
    authorName: '',
    coverImage: '',
    categoryId: '',
  );
}
