import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';

import '../../domain/constants.dart';
import '../models/book/add_book_to_download_list.dart';
import '../models/book/book_request_body.dart';
import '../models/book/books.dart';
import '../models/book/borrow_books.dart';
import '../models/book/current_book_count.dart';
import '../models/book/download_books.dart';
import '../models/book/expired_books.dart';
import '../models/book_categories/book_categories.dart';
import '../models/book_categories/books_by_category.dart';
import '../models/book_categories/books_by_category_request_body.dart';
import '../models/login/login_request.dart';
import '../models/login/login_response.dart';
import '../models/order/order_list.dart';
import '../models/order/order_request_body.dart';
import '../models/order/order_response.dart';
import '../models/pending/pending.dart';
import '../models/search/search.dart';
import '../models/video/video_response.dart';

part 'api_service.g.dart';

const String daweiUrl = 'http://dlms.ucsdawei.edu.mm';

@RestApi(baseUrl: null)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static ApiService create() {
    final dio = Dio();
    // dio.options = BaseOptions(baseUrl: StorageUtils.getString("url"));
    dio.options = BaseOptions(baseUrl: daweiUrl);
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90),
      );
    }

    return ApiService(dio);
  }

  @POST("/api/login")
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

  @GET("/api/$kAPIVERSION/book-categories")
  Future<BookCategories> getBookCategories(
      @Header("Authorization") String bearerToken);

  @POST("/api/$kAPIVERSION/search")
  Future<Books> searchBooks(
    @Header("Authorization") String bearerToken,
    @Body() Search search,
  );

  // စာအုပ်များ
  @GET("/api/$kAPIVERSION/books")
  Future<Books> getAllBooks(
    @Query("page") int pageNumber,
    @Header("Authorization") String bearerToken,
  );

  @POST("/api/$kAPIVERSION/bookwithtype/{id}")
  Future<Books> getBooksByType(
    @Path("id") int bookWithType,
    @Query("page") int pageNumber,
    @Header("Authorization") String bearerToken,
  );

  @POST("/api/$kAPIVERSION/bookbycategory")
  Future<BooksByCategory> getBooksByCategory(
    @Header("Authorization") String bearerToken,
    @Body() BooksByCategoryRequestBody booksByCategoryRequestBody,
  );

  // order တင်  <<<<<<<-----------
  @POST("/api/$kAPIVERSION/order")
  Future<OrderResponse> orderBooks(@Header("Authorization") String bearerToken,
      @Body() OrderRequestBody orderRequestBody);

  @GET("/api/$kAPIVERSION/videos_by_category")
  Future<VideoResponse> getVideos(@Header("Authorization") String bearerToken,
      @Query("student_category_id") String sci);

  // download လုပ်ထားသောစာအုပ်
  @POST("/api/$kAPIVERSION/downloadbooklist")
  Future<DownloadBooks> getDownloadBooks(
    @Header("Authorization") String bearerToken,
    @Body() BookRequestBody bookRequestBody,
  );

  // ရက်ကျော်စာအုပ်
  @POST("/api/$kAPIVERSION/expiretoday")
  Future<ExpiredBooks> getExpiredBooks(
    @Header("Authorization") String bearerToken,
    @Body() BookRequestBody bookRequestBody,
  );

  // ငှားထားသောစာအုပ်
  @POST("/api/$kAPIVERSION/borrowedbook")
  Future<BorrowBookResponse> getBorrowedBooks(
    @Header("Authorization") String bearerToken,
    @Body() BookRequestBody bookRequestBody,
  );

  @POST("/api/$kAPIVERSION/pendinglist")
  Future<Pending> getPendingBooks(
    @Header("Authorization") String bearerToken,
    @Body() BookRequestBody bookRequestBody,
  );

  @POST("/api/$kAPIVERSION/orderbooklist") // <-- books
  Future<OrderListEntity> orderBookList(
    @Header("Authorization") String bearerToken,
    @Body() BookRequestBody bookRequestBody,
  );

  // order လုပ်ထားသောစာအုပ်
  @GET("/api/$kAPIVERSION/orderbooklist")
  Future<Books> getOrderBookList(
    @Header("Authorization") String bearerToken,
    @Body() BookRequestBody bookRequestBody,
  );

  /// download လုပ်ရန်   <<<<-------
  @POST("/api/$kAPIVERSION/order")
  Future<OrderResponse> downloadBook(
    @Header("Authorization") String bearerToken,
    @Body() AddBookToDownloadList addBookToDownloadList,
  );

  @POST("/api/$kAPIVERSION/booklimit")
  Future<CurrentBookCount> getCurrentBookCount(
    @Header("Authorization") String bearerToken,
    @Body() BookRequestBody bookRequestBody,
  );
}
