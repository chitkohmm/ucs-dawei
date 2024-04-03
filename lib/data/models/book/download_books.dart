import 'package:libms_flutter/data/models/book/books.dart';

/// message : "success"
/// data : [{"id":5,"location_id":3,"floor":"1000","row_no":"1000","column_no":"1000","shelf_id":1,"book_cover":"https://lib-ms.hmmdemo.net/bookcovers/63e8faf1347deCOB5610.jpg","limit_qty":404,"status":"0","reading_duration":10,"bookname":"CSS Web Design","author_name":"Quail Mueller","description":null,"isbn_code":"10243343","qty":400,"book_type_id":2,"numberofpages":"492","edition":"First Edition","issue_date":"2023-02-12","bookfile":[{"id":6,"original_url":"https://lib-ms.hmmdemo.net/storage/6/63e8f57e483f0_Css-Web-Design-For-Dummies.pdf"}]}]

class DownloadBooks {
  DownloadBooks({
    this.message,
    this.data,
  });

  DownloadBooks.fromJson(dynamic json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Book.fromJson(v));
      });
    }
  }
  String? message;
  List<Book>? data;
  DownloadBooks copyWith({
    String? message,
    List<Book>? data,
  }) =>
      DownloadBooks(
        message: message ?? this.message,
        data: data ?? this.data,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 5
/// location_id : 3
/// floor : "1000"
/// row_no : "1000"
/// column_no : "1000"
/// shelf_id : 1
/// book_cover : "https://lib-ms.hmmdemo.net/bookcovers/63e8faf1347deCOB5610.jpg"
/// limit_qty : 404
/// status : "0"
/// reading_duration : 10
/// bookname : "CSS Web Design"
/// author_name : "Quail Mueller"
/// description : null
/// isbn_code : "10243343"
/// qty : 400
/// book_type_id : 2
/// numberofpages : "492"
/// edition : "First Edition"
/// issue_date : "2023-02-12"
/// bookfile : [{"id":6,"original_url":"https://lib-ms.hmmdemo.net/storage/6/63e8f57e483f0_Css-Web-Design-For-Dummies.pdf"}]

// class Data {
//   Data({
//     this.id,
//     this.locationId,
//     this.floor,
//     this.rowNo,
//     this.columnNo,
//     this.shelfId,
//     this.bookCover,
//     this.limitQty,
//     this.status,
//     this.readingDuration,
//     this.bookname,
//     this.authorName,
//     this.description,
//     this.isbnCode,
//     this.qty,
//     this.bookTypeId,
//     this.numberofpages,
//     this.edition,
//     this.issueDate,
//     this.bookfile,
//   });

//   Data.fromJson(dynamic json) {
//     id = json['id'];
//     locationId = json['location_id'];
//     floor = json['floor'];
//     rowNo = json['row_no'];
//     columnNo = json['column_no'];
//     shelfId = json['shelf_id'];
//     bookCover = json['book_cover'];
//     limitQty = json['limit_qty'];
//     status = json['status'];
//     readingDuration = json['reading_duration'];
//     bookname = json['bookname'];
//     authorName = json['author_name'];
//     description = json['description'];
//     isbnCode = json['isbn_code'];
//     qty = json['qty'];
//     bookTypeId = json['book_type_id'];
//     numberofpages = json['numberofpages'];
//     edition = json['edition'];
//     issueDate = json['issue_date'];
//     if (json['bookfile'] != null) {
//       bookfile = [];
//       json['bookfile'].forEach((v) {
//         bookfile?.add(Bookfile.fromJson(v));
//       });
//     }
//   }
//   num? id;
//   num? locationId;
//   String? floor;
//   String? rowNo;
//   String? columnNo;
//   num? shelfId;
//   String? bookCover;
//   num? limitQty;
//   String? status;
//   num? readingDuration;
//   String? bookname;
//   String? authorName;
//   dynamic description;
//   String? isbnCode;
//   num? qty;
//   num? bookTypeId;
//   String? numberofpages;
//   String? edition;
//   String? issueDate;
//   List<Bookfile>? bookfile;
//   Data copyWith({
//     num? id,
//     num? locationId,
//     String? floor,
//     String? rowNo,
//     String? columnNo,
//     num? shelfId,
//     String? bookCover,
//     num? limitQty,
//     String? status,
//     num? readingDuration,
//     String? bookname,
//     String? authorName,
//     dynamic description,
//     String? isbnCode,
//     num? qty,
//     num? bookTypeId,
//     String? numberofpages,
//     String? edition,
//     String? issueDate,
//     List<Bookfile>? bookfile,
//   }) =>
//       Data(
//         id: id ?? this.id,
//         locationId: locationId ?? this.locationId,
//         floor: floor ?? this.floor,
//         rowNo: rowNo ?? this.rowNo,
//         columnNo: columnNo ?? this.columnNo,
//         shelfId: shelfId ?? this.shelfId,
//         bookCover: bookCover ?? this.bookCover,
//         limitQty: limitQty ?? this.limitQty,
//         status: status ?? this.status,
//         readingDuration: readingDuration ?? this.readingDuration,
//         bookname: bookname ?? this.bookname,
//         authorName: authorName ?? this.authorName,
//         description: description ?? this.description,
//         isbnCode: isbnCode ?? this.isbnCode,
//         qty: qty ?? this.qty,
//         bookTypeId: bookTypeId ?? this.bookTypeId,
//         numberofpages: numberofpages ?? this.numberofpages,
//         edition: edition ?? this.edition,
//         issueDate: issueDate ?? this.issueDate,
//         bookfile: bookfile ?? this.bookfile,
//       );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['location_id'] = locationId;
//     map['floor'] = floor;
//     map['row_no'] = rowNo;
//     map['column_no'] = columnNo;
//     map['shelf_id'] = shelfId;
//     map['book_cover'] = bookCover;
//     map['limit_qty'] = limitQty;
//     map['status'] = status;
//     map['reading_duration'] = readingDuration;
//     map['bookname'] = bookname;
//     map['author_name'] = authorName;
//     map['description'] = description;
//     map['isbn_code'] = isbnCode;
//     map['qty'] = qty;
//     map['book_type_id'] = bookTypeId;
//     map['numberofpages'] = numberofpages;
//     map['edition'] = edition;
//     map['issue_date'] = issueDate;
//     if (bookfile != null) {
//       map['bookfile'] = bookfile?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }

/// id : 6
/// original_url : "https://lib-ms.hmmdemo.net/storage/6/63e8f57e483f0_Css-Web-Design-For-Dummies.pdf"

// class Bookfile {
//   Bookfile({
//     this.id,
//     this.originalUrl,
//   });

//   Bookfile.fromJson(dynamic json) {
//     id = json['id'];
//     originalUrl = json['original_url'];
//   }
//   num? id;
//   String? originalUrl;
//   Bookfile copyWith({
//     num? id,
//     String? originalUrl,
//   }) =>
//       Bookfile(
//         id: id ?? this.id,
//         originalUrl: originalUrl ?? this.originalUrl,
//       );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['original_url'] = originalUrl;
//     return map;
//   }
// }
