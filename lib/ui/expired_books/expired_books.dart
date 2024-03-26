import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../data/blocs/expired_books_bloc/expired_books_bloc.dart';
import '../share/empty_widget.dart';
import '../share/horizontal_book_card.dart';

class ExpiredBooks extends StatefulWidget {
  const ExpiredBooks({Key? key}) : super(key: key);

  @override
  State<ExpiredBooks> createState() => _ExpiredBooksState();
}

class _ExpiredBooksState extends State<ExpiredBooks> {
  @override
  void initState() {
    BlocProvider.of<ExpiredBooksBloc>(context).add(GetExpiredBooksEvent());
    super.initState();
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
          "Expired Books",
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<ExpiredBooksBloc, ExpiredBooksState>(
        builder: (context, state) {
          if (state is ExpiredBooksLoadingState) {
            return const Center(
              child: SpinKitThreeBounce(
                size: 20,
                color: Color(0xFF5AE4A8),
              ),
            );
          }
          if (state is ExpiredBooksLoadedState) {
            return state.downloadBooks.data!.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.downloadBooks.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: state.downloadBooks.data!.isNotEmpty
                            ? HorizontalBookCard(
                                name:
                                    '${state.downloadBooks.data![index].bookinfo!.bookname}',
                                authorName:
                                    '${state.downloadBooks.data![index].bookinfo!.authorName}',
                                bookCover:
                                    '${state.downloadBooks.data![index].bookinfo!.bookCover}',
                                expiredDay:
                                    '${state.downloadBooks.data![index].expiredDay}',
                              )
                            : const SizedBox(),
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
