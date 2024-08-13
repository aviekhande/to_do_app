import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:to_do_app/features/important_details/presentation/pages/important_page.dart';
import 'package:to_do_app/features/profile_screen/presentation/pages/profile_screen.dart';
import 'package:to_do_app/features/settings_details/presentation/pages/settings_page.dart';
import '../../features/add_task_details/presentation/pages/add_task_dialog.dart';
import '../../features/auth/presentation/pages/login.dart';
import '../../features/auth/presentation/pages/mobile_number_login_screen.dart';
import '../../features/auth/presentation/pages/options_to_login.dart';
import '../../features/auth/presentation/pages/otp_page.dart';
import '../../features/auth/presentation/pages/signup.dart';
import '../../features/edit_task_details/presentation/pages/edit_task_page.dart';
import '../../features/edit_task_details/presentation/pages/todo_note_page.dart';
import '../../features/home_screen/data/model/task_model.dart';
import '../../features/home_screen/presentation/pages/home_screen.dart';
import '../../features/recycle_details/presentation/pages/recycle_page.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';
import '../../features/update_account/presentation/pages/update_account_screen.dart';
import '../common/widget/bottomnav_widget.dart';
import '../common/widget/session_controller.dart';
part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: "Route")
class AppRouter extends _$AppRouter {
  User? isLogin() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      SessionController().userId = user.uid.toString();
    }
    return user;
  }

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
  @override
  List<AutoRoute> get routes => [
        isLogin() != null
            ? AutoRoute(page: CommonbottomnavigationbarRoute.page)
            : AutoRoute(
                page: CommonbottomnavigationbarRoute.page,
              ),
        AutoRoute(page: SplashScreenRoute.page, path: "/"),
        AutoRoute(page: AddTaskScreenRoute.page),
        AutoRoute(page: ForgotPasswordScreenRoute.page),
        AutoRoute(page: UpdateAccountScreenRoute.page),
        AutoRoute(page: LoginScreenRoute.page),
        AutoRoute(page: ProfileScreenRoute.page),
        AutoRoute(page: SignUpScreenRoute.page),
        AutoRoute(page: HomeScreenRoute.page),
        AutoRoute(page: MobileNumberLoginScreenRoute.page),
        AutoRoute(page: SettingsPageRoute.page),
        AutoRoute(page: RecyclePageRoute.page),
        AutoRoute(page: EditTaskPageRoute.page),
        AutoRoute(page: ImportantPageRoute.page),
        AutoRoute(page: OtpPageRoute.page),
        AutoRoute(page: TodoNotePageRoute.page),
        isLogin() != null
            ? AutoRoute(
                page: OptionScreenRoute.page,
              )
            : AutoRoute(page: OptionScreenRoute.page, path: "/"),
        // CustomRoute(
        //   page: ProfileScreenRoute.page,
        //   transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
        //   durationInMilliseconds: 500,
        //   reverseDurationInMilliseconds: 500,
        // ),
      ];
}
