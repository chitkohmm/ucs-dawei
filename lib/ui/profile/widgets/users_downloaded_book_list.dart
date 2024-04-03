import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:libms_flutter/data/blocs/download_books_bloc/download_books_bloc.dart';
import 'package:libms_flutter/ui/book_detail/book_detail.dart';
import 'package:libms_flutter/ui/share/book_item.dart';
import 'package:libms_flutter/ui/share/empty_widget.dart';

class UserDownloadedBooksList extends StatefulWidget {
  const UserDownloadedBooksList({Key? key}) : super(key: key);

  @override
  State<UserDownloadedBooksList> createState() =>
      _UserDownloadedBooksListState();
}

class _UserDownloadedBooksListState extends State<UserDownloadedBooksList> {
  @override
  void initState() {
    BlocProvider.of<DownloadBooksBloc>(context).add(GetDownloadBooksEvent());

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
          "Downloaded Books",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocConsumer<DownloadBooksBloc, DownloadBooksState>(
        builder: (context, state) {
          if (state is DownloadBooksLoadingState) {
            return const Center(
              child: SpinKitThreeBounce(
                size: 22,
                color: Color(0xFF5AE4A8),
              ),
            );
          }
          if (state is DownloadBooksLoadedState) {
            return state.downloadBooks.data!.isNotEmpty
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
                    itemCount: state.downloadBooks.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return state.downloadBooks.data![index].bookTypeId != null
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BookDetail(
                                            book: state
                                                .downloadBooks.data![index])));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: BookItem(
                                    name:
                                        '${state.downloadBooks.data![index].bookname}',
                                    authorName:
                                        '${state.downloadBooks.data![index].authorName}',
                                    photo:
                                        '${state.downloadBooks.data![index].bookCover}'),
                              ),
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
