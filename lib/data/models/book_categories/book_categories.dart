/// data : [{"id":4,"category":"PHP","image":{"original_url":"https://lib-ms.hmmdemo.net/storage/9/63e49e63e30f0_php.png"}}]

class BookCategories {
  BookCategories({
    this.data,
  });

  BookCategories.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BookCategoryData.fromJson(v));
      });
    }
  }
  List<BookCategoryData>? data;
  BookCategories copyWith({
    List<BookCategoryData>? data,
  }) =>
      BookCategories(
        data: data ?? this.data,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 4
/// category : "PHP"
/// image : {"original_url":"https://lib-ms.hmmdemo.net/storage/9/63e49e63e30f0_php.png"}

class BookCategoryData {
  BookCategoryData({
    this.id,
    this.category,
    this.image,
  });

  BookCategoryData.fromJson(dynamic json) {
    id = json['id'];
    category = json['category'];
    image = json['image'] != null ? CategoryCover.fromJson(json['image']) : null;
  }
  num? id;
  String? category;
  CategoryCover? image;
  BookCategoryData copyWith({
    num? id,
    String? category,
    CategoryCover? image,
  }) =>
      BookCategoryData(
        id: id ?? this.id,
        category: category ?? this.category,
        image: image ?? this.image,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['category'] = category;
    if (image != null) {
      map['image'] = image?.toJson();
    }
    return map;
  }
}

/// original_url : "https://lib-ms.hmmdemo.net/storage/9/63e49e63e30f0_php.png"

class CategoryCover {
  CategoryCover({
    this.originalUrl,
  });

  CategoryCover.fromJson(dynamic json) {
    originalUrl = json['url'];
  }

  String? originalUrl;

  CategoryCover copyWith({
    String? originalUrl,
  }) =>
      CategoryCover(
        originalUrl: originalUrl ?? this.originalUrl,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = originalUrl;
    return map;
  }

  @override
  String toString() {
    return 'Image originalUrl $originalUrl';
  }
}
