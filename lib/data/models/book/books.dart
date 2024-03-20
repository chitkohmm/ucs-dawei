import '../meta.dart';

/// data : [{"id":4,"location_id":1,"floor":"1","row_no":"1","column_no":"1","shelf_id":1,"book_cover":"","limit_qty":1000,"status":"0","reading_duration":10,"bookname":"Head First PHP & MySQL","author_name":"Lynn Beighley and Michael Morrison","description":"If you're ready to create web pages more complex than those you can build with HTML and CSS, Head First PHP & MySQL is the ultimate learning guide to building dynamic, database-driven websites using PHP and MySQL. Packed with real-world examples, this book teaches you all the essentials of server-side programming, from the fundamentals of PHP and MySQL coding to advanced topics such as form validation, session IDs, cookies, database queries and joins, file I/O operations, content management, and more.","isbn_code":"1234","qty":1000,"book_type_id":4,"numberofpages":"250","edition":"1st","issue_date":"2023-02-08T00:00:00.000000Z","bookfile":[{"id":1,"original_url":"https://lib-ms.hmmdemo.net/storage/1/63e31e683a9e9_crap.jpeg"}],"book_type":{"id":4,"category":"PHP"},"location":{"id":1,"address":"7064 Langworth Motorway\nAltenwerthfort, MS 19644"},"shelf":{"id":1,"address":"24160 Jamarcus Inlet Suite 611\nKeeblerhaven, CT 25052"}}]

class Books {
  Books({this.data, this.meta});

  Books.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Book.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  List<Book>? data;
  Meta? meta;

  Books copyWith({List<Book>? data, Meta? meta}) => Books(
        data: data ?? this.data,
        meta: meta ?? this.meta,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      map['meta'] = meta?.toJson();
    }
    return map;
  }
}

/// id : 4
/// location_id : 1
/// floor : "1"
/// row_no : "1"
/// column_no : "1"
/// shelf_id : 1
/// book_cover : ""
/// limit_qty : 1000
/// status : "0"
/// reading_duration : 10
/// bookname : "Head First PHP & MySQL"
/// author_name : "Lynn Beighley and Michael Morrison"
/// description : "If you're ready to create web pages more complex than those you can build with HTML and CSS, Head First PHP & MySQL is the ultimate learning guide to building dynamic, database-driven websites using PHP and MySQL. Packed with real-world examples, this book teaches you all the essentials of server-side programming, from the fundamentals of PHP and MySQL coding to advanced topics such as form validation, session IDs, cookies, database queries and joins, file I/O operations, content management, and more."
/// isbn_code : "1234"
/// qty : 1000
/// book_type_id : 4
/// numberofpages : "250"
/// edition : "1st"
/// issue_date : "2023-02-08T00:00:00.000000Z"
/// bookfile : [{"id":1,"original_url":"https://lib-ms.hmmdemo.net/storage/1/63e31e683a9e9_crap.jpeg"}]
/// book_type : {"id":4,"category":"PHP"}
/// location : {"id":1,"address":"7064 Langworth Motorway\nAltenwerthfort, MS 19644"}
/// shelf : {"id":1,"address":"24160 Jamarcus Inlet Suite 611\nKeeblerhaven, CT 25052"}

class Book {
  Book({
    this.id,
    this.locationId,
    this.floor,
    this.rowNo,
    this.columnNo,
    this.shelfId,
    this.bookCover,
    this.limitQty,
    this.status,
    this.readingDuration,
    this.bookname,
    this.authorName,
    this.description,
    this.isbnCode,
    this.qty,
    this.bookTypeId,
    this.checkLimitQty,
    this.numberofpages,
    this.edition,
    this.issueDate,
    this.bookfile,
    this.media,
    this.bookType,
    this.location,
    this.pivot,
    this.shelf,
    this.bookfileUrl,
  });

  Book.fromJson(dynamic json) {
    id = json['id'];
    locationId = json['location_id'];
    floor = json['floor'];
    rowNo = json['row_no'];
    columnNo = json['column_no'];
    shelfId = json['shelf_id'];
    bookCover = json['book_cover'];
    limitQty = json['limit_qty'];
    status = json['status'];
    readingDuration = json['reading_duration'];
    bookname = json['bookname'];
    authorName = json['author_name'];
    description = json['description'];
    isbnCode = json['isbn_code'];
    qty = json['qty'];
    checkLimitQty = json['check_limit_qty'];
    bookTypeId = json['book_type_id'];
    numberofpages = json['numberofpages'];
    edition = json['edition'];
    issueDate = json['issue_date'];
    if (json['bookfile'] != null) {
      bookfile = [];
      json['bookfile'].forEach((v) {
        bookfile?.add(Bookfile.fromJson(v));
      });
    }
    bookfileUrl = json["bookfile_url"];
    // bookfile = json['bookfile'] != null
    //     ? Bookfile.fromJson(json['bookfile'])
    //     : null;
    bookType =
        json['book_type'] != null ? BookType.fromJson(json['book_type']) : null;
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
    shelf = json['shelf'] != null ? Shelf.fromJson(json['shelf']) : null;
  }

