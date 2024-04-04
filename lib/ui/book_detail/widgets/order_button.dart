
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:libms_flutter/data/blocs/book_bloc/book_bloc.dart';
import 'package:libms_flutter/data/models/book/books.dart';
import 'package:libms_flutter/data/models/order/order_request_body.dart';
import 'package:libms_flutter/domain/storage_utils.dart';

class OrderButton extends StatelessWidget {
  const OrderButton(
      {super.key, required this.book, required this.borrowDate, required this.returnDate});
  final Book book;
  final DateTime borrowDate, returnDate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (book.qty! <= 0 ||
            book.qty!.toInt() - book.checkLimitQty!.toInt() == 0) {
        } else {
          BlocProvider.of<BookBloc>(context).add(
            BorrowBookEvent(
              orderRequestBody: OrderRequestBody(
                userId: int.parse(
                  StorageUtils.getString("user_id"),
                ),
                books: OrderBook(
                    bookId: book.id!.toInt(),
                    status: "0",
                    issueDate: DateFormat("yyyy-MM-dd").format(
                      borrowDate,
                    ),
                    returnDate: DateFormat("yyyy-MM-dd").format(returnDate)),
              ),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: book.qty! <= 0 ||
                    book.qty!.toInt() - book.checkLimitQty!.toInt() == 0
                ? Colors.grey
                : const Color(0xFF5AE4A8)),
        child: Center(
          child: Text(book.qty! <= 0 ||
                  book.qty!.toInt() - book.checkLimitQty!.toInt() == 0
              ? "Unavailable"
              : "Order Now"),
        ),
      ),
    );
  }
}