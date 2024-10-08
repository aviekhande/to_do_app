import 'dart:developer';
import 'package:alarm/alarm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:to_do_app/core/routes/app_router.dart';
import 'package:to_do_app/features/auth/presentation/bloc/bloc/signup_bloc.dart';
import 'package:to_do_app/features/auth/presentation/bloc/forgotpassbloc/forgotpass_bloc.dart';
import 'package:to_do_app/features/auth/presentation/bloc/loginbloc/loginbloc.dart';
import 'package:to_do_app/features/calender_details/presentation/bloc/bloc/add_tasks_bloc.dart';
import 'package:to_do_app/features/calender_details/presentation/bloc/recyclebloc/recyclebin_bloc.dart';
import 'package:to_do_app/features/profile_screen/presentation/bloc/bloc/profile_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'core/common/widget/bloc/bottom_nav_bloc.dart';
import 'core/services/localizationbloc/locbloc_bloc.dart';
import 'core/services/network/bloc/internet_bloc/internet_bloc.dart';
import 'core/services/notification_service/notification_service.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/bloc/theme_bloc_bloc.dart';
import 'features/auth/presentation/bloc/login_number_bloc/log_in_with_number_bloc.dart';
import 'features/important_details/presentation/bloc/important_task_bloc.dart';
import 'flutter_gen/gen_l10n/app_localizations.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyAOVIQUI2rWOcOptXPRruvV4H9WxuPsQPM',
    appId: "1:616255276487:android:e0819d0072d27fa57285e2",
    messagingSenderId: '616255276487',
    projectId: 'todo-4e307',
    storageBucket: 'todo-4e307.appspot.com',
  ));

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  await LocalNotificationService().requestPermission();
  await LocalNotificationService().init();
  locatior();
  await Alarm.init();

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late FirebaseMessaging messaging;
  @override
  void initState() {
    super.initState();
    notificationHandler();
    messaging = FirebaseMessaging.instance;

    // Request permission for iOS
    messaging.requestPermission();

    // Get the token

    messaging.getToken().then((token) {
      print("FCM Token: $token");
    });
  }

  void notificationHandler() {
    FirebaseMessaging.onMessage.listen((event) async {
      LocalNotificationService().showNotification(event);
    });
  }

  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(),
          ),
          BlocProvider(
            create: (context) => SignUpBloc(),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(),
          ),
          BlocProvider(
            create: (context) => ThemeBlocBloc(),
          ),
          BlocProvider(
            create: (context) => ForgotPassBloc(),
          ),
          BlocProvider(
            create: (context) => AddTasksBloc(taskRepo: getIt()),
          ),
          BlocProvider(
            create: (context) => LocBloc(),
          ),
          BlocProvider(
            create: (context) => InternetBloc(),
          ),
          BlocProvider(
            create: (context) => BottomNavBloc(),
          ),
          BlocProvider(
            create: (context) => RecycleBinBloc(taskRepo: getIt()),
          ),
          BlocProvider(
            create: (context) => ImportantTaskBloc(taskRepo: getIt()),
          ),
          BlocProvider(
            create: (context) => LogInWithNumberBloc(),
          ),
        ],
        child: ScreenUtilInit(
            designSize: const Size(411.42857142857144, 867.4285714285714),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return BlocBuilder<ThemeBlocBloc, ThemeBlocState>(
                  builder: (context, state) {
                ThemeData th = lightMode;
                if (state is ThemeChangeBloc) {
                  log("@@@@@@");
                  th = state.themeData;
                }
                return BlocBuilder<LocBloc, LocState>(
                  builder: (context, state) {
                    return MaterialApp.router(
                      theme: th,
                      darkTheme:
                          state is ThemeChangeBloc ? ThemeData.dark() : th,
                      locale:
                          state is ChangeState ? state.loc : const Locale("en"),
                      localizationsDelegates:
                          AppLocalizations.localizationsDelegates,
                      supportedLocales: AppLocalizations.supportedLocales,
                      debugShowCheckedModeBanner: false,
                      routerConfig: _appRouter.config(),
                    );
                  },
                );
              });
            }));
  }
}
