import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../data/blocs/home_bloc/home_bloc.dart';
import '../../data/models/book/books.dart';
import '../../domain/constants.dart';
import '../../domain/storage_utils.dart';
import '../book_detail/book_detail.dart';
import '../share/book_item.dart';
import '../share/empty_widget.dart';
import '../splash/splash.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  bool isLoaded = false;
  int currentPage = 1;
  String status = "2";
  int lastPage = 0;
  List<Book> currentBook = [];
  bool loadMore = false;

  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context)
        .add(GetAllBooksEvent(pageNumber: currentPage));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            "Books in Library",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
          actions: [
            PopupMenuButton(
              icon: Icon(
                Icons.filter_list,
                color: Colors.grey.shade700,
              ),
              position: PopupMenuPosition.under,
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 2,
              onSelected: (int item) {
                setState(() {
                  status = item.toString();
                });
                currentPage = 1;
                isLoaded = false;
                BlocProvider.of<HomeBloc>(context).add(GetBooksByTypeEvent(
                    status: item.toInt(), pageNumber: currentPage));

                currentBook.clear();
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
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeErrorState) {
              if (state.statusCode == 401 ||
                  state.statusCode == 403 ||
                  state.statusCode == 500) {
                StorageUtils.clear();
                kGoToNextAndRemove(context, const Splash());
              }
            }
            if (state is GetAllBooksLoadedState) {
              currentPage = state.books.meta!.currentPage!.toInt();
              lastPage = state.books.meta!.lastPage!.toInt();
              currentBook.clear();
              isLoaded = true;
              setState(() {
                currentBook.addAll(state.books.data!);
              });
            }
            if (state is GetBookByTypeLoadedState) {
              isLoaded = true;
              currentPage = state.books.meta!.currentPage!.toInt();
              lastPage = state.books.meta!.lastPage!.toInt();
              currentBook.clear();
              setState(() {
                currentBook.addAll(state.books.data!);
              });
            }

            if (state is BooksLoadMoreLoadedState) {
              loadMore = false;
              currentPage = state.books.meta!.currentPage!.toInt();
              List<Book> books = [];
              for (var book in state.books.data!) {
                books.add(book);
              }
              currentBook.addAll(books);
              setState(() {});
            }
            if (state is BooksByTypeLoadMoreLoadedState) {
              loadMore = false;
              currentPage = state.books.meta!.currentPage!.toInt();
              List<Book> books = [];
              for (var book in state.books.data!) {
                books.add(book);
              }
              currentBook.addAll(books);
              setState(() {});
            }
          },
          builder: (context, state) {
            return isLoaded == false
                ? const Center(
                    child: SpinKitThreeBounce(
                      color: Color(0xFF5AE4A8),
                      size: 22,
                    ),
                  )
                : currentBook.isEmpty
                    ? const EmptyWidget()
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            GridView.builder(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 9 / 19,
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                                itemCount: currentBook.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BookDetail(
                                                  book: currentBook[index])));
                                    },
                                    child: BookItem(
                                      name: '${currentBook[index].bookname}',
                                      authorName:
                                          '${currentBook[index].authorName}',
                                      photo: '${currentBook[index].bookCover}',
                                    ),
                                  );
                                }),
                            currentBook.length >= 20 && currentPage < lastPage
                                ? loadMore == true
                                    ? const Center(
                                        child: SpinKitThreeBounce(
                                          color: Color(0xFF5AE4A8),
                                          size: 22,
                                        ),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (currentPage <= lastPage) {
                                              setState(() {
                                                loadMore = true;
                                              });
                                              if (status == "0") {
                                                BlocProvider.of<HomeBloc>(
                                                        context)
                                                    .add(
                                                        GetMoreBooksByTypeEvent(
                                                  pageNumber: currentPage + 1,
                                                  status: 0,
                                                ));
                                              }
                                              if (status == "1") {
                                                BlocProvider.of<HomeBloc>(
                                                        context)
                                                    .add(
                                                        GetMoreBooksByTypeEvent(
                                                  pageNumber: currentPage + 1,
                                                  status: 1,
                                                ));
                                              }
                                              if (status == "2") {
                                                BlocProvider.of<HomeBloc>(
                                                        context)
                                                    .add(GetMoreBooksEvent(
                                                  pageNumber: currentPage + 1,
                                                ));
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: 120,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 12),
                                            decoration: BoxDecoration(
                                                color: const Color(0xFF5AE4A8),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: const Center(
                                              child: Text("Load More"),
                                            ),
                                          ),
                                        ),
                                      )
                                : const SizedBox(),
                          ],
                        ),
                      );
          },
        ));
  }
}
