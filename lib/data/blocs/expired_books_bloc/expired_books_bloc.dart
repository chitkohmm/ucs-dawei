import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:libms_flutter/data/models/book/expired_books.dart';

import '../../../domain/storage_utils.dart';
import '../../models/book/book_request_body.dart';
import '../../network/api_service.dart';

part 'expired_books_event.dart';
part 'expired_books_state.dart';

class ExpiredBooksBloc extends Bloc<ExpiredBooksEvent, ExpiredBooksState> {
  final ApiService apiService;
  ExpiredBooksBloc({required this.apiService}) : super(ExpiredBooksInitial()) {
    on<GetExpiredBooksEvent>(_getExpiredBooks);
  }
  Future<void> _getExpiredBooks(
      GetExpiredBooksEvent event, Emitter emit) async {
    emit(ExpiredBooksLoadingState());
    try {
      final response = await apiService.getExpiredBooks(
          "Bearer ${StorageUtils.getString("login_user")}",
          BookRequestBody(
              userId: int.parse(StorageUtils.getString("user_id"))));
      emit(ExpiredBooksLoadedState(downloadBooks: response));
    } on DioError catch (e) {
      debugPrint('$e');
      emit(DownloadBooksErrorState());
    }
  }
}
