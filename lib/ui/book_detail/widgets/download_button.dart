
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:libms_flutter/data/blocs/book_bloc/book_bloc.dart';
import 'package:libms_flutter/data/models/book/add_book_to_download_list.dart';
import 'package:libms_flutter/data/models/book/books.dart';
import 'package:libms_flutter/data/models/book/request_book.dart';
import 'package:libms_flutter/domain/storage_utils.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({super.key, required this.book, required this.isDownloading});

  final Book book;
  final bool isDownloading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (book.bookfile != null) {
          BlocProvider.of<BookBloc>(context).add(
            DownloadBookEvent(
              addBookToDownloadList: AddBookToDownloadList(
                userId: int.parse(
                  StorageUtils.getString("user_id"),
                ),
                status: "3",
                books: BookObject(
                  bookId: book.id.toString(),
                ),
              ),
            ),
          );
        } else {
          Fluttertoast.showToast(msg: "Sorry there is no related book file");
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF5AE4A8)),
        child: isDownloading == true
            ? Center(
                child: SpinKitThreeBounce(
                  color: Colors.grey.shade900,
                  size: 20,
                ),
              )
            : const Center(
                child: Text("Download"),
              ),
      ),
    );
  }
}