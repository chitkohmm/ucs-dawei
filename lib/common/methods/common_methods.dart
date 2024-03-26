import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class CommonMethods {
  ///`[EMAIL Validation]`
  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Email is required";
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return "Invalid email";
    }
    return null;
  }

  ///`[PASSWORD Validation]`
  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must contain at least 6 characters";
    }
    return null;
  }

  ///`[URL Validation]`
  static String? validateURL(String? value) {
    if (value!.isEmpty) {
      return "Please fill URL";
    }
    return null;
  }

  ///`[CUSTOM SNACKBAR CONTENT]`
  static SnackBar buildSnackBarWidget({
    required String message,
    required ContentType contentType,
    String title = 'On Snap!',
  }) {
    return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),
    );
  }

  ///[CUSTOM NAVIGATION ANIMATION]
  static Route createRoute({required Widget page}) {
    return PageRouteBuilder(
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) =>
          page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeIn).animate(animation),
          child: child,
        );
      },
    );
  }

  ///[Generate Video Thumbnail]
  static Future<String?> generateThumbnail(String videoFile) async {
    String? thumbnail = await VideoThumbnail.thumbnailFile(
      video: videoFile,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
      maxHeight: 150,
      quality: 100,
    );

    return thumbnail;
  }

  static Future<File> downloadPDF(
      {required String fileName, required String fileUrl}) async {
    debugPrint('PDF download $fileUrl');

    var response = await http.get(Uri.parse(fileUrl));

    var filePath = '${(await getTemporaryDirectory()).path}/$fileName';
    File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  static Future<File> downloadPhoto(String url, String fileName) async {
    var response = await http.get(Uri.parse(url));
    var filePath = '${(await getTemporaryDirectory()).path}/$fileName.png';

    debugPrint('Photo download $url');

    File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }
}
