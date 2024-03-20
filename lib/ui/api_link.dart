import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../common/methods/common_methods.dart';
import '../common/widgets/input_field.dart';
import '../common/widgets/screen_wrapper.dart';
import '../domain/storage_utils.dart';
import '../utils/extensions.dart';

const String title = "App URL Edit";
const String description = "";

class APILink extends StatefulWidget {
  const APILink({super.key});

  @override
  State<APILink> createState() => _APILinkState();
}

class _APILinkState extends State<APILink> {
  final TextEditingController urlController = TextEditingController();

  @override
  void initState() {
    urlController.text = StorageUtils.getString("url");
    super.initState();
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formkey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: context.hp(10),
                  ),
                  Image.asset(
                    // "assets/images/udnr_logo.png",
                    "assets/images/ucs_dawei.png",
                    height: context.hp(100) / 6,
                  ),
                  SizedBox(
                    height: context.hp(5),
                  ),
                  const Text(
                    "University of Computer Studies (Dawei)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "သင်အသုံးပြုရမည့် စာကြည့်တိုက်စနစ် URL ကိုထည့်သွင်းပါ။",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.hp(2),
                  ),
                  InputField(
                    controller: urlController,
                    validator: (value) => CommonMethods.validateURL(value),
                    hintText: '',
                    textInputType: TextInputType.url,
                  ),
                  SizedBox(
                    height: context.hp(2),
                  ),

                  Material(
                    color: const Color(0xFF5AE4A8),
                    child: InkWell(
                      splashColor: Colors.grey.shade200,
                      onTap: () {
                        // FocusManager.instance.primaryFocus?.unfocus();
                        FocusScope.of(context).unfocus();
                        if (_formkey.currentState!.validate()) {
                          StorageUtils.clear();
                          StorageUtils.setString("url", urlController.text);
                          Phoenix.rebirth(context);
                        }
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                            child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ),

                  // TextButton(
                  //     onPressed: () {
                  //       FocusScope.of(context).unfocus();
                  //       showDialog(
                  //           context: context,
                  //           builder: (context) => _buildIOSDialog());
                  //     },
                  //     child: const Text(
                  //       "Reset URL",
                  //       style: TextStyle(
                  //         color: Colors.green,
                  //         letterSpacing: .5,
                  //         fontWeight: FontWeight.w300,
                  //         fontSize: 14,
                  //       ),
                  //     ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIOSDialog() => CupertinoAlertDialog(
        title: const Text("Reset URL"),
        content: const Text("Set default value back."),
        actions: [
          TextButton(
              onPressed: () {
                // Phoenix.rebirth(context); // <-- Temp Disabled
                Navigator.pop(context);
              },
              child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Reset",
                style: TextStyle(color: Colors.indigo),
              )),
        ],
      );
}

class UrlChangeBtn extends StatelessWidget {
  const UrlChangeBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width / 2,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white.withOpacity(.7)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: const Center(
                  child: Text(
                "Change url",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: .2),
              )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10.0, right: 2),
            child: Icon(
              Icons.help,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
