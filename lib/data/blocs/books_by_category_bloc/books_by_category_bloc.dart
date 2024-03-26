import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../domain/storage_utils.dart';
import '../../models/book/books.dart';
import '../../models/book_categories/books_by_category.dart';
import '../../models/book_categories/books_by_category_request_body.dart';
import '../../network/api_service.dart';

part 'books_by_category_event.dart';
part 'books_by_category_state.dart';

class BooksByCategoryBloc
    extends Bloc<BooksByCategoryEvent, BooksByCategoryState> {
  final ApiService apiService;
  BooksByCategoryBloc({required this.apiService})
      : super(BooksByCategoryInitial()) {
    on<GetAllBooksByCategoryEvent>(_booksByCategory);
    on<FilterBooksEvent>(_filterBooks);
  }
  Future<void> _booksByCategory(
      GetAllBooksByCategoryEvent event, Emitter emit) async {
    emit(BooksByCategoryLoadingState());
    try {
      final response = await apiService.getBooksByCategory(
          "Bearer ${StorageUtils.getString("login_user")}",
          BooksByCategoryRequestBody(categoryId: event.id.toInt()));
      emit(BooksByCategoryLoadedState(booksByCategory: response));
    } on DioError catch (e) {
      debugPrint('$e');
      emit(BooksByCategoryErrorState());
    }
  }

  Future<void> _filterBooks(FilterBooksEvent event, Emitter emit) async {
    List<Book> filterList = [];
    emit(BooksByCategoryLoadingState());
    await Future.delayed(const Duration(seconds: 1), () {});
    if (event.status == "0") {
      for (var book in event.books) {
        if (book.status == "0" || book.status == "2") {
          filterList.add(book);
        }
      }
    } else if (event.status == "1") {
      for (var book in event.books) {
        if (book.status == "1" || book.status == '2') {
          filterList.add(book);
        }
      }
    }

    emit(BooksRefreshLoadedState(
      booksByCategory: BooksByCategory(data: filterList),
    ));
  }
}
