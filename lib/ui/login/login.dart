import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../common/methods/common_methods.dart';
import '../../common/widgets/widgets.dart';
import '../../data/blocs/login_bloc/login_bloc.dart';
import '../../data/models/login/login_request.dart';
import '../../domain/constants.dart';
import '../../domain/storage_utils.dart';
import '../../utils/extensions.dart';
import '../bottom_nav_bar/bottom_nav_bar.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: context.wp(100),
            height: context.hp(100),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formState,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: context.wp(20),
                    ),
                    Image.asset(
                      "assets/images/ucs_dawei.png",
                      height: context.hp(100) / 4,
                    ),
                    SizedBox(
                      height: context.wp(5),
                    ),
                    const Text(
                      "University of Computer Studies (Dawei)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: context.hp(2),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context).email,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: context.hp(1),
                    ),
                    InputField(
                      controller: emailController,
                      validator: (value) => CommonMethods.validateEmail(value),
                      hintText: AppLocalizations.of(context).email,
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: context.hp(3),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context).password,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: context.hp(1),
                    ),
                    InputField(
                      controller: passwordController,
                      validator: (value) =>
                          CommonMethods.validatePassword(value),
                      hintText: AppLocalizations.of(context).password,
                      textInputType: TextInputType.text,
                      isPasswordField: true,
                    ),
                    SizedBox(
                      height: context.wp(8),
                    ),
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is LoginLoadedState) {
                          if (state.loginResponse.userInfo!.roles![0].title ==
                              "Student") {
                            debugPrint(
                                'LOGIN INFO ::: ${state.loginResponse.userInfo}');

                            debugPrint(
                                'LOGIN SCI ::: ${state.loginResponse.userInfo!.studentCategoryId}');

                            StorageUtils.setString(
                                "login_user", '${state.loginResponse.token}');
                            StorageUtils.setString("user_id",
                                '${state.loginResponse.userInfo!.id}');
                            StorageUtils.setString("sci",
                                '${state.loginResponse.userInfo!.studentCategoryId}');
                            StorageUtils.setString(
                              "user_info",
                              jsonEncode(
                                state.loginResponse.userInfo!,
                              ),
                            );
                            kGoToNextAndRemove(
                              context,
                              const BottomNavBar(index: 0),
                            );
                          } else {
                            final snackBar = CommonMethods.buildSnackBarWidget(
                              message: 'Invalid account',
                              contentType: ContentType.failure,
                            );

                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          }
                        }
                        if (state is LoginErrorState) {
                          if (state.statusCode == 403 ||
                              state.statusCode == 422) {
                            final snackBar = CommonMethods.buildSnackBarWidget(
                              message: 'Invalid credentials and try again.',
                              contentType: ContentType.failure,
                            );

                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          } else {
                            final snackBar = CommonMethods.buildSnackBarWidget(
                              message: 'Operation can\'t be performed.',
                              contentType: ContentType.failure,
                            );

                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          }
                        }
                      },
                      builder: (context, state) {
                        return Material(
                          color: const Color(0xFF5AE4A8),
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            splashColor: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                            onTap: state is LoginLoadingState
                                ? null
                                : () {
                                    debugPrint(StorageUtils.getString("url"));
                                    if (formState.currentState!.validate()) {
                                      BlocProvider.of<LoginBloc>(context).add(
                                        LoginRequestEvent(
                                          loginRequest: LoginRequest(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                            child: SizedBox(
                              height: 55,
                              width: double.infinity,
                              child: Center(
                                child: state is LoginLoadingState
                                    ? SpinKitThreeBounce(
                                        color: Colors.grey.shade900,
                                        size: 20,
                                      )
                                    : Text(
                                        AppLocalizations.of(context).signInBtn,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // TextButton(
                    //   onPressed: () {
                    //     FocusScope.of(context).unfocus();
                    //     kGoToNext(context, const APILink());
                    //   },
                    //   child: const Text(
                    //     "Change URL 🖊",
                    //     style: TextStyle(
                    //         color: Color(0xFF5AE4A8),
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
