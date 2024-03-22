import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:libms_flutter/data/network/api_service.dart';

import '../../data/blocs/home_bloc/home_bloc.dart';
import '../../domain/constants.dart';
import '../../domain/storage_utils.dart';
import '../book_detail/book_detail.dart';
import '../books_by_category/books_by_category.dart';
import '../bottom_nav_bar/bottom_nav_bar.dart';
import '../search/search.dart';
import '../share/book_item.dart';
import '../splash/splash.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(StartApiCallEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final baseUrl = StorageUtils.getString("url");

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: BlocConsumer<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoadingState) {
                return const Center(
                  child: SpinKitThreeBounce(
                    color: Color(0xFF5AE4A8),
                    size: 22,
                  ),
                );
              }

              if (state is HomeLoadedState) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Row(
                        children: [
                          const Text(
                            "Welcome to Library",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Image.asset("assets/images/library.png"),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Search(),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  spreadRadius: 1)
                            ],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            enabled: false,
                            cursorColor: Colors.cyan,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey.shade700,
                              ),
                              hintText: "Search books",
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Book Categories",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              height: kDeviceHeight(context) * 0.02,
                            ),
                            SizedBox(
                              height: kDeviceHeight(context) / 4,
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                    state.bookCategories.data!.length,
                                    (index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BooksByCategory(
                                                  categoryName: state
                                                      .bookCategories
                                                      .data![index]
                                                      .category
                                                      .toString(),
                                                  id: state.bookCategories
                                                      .data![index].id!
                                                      .toInt(),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                height:
                                                    kDeviceHeight(context) / 5,
                                                width:
                                                    kDeviceWidth(context) / 3.5,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      blurRadius: 4,
                                                      spreadRadius: 1,
                                                      color: Colors.black12,
                                                    )
                                                  ],
                                                ),
                                                child: Center(
                                                  child: CachedNetworkImage(
                                                    imageUrl: state
                                                                .bookCategories
                                                                .data![index]
                                                                .image !=
                                                            null
                                                        ?

                                                        ///use this for [UCS Dawei]
                                                        // "$daweiUrl${state.bookCategories.data![index].image!.originalUrl}"

                                                        ///use this for [UDNR SGG]
                                                        "${state.bookCategories.data![index].image!.originalUrl}"
                                                        : "",
                                                    fit: BoxFit.fitHeight,
                                                    errorWidget:
                                                        (context, _, dynamic) {
                                                      return Container(
                                                        color: Colors
                                                            .grey.shade400,
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                              ),
                                              Text(
                                                state.bookCategories
                                                    .data![index].category
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Books in Library",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              height: kDeviceHeight(context) * 0.02,
                            ),
                            GridView.builder(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 12),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 9 / 19,
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                                itemCount: _evaluateBooksLength(
                                    state.books.data!.length),
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ValidateStudent(
                                                      book: state.books
                                                          .data![index])));
                                    },
                                    child: BookItem(
                                      name: state.books.data![index].bookname
                                          .toString(),
                                      authorName: state
                                          .books.data![index].authorName
                                          .toString(),
                                      photo: state.books.data![index].bookCover
                                          .toString(),
                                    ),
                                  );
                                }),
                            SizedBox(
                              height: kDeviceHeight(context) * 0.02,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  kGoToNextAndRemove(
                                      context,
                                      const BottomNavBar(
                                        index: 2,
                                      ));
                                },
                                child: Container(
                                  width: 120,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF5AE4A8),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                    child: Text("Load More"),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: kDeviceHeight(context) * 0.02,
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                );
              }
              return const SizedBox();
            },
            listener: (context, state) {
              if (state is HomeErrorState) {
                if (state.statusCode == 401 ||
                    state.statusCode == 403 ||
                    state.statusCode == 500) {
                  StorageUtils.clear();
                  kGoToNextAndRemove(context, const Splash());
                }
              }
            },
          ),
        ),
      ),
    );
  }

  int _evaluateBooksLength(int length) {
    if (length > 6) {
      return 6;
    } else {
      return length;
    }
  }
}

///create state
///init
///didchangedependenc
///build
///didupdateidget
///dispose
///deactivate