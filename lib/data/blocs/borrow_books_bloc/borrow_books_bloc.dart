import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../domain/storage_utils.dart';
import '../../models/book/book_request_body.dart';
import '../../models/book/borrow_books.dart';
import '../../network/api_service.dart';

part 'borrow_books_event.dart';
part 'borrow_books_state.dart';

class BorrowBooksBloc extends Bloc<BorrowBooksEvent, BorrowBooksState> {
  final ApiService apiService;
  BorrowBooksBloc({required this.apiService}) : super(BorrowBooksInitial()) {
    on<GetAllBorrowBooksEvent>(_getBorrowBooks);
  }
  Future<void> _getBorrowBooks(
      GetAllBorrowBooksEvent event, Emitter emit) async {
    emit(BorrowBooksLoadingState());
    try {
      final response = await apiService.getBorrowedBooks(
          "Bearer ${StorageUtils.getString("login_user")}",
          BookRequestBody(
              userId: int.parse(StorageUtils.getString("user_id"))));
      emit(BorrowBooksLoadedState(borrowBooks: response));
    } on DioError catch (e) {
      debugPrint('$e');
      emit(BorrowBooksErrorState());
    }
  }
}
