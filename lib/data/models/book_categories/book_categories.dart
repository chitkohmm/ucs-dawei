/// data : [{"id":4,"category":"PHP","image":{"original_url":"https://lib-ms.hmmdemo.net/storage/9/63e49e63e30f0_php.png"}}]

class BookCategories {
  BookCategories({
    this.data,
  });

  BookCategories.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? data;
  BookCategories copyWith({
    List<Data>? data,
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

class Data {
  Data({
    this.id,
    this.category,
    this.image,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    category = json['category'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
  }
  num? id;
  String? category;
  Image? image;
  Data copyWith({
    num? id,
    String? category,
    Image? image,
  }) =>
      Data(
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

class Image {
  Image({
    this.originalUrl,
  });

  Image.fromJson(dynamic json) {
    originalUrl = json['url'];
  }

  String? originalUrl;

  Image copyWith({
    String? originalUrl,
  }) =>
      Image(
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
