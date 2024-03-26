import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libms_flutter/utils/extensions.dart';

import '../../data/blocs/download_books_bloc/download_books_bloc.dart';
import '../../data/models/book_file.dart';
import '../../data/network/sqlite_client.dart';
import '../../domain/constants.dart';
import '../download_detail/download_detail.dart';
import '../share/book_item.dart';
import '../share/empty_widget.dart';

class DownloadBooks extends StatefulWidget {
  const DownloadBooks({Key? key}) : super(key: key);

  @override
  State<DownloadBooks> createState() => _DownloadBooksState();
}

class _DownloadBooksState extends State<DownloadBooks> {
  late Future<List<BookFile>> _booksFuture;

  @override
  void initState() {
    _booksFuture = SqliteClient.getBookFile();
    BlocProvider.of<DownloadBooksBloc>(context).add(GetDownloadBooksEvent());
    super.initState();
  }

  void _deleteBook(int bookId) async {
    int deleted = await SqliteClient.deleteBook(bookId);
    if (deleted > 0) {
      // Book deleted successfully, update the UI by reloading the books
      setState(() {
        _booksFuture = SqliteClient.getBookFile();
      });
    }
  }

  void _removeAllBooks() async {
    int deleteAll = await SqliteClient.removeAllBooks();
    if (deleteAll > 0) {
      // Book deleted successfully, update the UI by reloading the books
      setState(() {
        _booksFuture = SqliteClient.getBookFile();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BookFile>>(
        future: _booksFuture,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              elevation: 0,
              backgroundColor: Colors.white,
              title: const Text(
                "Downloaded Books",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
              actions: [
                snapshot.hasData &&
                        snapshot.data!.isNotEmpty &&
                        snapshot.data!.length > 1
                    ? IconButton(
                        onPressed: () async {
                          await showDeleteAlert(context).then(
                            (value) {
                              if (!value) return;
                              _removeAllBooks();
                            },
                          );
                        },
                        icon: const Icon(CupertinoIcons.delete),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            body: snapshot.hasData
                ? snapshot.data!.isEmpty
                    ? const EmptyWidget()
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 9 / 20,
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 15),
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return snapshot.data![index].filePath != null
                              ? GestureDetector(
                                  onTap: () async {
                                    kGoToNext(
                                      context,
                                      DownloadDetail(
                                        url:
                                            '${snapshot.data![index].filePath}',
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 12.0),
                                    child: BookItem(
                                      name: '${snapshot.data![index].bookName}',
                                      authorName:
                                          '${snapshot.data![index].author}',
                                      isLocal: true,
                                      photo: '${snapshot.data![index].cover}',
                                      onDelete: () {
                                        _deleteBook(
                                            snapshot.data![index].bookId ?? 0);
                                      },
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink();
                        },
                      )
                : const SizedBox.shrink(),
          );
        });
  }

  Future<dynamic> showDeleteAlert(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: Text(
            'Are you sure to remove all books?',
            style: TextStyle(fontSize: context.wp(5)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Remove',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
