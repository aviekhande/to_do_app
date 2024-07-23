import 'package:auto_route/auto_route.dart';

import '../../../features/auth/presentation/login.dart';
import '../../../features/auth/presentation/mobilenumber_login.dart';
import '../../../features/auth/presentation/options_to_login.dart';
import '../../../features/auth/presentation/signup.dart';
import '../../../features/home_screen/presentation/home_screen.dart';
part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: "Route")
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page:  LoginScreenRoute.page ),
    AutoRoute(page: SignUpScreenRoute.page),
    AutoRoute(page: HomeScreenRoute.page),
    AutoRoute(page: MobileNumberLoginScreenRoute.page),
    AutoRoute(page: OptionScreenRoute.page ,path: "/"),
    ];
}