  num? id;
  num? locationId;
  String? floor;
  String? rowNo;
  String? columnNo;
  num? shelfId;
  String? bookCover;
  num? limitQty;
  String? status;
  num? readingDuration;
  String? bookname;
  String? authorName;
  String? description;
  String? isbnCode;
  num? qty;
  num? checkLimitQty;
  num? bookTypeId;
  String? numberofpages;
  String? edition;
  String? issueDate;
  List<Bookfile>? bookfile;
  // Bookfile? bookfile;
  String? bookfileUrl;

  List<Media>? media;
  BookType? bookType;
  Location? location;
  Pivot? pivot;
  Shelf? shelf;

  Book copyWith({
    num? id,
    num? locationId,
    String? floor,
    String? rowNo,
    String? columnNo,
    num? shelfId,
    String? bookCover,
    num? limitQty,
    String? status,
    num? readingDuration,
    String? bookname,
    String? authorName,
    String? description,
    String? isbnCode,
    num? qty,
    num? checkLimitQty,
    num? bookTypeId,
    String? numberofpages,
    String? edition,
    String? issueDate,
    List<Bookfile>? bookfile,
    // Bookfile? bookfile,
    String? bookfileUrl,
    List<Media>? media,
    BookType? bookType,
    Location? location,
    Pivot? pivot,
    Shelf? shelf,
  }) =>
      Book(
        id: id ?? this.id,
        locationId: locationId ?? this.locationId,
        floor: floor ?? this.floor,
        rowNo: rowNo ?? this.rowNo,
        columnNo: columnNo ?? this.columnNo,
        shelfId: shelfId ?? this.shelfId,
        bookCover: bookCover ?? this.bookCover,
        limitQty: limitQty ?? this.limitQty,
        status: status ?? this.status,
        readingDuration: readingDuration ?? this.readingDuration,
        bookname: bookname ?? this.bookname,
        authorName: authorName ?? this.authorName,
        description: description ?? this.description,
        isbnCode: isbnCode ?? this.isbnCode,
        qty: qty ?? this.qty,
        checkLimitQty: checkLimitQty ?? this.checkLimitQty,
        bookTypeId: bookTypeId ?? this.bookTypeId,
        numberofpages: numberofpages ?? this.numberofpages,
        edition: edition ?? this.edition,
        issueDate: issueDate ?? this.issueDate,
        bookfile: bookfile ?? this.bookfile,
        bookfileUrl: bookfileUrl ?? this.bookfileUrl,
        media: media ?? this.media,
        bookType: bookType ?? this.bookType,
        location: location ?? this.location,
        pivot: pivot ?? this.pivot,
        shelf: shelf ?? this.shelf,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['location_id'] = locationId;
    map['floor'] = floor;
    map['row_no'] = rowNo;
    map['column_no'] = columnNo;
    map['shelf_id'] = shelfId;
    map['book_cover'] = bookCover;
    map['limit_qty'] = limitQty;
    map['status'] = status;
    map['reading_duration'] = readingDuration;
    map['bookname'] = bookname;
    map['author_name'] = authorName;
    map['description'] = description;
    map['isbn_code'] = isbnCode;
    map['qty'] = qty;
    map['check_limit_qty'] = checkLimitQty;
    map['book_type_id'] = bookTypeId;
    map['numberofpages'] = numberofpages;
    map['edition'] = edition;
    map['issue_date'] = issueDate;
    if (bookfile != null) {
      map['bookfile'] = bookfile?.map((v) => v.toJson()).toList();
    }
    map['bookfile_url'] = bookfileUrl;
    // if (bookfile != null) {
    //   map['bookfile'] = bookfile!.toJson();
    // }
    if (bookfile != null) {
      map['media'] = media?.map((v) => v.toJson()).toList();
    }
    if (bookType != null) {
      map['book_type'] = bookType?.toJson();
    }
    if (location != null) {
      map['location'] = location?.toJson();
    }
    if (location != null) {
      map['pivot'] = location?.toJson();
    }
    if (shelf != null) {
      map['shelf'] = shelf?.toJson();
    }
    return map;
  }
}

/// id : 1
/// address : "24160 Jamarcus Inlet Suite 611\nKeeblerhaven, CT 25052"

