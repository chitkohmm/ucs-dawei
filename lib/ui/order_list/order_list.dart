import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../data/blocs/order_list_bloc/order_list_bloc.dart';
import '../share/book_item.dart';
import '../share/empty_widget.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  void initState() {
    BlocProvider.of<OrderListBloc>(context).add(GetOrderListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Order Books",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocConsumer<OrderListBloc, OrderListState>(
        builder: (context, state) {
          if (state is OrderListLoadingState) {
            return const Center(
              child: SpinKitThreeBounce(
                size: 22,
                color: Color(0xFF5AE4A8),
              ),
            );
          }
          if (state is OrderListLoadedState) {
            return state.orderListResponse.data!.isNotEmpty
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 9 / 20,
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.orderListResponse.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return state.orderListResponse.data![index].bookTypeId !=
                              null
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: BookItem(
                                  name:
                                      '${state.orderListResponse.data![index].bookname}',
                                  authorName:
                                      '${state.orderListResponse.data![index].authorName}',
                                  photo:
                                      '${state.orderListResponse.data![index].bookCover}'),
                            )
                          : const SizedBox();
                    })
                : const EmptyWidget();
          }
          return const SizedBox();
        },
        listener: (context, state) {},
      ),
    );
  }
}
