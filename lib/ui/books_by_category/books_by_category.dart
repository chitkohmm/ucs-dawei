import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:libms_flutter/data/blocs/books_by_category_bloc/books_by_category_bloc.dart';
import 'package:libms_flutter/ui/book_detail/book_detail.dart';
import 'package:libms_flutter/ui/share/book_item.dart';

import '../../data/models/book/books.dart';

class BooksByCategory extends StatefulWidget {
  const BooksByCategory(
      {Key? key, required this.categoryName, required this.id})
      : super(key: key);
  final int id;
  final String categoryName;

  @override
  State<BooksByCategory> createState() => _BooksByCategoryState();
}

class _BooksByCategoryState extends State<BooksByCategory> {
  @override
  void initState() {
    BlocProvider.of<BooksByCategoryBloc>(context)
        .add(GetAllBooksByCategoryEvent(id: widget.id));
    super.initState();
  }

  List<Book> books = [];
  String status = "2";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.grey.shade700,
          ),
        ),
        title: Text(
          widget.categoryName,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(
              CupertinoIcons.slider_horizontal_3,
              color: Colors.grey.shade700,
            ),
            position: PopupMenuPosition.under,
            surfaceTintColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 2,
            onSelected: (int item) {
              setState(() {
                status = item.toString();
              });
              BlocProvider.of<BooksByCategoryBloc>(context)
                  .add(FilterBooksEvent(status: item.toString(), books: books));
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    children: [
                      status == "0"
                          ? const Icon(
                              Icons.radio_button_checked_rounded,
                              color: Color(0xFF5AE4A8),
                              size: 18,
                            )
                          : const Icon(
                              Icons.radio_button_unchecked_rounded,
                              color: Colors.black,
                              size: 18,
                            ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text("Soft Copy"),
                    ],
                  ),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: [
                      status == "1"
                          ? const Icon(
                              Icons.radio_button_checked_rounded,
                              color: Color(0xFF5AE4A8),
                              size: 18,
                            )
                          : const Icon(
                              Icons.radio_button_unchecked_rounded,
                              color: Colors.black,
                              size: 18,
                            ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text("Hard Copy"),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: BlocConsumer<BooksByCategoryBloc, BooksByCategoryState>(
        builder: (context, state) {
          if (state is BooksByCategoryLoadingState) {
            return const Center(
              child: SpinKitThreeBounce(
                color: Color(0xFF5AE4A8),
                size: 25,
              ),
            );
          }
          if (state is BooksByCategoryLoadedState) {
            books = [...state.booksByCategory.data ?? []];
            return state.booksByCategory.data!.isNotEmpty
                ? GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 30),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 9 / 20,
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: state.booksByCategory.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ValidateStudent(
                                      book:
                                          state.booksByCategory.data![index])));
                        },
                        child: BookItem(
                          name:
                              '${state.booksByCategory.data![index].bookname}',
                          authorName:
                              '${state.booksByCategory.data![index].authorName}',
                          photo:
                              '${state.booksByCategory.data![index].bookCover}',
                        ),
                      );
                    })
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/not_found.webp",
                          height: 180,
                        ),
                        const Align(
                          alignment: Alignment.bottomCenter,
                          child: Text("There is no related book."),
                        )
                      ],
                    ),
                  );
          }
          if (state is BooksRefreshLoadedState) {
            return state.booksByCategory.data!.isNotEmpty
                ? GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 9 / 18,
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: state.booksByCategory.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ValidateStudent(
                                      book:
                                          state.booksByCategory.data![index])));
                        },
                        child: BookItem(
                          name:
                              '${state.booksByCategory.data![index].bookname}',
                          authorName:
                              '${state.booksByCategory.data![index].authorName}',
                          photo:
                              '${state.booksByCategory.data![index].bookCover}',
                        ),
                      );
                    })
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/not_found.webp",
                          height: 180,
                        ),
                        const Align(
                          alignment: Alignment.bottomCenter,
                          child: Text("There is no related book."),
                        )
                      ],
                    ),
                  );
          }
          return const SizedBox();
        },
        listener: (context, state) {},
      ),
    );
  }
}
