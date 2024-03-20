import 'dart:async';

import 'package:flutter/material.dart';

import '../../common/widgets/widgets.dart';
import '../../domain/constants.dart';
import '../../domain/storage_utils.dart';
import '../../utils/extensions.dart';
import '../api_link.dart';
import '../bottom_nav_bar/bottom_nav_bar.dart';
import '../login/login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late Timer timer;

  @override
  void initState() {
    timer = Timer(const Duration(seconds: 3), () {
      // if (StorageUtils.getString("login_user") != "") {
      //   kGoToNextAndRemove(
      //       context,
      //       const BottomNavBar(
      //         index: 0,
      //       ));
      // } else {
      //   kGoToNextAndRemove(context, Login());
      // }
      if (StorageUtils.getString("url") != "") {
        if (StorageUtils.getString("login_user") != "") {
          kGoToNextAndRemove(
              context,
              const BottomNavBar(
                index: 0,
              ));
        } else {
          kGoToNextAndRemove(context, Login());
        }
      } else {
        kGoToNextAndRemove(context, const APILink());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SizedBox(
          width: context.wp(100),
          child: Stack(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        "assets/images/shape.png",
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(
                              height: context.wp(20),
                            ),
                            Image.asset(
                              // "assets/images/udnr_logo.png",
                              "assets/images/ucs_dawei.png",
                              height: context.wp(35),
                            ),
                            SizedBox(
                              height: context.wp(5),
                            ),
                            const Text(
                              "E Library Management System",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Image.asset(
                    "assets/images/studying.png",
                    height: context.wp(60),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "UNDR-SGG",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