class Shelf {
  Shelf({
    this.id,
    this.address,
  });

  Shelf.fromJson(dynamic json) {
    id = json['id'];
    address = json['address'];
  }
  num? id;
  String? address;
  Shelf copyWith({
    num? id,
    String? address,
  }) =>
      Shelf(
        id: id ?? this.id,
        address: address ?? this.address,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['address'] = address;
    return map;
  }
}

/// id : 1
/// address : "7064 Langworth Motorway\nAltenwerthfort, MS 19644"

class Location {
  Location({
    this.id,
    this.address,
  });

  Location.fromJson(dynamic json) {
    id = json['id'];
    address = json['address'];
  }
  num? id;
  String? address;
  Location copyWith({
    num? id,
    String? address,
  }) =>
      Location(
        id: id ?? this.id,
        address: address ?? this.address,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['address'] = address;
    return map;
  }
}

/// pivot : {"issued_return_id":22,"book_id":5,"status":"0","issue_date":"2023-02-15","return_date":"2023-02-22"}

/// issued_return_id : 22
/// book_id : 5
/// status : "0"
/// issue_date : "2023-02-15"
/// return_date : "2023-02-22"

/// pivot : {"issued_return_id":19,"book_id":4,"status":"0","issue_date":"2023-02-01","return_date":"2023-02-07"}

/// issued_return_id : 19
/// book_id : 4
/// status : "0"
/// issue_date : "2023-02-01"
/// return_date : "2023-02-07"

class Pivot {
  Pivot({
    this.issuedReturnId,
    this.bookId,
    this.status,
    this.issueDate,
    this.returnDate,
  });

  Pivot.fromJson(dynamic json) {
    issuedReturnId = json['issued_return_id'];
    bookId = json['book_id'];
    status = json['status'];
    issueDate = json['issue_date'];
    returnDate = json['return_date'];
  }
  num? issuedReturnId;
  num? bookId;
  String? status;
  String? issueDate;
  String? returnDate;
  Pivot copyWith({
    num? issuedReturnId,
    num? bookId,
    String? status,
    String? issueDate,
    String? returnDate,
  }) =>
      Pivot(
        issuedReturnId: issuedReturnId ?? this.issuedReturnId,
        bookId: bookId ?? this.bookId,
        status: status ?? this.status,
        issueDate: issueDate ?? this.issueDate,
        returnDate: returnDate ?? this.returnDate,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['issued_return_id'] = issuedReturnId;
    map['book_id'] = bookId;
    map['status'] = status;
    map['issue_date'] = issueDate;
    map['return_date'] = returnDate;
    return map;
  }
}

/// id : 4
/// category : "PHP"

class BookType {
  BookType({
    this.id,
    this.category,
  });

  BookType.fromJson(dynamic json) {
    id = json['id'];
    category = json['category'];
  }
  num? id;
  String? category;
  BookType copyWith({
    num? id,
    String? category,
  }) =>
      BookType(
        id: id ?? this.id,
        category: category ?? this.category,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['category'] = category;
    return map;
  }
}

/// id : 1
/// original_url : "https://lib-ms.hmmdemo.net/storage/1/63e31e683a9e9_crap.jpeg"

class Bookfile {
  Bookfile({
    this.id,
    this.originalUrl,

    // this.bookfileUrl,  // <<- new
  });

  Bookfile.fromJson(dynamic json) {
    id = json['id'];
    originalUrl = json['original_url'];

    // bookfileUrl = json['bookfile_url'];  // <<- new
  }

  num? id;
  String? originalUrl;

  @override
  String toString() => 'Boofile id $id, original url : $originalUrl';

  // String? bookfileUrl;  // <<- new

  Bookfile copyWith({
    num? id,
    String? originalUrl,
    // String? bookfileUrl,  // <<- new
  }) =>
      Bookfile(
        id: id ?? this.id,
        originalUrl: originalUrl ?? this.originalUrl,
        // bookfileUrl: bookfileUrl ?? this.bookfileUrl,  // <<- new
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['original_url'] = originalUrl;
    // map['bookfile_url'] = bookfileUrl; // <<- new
    return map;
  }
}

class Media {
  Media({
    this.id,
    this.originalUrl,
  });

  Media.fromJson(dynamic json) {
    id = json['id'];
    originalUrl = json['original_url'];
  }
  num? id;
  String? originalUrl;
  Bookfile copyWith({
    num? id,
    String? originalUrl,
  }) =>
      Bookfile(
        id: id ?? this.id,
        originalUrl: originalUrl ?? this.originalUrl,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['original_url'] = originalUrl;
    return map;
  }
}
