import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:libms_flutter/data/blocs/book_bloc/book_bloc.dart';
import 'package:libms_flutter/data/models/book/add_book_to_download_list.dart';
import 'package:libms_flutter/data/models/book/books.dart';
import 'package:libms_flutter/data/models/book/request_book.dart';
import 'package:libms_flutter/domain/storage_utils.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key, required this.book, required this.isDownloading});

  final Book book;
  final bool isDownloading;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
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
      child: isDownloading == true
          ? const SpinKitThreeBounce(
              color: Color(0xFF5AE4A8),
              size: 20,
            )
          : const Text("Download PDF"),
    );
  }
}
