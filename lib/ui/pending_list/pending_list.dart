import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../data/blocs/pending_bloc/pending_bloc.dart';
import '../share/empty_widget.dart';

class PendingList extends StatefulWidget {
  const PendingList({Key? key}) : super(key: key);

  @override
  State<PendingList> createState() => _PendingListState();
}

class _PendingListState extends State<PendingList> {
  @override
  void initState() {
    BlocProvider.of<PendingBloc>(context).add(GetPendingBooksEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Pending Books",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocConsumer<PendingBloc, PendingState>(
        builder: (context, state) {
          if (state is PendingLoadingState) {
            return const Center(
              child: SpinKitThreeBounce(
                size: 22,
                color: Color(0xFF5AE4A8),
              ),
            );
          }
          if (state is PendingLoadedState) {
            return state.pendingList.data!.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.pendingList.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: state.pendingList.data![index].bookname != null
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height / 6,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 4,
                                            spreadRadius: 1)
                                      ]),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 85,
                                        height: 150,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              '${state.pendingList.data![index].bookCover}',
                                          errorWidget: (context, _, child) {
                                            return Container(
                                              color: Colors.grey.shade400,
                                            );
                                          },
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${state.pendingList.data![index].bookname}',
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              '${state.pendingList.data![index].authorName}',
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            // Text(
                                            //   left == "1" ? "$left day left" : "$left days left",
                                            //   style: const TextStyle(color: Colors.blue),
                                            // )
                                            const Text(
                                              "Unavailable",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      );
                    })
                : const EmptyWidget();
          }
          return const SizedBox();
        },
        listener: (context, state) {},
      ),
    );
  }
}
