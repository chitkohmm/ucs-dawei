import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pusher_client/pusher_client.dart';

import '../../data/blocs/book_bloc/book_bloc.dart';
import '../../data/blocs/books_by_category_bloc/books_by_category_bloc.dart';
import '../../data/blocs/borrow_books_bloc/borrow_books_bloc.dart';
import '../../data/blocs/download_books_bloc/download_books_bloc.dart';
import '../../data/blocs/expired_books_bloc/expired_books_bloc.dart';
import '../../data/blocs/home_bloc/home_bloc.dart';
import '../../data/blocs/language_cubit/language_cubit.dart';
import '../../data/blocs/login_bloc/login_bloc.dart';
import '../../data/blocs/order_list_bloc/order_list_bloc.dart';
import '../../data/blocs/pending_bloc/pending_bloc.dart';
import '../../data/blocs/search_bloc/search_bloc.dart';
import '../../data/blocs/videos_bloc/videos_bloc.dart';
import '../../data/network/api_service.dart';
import '../../l10n/l10n.dart';
import '../splash/splash.dart';


class App extends StatefulWidget {
  const App({Key? key, required this.pusher}) : super(key: key);
  final PusherClient pusher;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late Timer timer;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
//     Channel channel = widget.pusher.subscribe("order_books");
//
// // Bind to listen for events called "order-status-updated" sent to "private-orders" channel
//     channel.bind("App\\Events\\OrderAcceptEvent", (PusherEvent? event) {
//       print("PUSHER EVENT: ${event!.data.toString()}");
//       Map<String, dynamic> map = jsonDecode(event.data!);
//       _showNotificationWithDefaultSound(map['message']);
//     });
//
//     var initializationSettingsAndroid =
//         const AndroidInitializationSettings("@mipmap/ic_launcher");
//     var initialzationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.requestPermission();
//     flutterLocalNotificationsPlugin.initialize(initialzationSettings);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    timer = Timer(const Duration(seconds: 2), () {
      precacheImage(const AssetImage("assets/images/ucs_dawei.png"), context);
      precacheImage(const AssetImage("assets/images/shape.png"), context);
      precacheImage(const AssetImage("assets/images/video cover.png"), context);
      precacheImage(const AssetImage("assets/images/studying.png"), context);
      precacheImage(const AssetImage("assets/images/library.png"), context);
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
      create: (BuildContext context) => ApiService.create(),
      child: Consumer<ApiService>(
        builder: (BuildContext context, apiService, Widget? child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<LoginBloc>(
                create: (BuildContext context) =>
                    LoginBloc(apiService: apiService),
              ),
              BlocProvider<LanguageCubit>(
                create: (BuildContext context) =>
                    LanguageCubit(const Locale("en")),
              ),
              BlocProvider<HomeBloc>(
                create: (BuildContext context) =>
                    HomeBloc(apiService: apiService),
              ),
              BlocProvider<SearchBloc>(
                create: (BuildContext context) =>
                    SearchBloc(apiService: apiService),
              ),
              BlocProvider<BooksByCategoryBloc>(
                create: (BuildContext context) =>
                    BooksByCategoryBloc(apiService: apiService),
              ),
              BlocProvider<OrderListBloc>(
                create: (BuildContext context) =>
                    OrderListBloc(apiService: apiService),
              ),
              BlocProvider<BookBloc>(
                create: (BuildContext context) =>
                    BookBloc(apiService: apiService),
              ),
              BlocProvider<DownloadBooksBloc>(
                create: (BuildContext context) =>
                    DownloadBooksBloc(apiService: apiService),
              ),
              BlocProvider<PendingBloc>(
                create: (BuildContext context) =>
                    PendingBloc(apiService: apiService),
              ),
              BlocProvider<ExpiredBooksBloc>(
                create: (BuildContext context) =>
                    ExpiredBooksBloc(apiService: apiService),
              ),
              BlocProvider<BorrowBooksBloc>(
                create: (BuildContext context) =>
                    BorrowBooksBloc(apiService: apiService),
              ),
              BlocProvider<VideosBloc>(
                create: (BuildContext context) =>
                    VideosBloc(apiService: apiService),
              ),
            ],
            child: BlocBuilder<LanguageCubit, Locale>(
              builder: (context, lang) {
                return MaterialApp(
                  theme: ThemeData(fontFamily: "Didact"),
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                  ],
                  locale: lang,
                  debugShowCheckedModeBanner: false,
                  title: 'UCS Dawei',
                  supportedLocales: const [
                    Locale('en'), // English
                    Locale('mm'), // Spanish
                  ],
                  home: const Splash(),
                  builder: (context, child) {
                    MediaQueryData data = MediaQuery.of(context);

                    return MediaQuery(
                      data: data.copyWith(textScaler: TextScaler.noScaling),
                      child: child!,
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
