import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../data/blocs/home_bloc/home_bloc.dart';
import '../../domain/constants.dart';
import '../../domain/storage_utils.dart';
import '../book_detail/book_detail.dart';
import '../share/book_item.dart';
import '../splash/splash.dart';
import 'widgets/widget.dart';

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
                    const HeaderSection(),
                    const CustomSearchBar(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            const TitleSection(sectionTitle: 'Book Categories'),
                            SizedBox(height: kDeviceHeight(context) * 0.02),
                            SizedBox(
                              height: kDeviceHeight(context) / 3.8,
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                    state.bookCategories.data!.length,
                                    (index) {
                                      return BookCategoryCard(
                                          bookCategoryData: state
                                              .bookCategories.data![index]);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const TitleSection(
                                sectionTitle: 'Books in Library'),
                            SizedBox(height: kDeviceHeight(context) * 0.02),
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
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ValidateStudent(
                                                    book: state
                                                        .books.data![index]))),
                                    child: BookItem(
                                      name:
                                          '${state.books.data![index].bookname}',
                                      authorName:
                                          '${state.books.data![index].authorName}',
                                      photo:
                                          '${state.books.data![index].bookCover}',
                                    ),
                                  );
                                }),
                            SizedBox(height: kDeviceHeight(context) * 0.02),
                            const LoadMoreButton(),
                            SizedBox(height: kDeviceHeight(context) * 0.02),
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
