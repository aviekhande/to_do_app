import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app/features/forgot_password/forgot_password_screen.dart';
import 'package:to_do_app/features/profile_screen/presentation/pages/profile_screen.dart';
import '../../features/add_task/add_task_screen.dart';
import '../../features/auth/presentation/login.dart';
import '../../features/auth/presentation/mobile_number_login_screen.dart';
import '../../features/auth/presentation/options_to_login.dart';
import '../../features/auth/presentation/signup.dart';
import '../../features/home_screen/presentation/pages/home_screen.dart';
import '../../features/update_account/update_account_screen.dart';
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
            ? AutoRoute(page: CommonbottomnavigationbarRoute.page, path: "/")
            : AutoRoute(
                page: CommonbottomnavigationbarRoute.page,
              ),
        AutoRoute(page: AddTaskScreenRoute.page),
        AutoRoute(page: ForgotPasswordScreenRoute.page),
        AutoRoute(page: UpdateAccountScreenRoute.page),
        AutoRoute(page: LoginScreenRoute.page),
        AutoRoute(page: ProfileScreenRoute.page),
        AutoRoute(page: SignUpScreenRoute.page),
        AutoRoute(page: HomeScreenRoute.page),
        AutoRoute(page: MobileNumberLoginScreenRoute.page),
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
