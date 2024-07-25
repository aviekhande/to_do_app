import 'package:auto_route/auto_route.dart';
import 'package:to_do_app/features/forgot_password/forgot_password_screen.dart';
import 'package:to_do_app/features/profile_screen/presentation/profile_screen.dart';
import '../../../features/add_task/add_task_screen.dart';
import '../../../features/auth/presentation/login.dart';
import '../../../features/auth/presentation/mobile_number_login_screen.dart';
import '../../../features/auth/presentation/options_to_login.dart';
import '../../../features/auth/presentation/signup.dart';
import '../../../features/home_screen/presentation/home_screen.dart';
import '../../../features/update_account/update_account_screen.dart';
part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: "Route")
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AddTaskScreenRoute.page),
        AutoRoute(page: ForgotPasswordScreenRoute.page),
        AutoRoute(page: UpdateAccountScreenRoute.page),
        AutoRoute(page: LoginScreenRoute.page),
        // AutoRoute(page: ProfileScreenRoute.page ),
        AutoRoute(page: SignUpScreenRoute.page),
        AutoRoute(page: HomeScreenRoute.page),
        AutoRoute(page: MobileNumberLoginScreenRoute.page),
        AutoRoute(page: OptionScreenRoute.page, path: "/"),
        CustomRoute(
          page: ProfileScreenRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 500,
          reverseDurationInMilliseconds: 500,
        ),
      ];
}
