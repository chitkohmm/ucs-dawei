import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../data/blocs/search_bloc/search_bloc.dart';
import '../../data/models/book/books.dart';
import '../../data/models/search/search.dart' as s;
import '../book_detail/book_detail.dart';
import '../share/book_item.dart';
import '../share/empty_widget.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final searchController = TextEditingController();
  @override
  void initState() {
    BlocProvider.of<SearchBloc>(context).add(SearchInitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    books.clear();
    super.dispose();
  }

  List<Book> books = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  spreadRadius: 1)
                            ],
                            borderRadius: BorderRadius.circular(12)),
                        child: TextFormField(
                          controller: searchController,
                          onEditingComplete: () {
                            if (searchController.text.isNotEmpty) {
                              FocusScope.of(context).unfocus();
                              BlocProvider.of<SearchBloc>(context).add(
                                  SearchBooksEvent(
                                      search: s.Search(
                                          searchItem: searchController.text)));
                            }
                          },
                          autofocus: true,
                          textInputAction: TextInputAction.search,
                          cursorColor: Colors.cyan,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            hintText: "by authors, names, category...",
                            enabledBorder: OutlineInputBorder(
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
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                BlocConsumer<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is SearchInitial) {
                      return const SizedBox();
                    }
                    if (state is SearchBooksLoadingState) {
                      return const Expanded(
                        child: Center(
                          child: SpinKitThreeBounce(
                            color: Color(0xFF5AE4A8),
                            size: 22,
                          ),
                        ),
                      );
                    }
                    if (state is SearchBooksLoadedState) {
                      books.clear();
                      books = [...state.books.data ?? []];
                      return books.isNotEmpty
                          ? Expanded(
                              child: GridView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 12),
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 9 / 19,
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                  ),
                                  itemCount: books.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ValidateStudent(
                                                        book: books[index])));
                                      },
                                      child: BookItem(
                                        name: '${books[index].bookname}',
                                        authorName:
                                            '${books[index].authorName}',
                                        photo: '${books[index].bookCover}',
                                      ),
                                    );
                                  }),
                            )
                          : const Expanded(
                              child: EmptyWidget(),
                            );
                    }
                    return const SizedBox();
                  },
                  listener: (context, state) {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
