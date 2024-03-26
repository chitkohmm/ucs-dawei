import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../domain/storage_utils.dart';
import '../../models/book/book_request_body.dart';
import '../../models/order/order_list.dart';
import '../../network/api_service.dart';

part 'order_list_event.dart';
part 'order_list_state.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  final ApiService apiService;
  OrderListBloc({required this.apiService}) : super(OrderListInitial()) {
    on<GetOrderListEvent>(_getOrderList);
  }
  Future<void> _getOrderList(GetOrderListEvent event, Emitter emit) async {
    emit(OrderListLoadingState());
    try {
      final response = await apiService.orderBookList(
          "Bearer ${StorageUtils.getString("login_user")}",
          BookRequestBody(
              userId: int.parse(StorageUtils.getString("user_id"))));
      emit(OrderListLoadedState(orderListResponse: response));
    } on DioError catch (e) {
      debugPrint('$e');
      emit(OrderListErrorState());
    }
  }
}
