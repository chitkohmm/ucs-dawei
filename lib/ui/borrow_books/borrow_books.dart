import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../data/blocs/borrow_books_bloc/borrow_books_bloc.dart';
import '../share/empty_widget.dart';
import 'widgets/borrow_book_card.dart';

class BorrowBooks extends StatefulWidget {
  const BorrowBooks({Key? key}) : super(key: key);
  @override
  State<BorrowBooks> createState() => _BorrowBooksState();
}

class _BorrowBooksState extends State<BorrowBooks> {
  @override
  void initState() {
    BlocProvider.of<BorrowBooksBloc>(context).add(GetAllBorrowBooksEvent());
    super.initState();
  }

  int _calculateLeftDays(String returnDateString) {
    DateTime returnDate = returnDateString == "null"
        ? DateTime.now()
        : DateTime.parse(returnDateString);

    DateTime currentDate = DateTime.now();
    Duration timeDiff = returnDate.difference(currentDate);
    return timeDiff.inDays;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        elevation: .8,
        shadowColor: Colors.black12,
        title: const Text(
          "Borrow Books",
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<BorrowBooksBloc, BorrowBooksState>(
        builder: (context, state) {
          if (state is BorrowBooksLoadingState) {
            return const Center(
              child: SpinKitThreeBounce(
                size: 22,
                color: Color(0xFF5AE4A8),
              ),
            );
          }
          if (state is BorrowBooksLoadedState) {
            return state.borrowBooks.data!.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.borrowBooks.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: state.borrowBooks.data![index].bookInfo!
                                      .bookname !=
                                  null
                              ? BorrowBookCard(
                                  bookName:
                                      '${state.borrowBooks.data![index].bookInfo!.bookname}',
                                  authorName: "",
                                  bookCover:
                                      '${state.borrowBooks.data![index].bookInfo!.bookCover}',
                                  left: _calculateLeftDays(state
                                          .borrowBooks.data![index].returnDate
                                          .toString())
                                      .toString(),
                                )
                              : const SizedBox(),
                        ),
                      );
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
