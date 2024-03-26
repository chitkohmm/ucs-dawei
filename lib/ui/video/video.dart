import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_phoenix/generated/i18n.dart'; // <-- Temp Disabled
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:libms_flutter/common/methods/common_methods.dart';
import 'package:libms_flutter/data/blocs/videos_bloc/videos_bloc.dart';
import 'package:libms_flutter/domain/storage_utils.dart';
import 'package:libms_flutter/ui/share/empty_widget.dart';
import 'package:libms_flutter/ui/video/video_detail.dart';

class Video extends StatefulWidget {
  const Video({super.key});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  void initState() {
    BlocProvider.of<VideosBloc>(context).add(GetVideosEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sci = int.parse(StorageUtils.getString('sci'));

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Videos",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocConsumer<VideosBloc, VideosState>(
        builder: (context, state) {
          if (state is VideosLoadingState) {
            return const Center(
              child: SpinKitThreeBounce(color: Color(0xFF5AE4A8), size: 22),
            );
          }
          if (state is VideosLoadedState) {
            if (state.videoResponse.data![sci - 1].videos?.isEmpty ?? true) {
              return const EmptyWidget(
                text: "There are no videos",
              );
            }

            return state.videoResponse.data!.isEmpty
                ? const EmptyWidget(
                    text: "There are no videos",
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.videoResponse.data!.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 12);
                      },
                      itemBuilder: (context, index) {
                        return state
                                .videoResponse.data![index].videos!.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${state.videoResponse.data![index].categoryName}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(height: 12),
                                  SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: List.generate(
                                        state.videoResponse.data![index].videos!
                                            .length,
                                        (i) {
                                          final videoItem = state.videoResponse
                                              .data?[index].videos?[i];

                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    String videoLink =
                                                        videoItem?.fileUpload ??
                                                            '';
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            VideoApp(
                                                          videoLink: videoLink,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 150,
                                                    width: 200,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.black12,
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        FutureBuilder<void>(
                                                          future: CommonMethods
                                                              .generateThumbnail(
                                                                  videoItem
                                                                          ?.fileUpload ??
                                                                      ''),
                                                          builder: (BuildContext
                                                                  context,
                                                              AsyncSnapshot<
                                                                      dynamic>
                                                                  snapshot) {
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .done) {
                                                              String?
                                                                  thumbnailUrl =
                                                                  snapshot.data;

                                                              return Positioned
                                                                  .fill(
                                                                      child: thumbnailUrl !=
                                                                              null
                                                                          ? Image
                                                                              .file(
                                                                              File(thumbnailUrl),
                                                                              fit: BoxFit.cover,
                                                                            )
                                                                          : Image.asset(
                                                                              'assets/images/ucs_dawei.png',
                                                                              fit: BoxFit.contain));
                                                            } else {
                                                              return Positioned.fill(
                                                                  child: Image.asset(
                                                                      'assets/images/ucs_dawei.png',
                                                                      fit: BoxFit
                                                                          .contain));
                                                            }
                                                          },
                                                        ),
                                                        const Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Icon(
                                                            CupertinoIcons
                                                                .play_arrow_solid,
                                                            color: Colors.white,
                                                            size: 40,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  '${videoItem?.name}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox();
                      },
                    ),
                  );
          }
          return const SizedBox();
        },
        listener: (context, state) {},
      ),
    );
  }
}
