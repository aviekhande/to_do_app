// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddTaskScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddTaskScreen(),
      );
    },
    CommonbottomnavigationbarRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const Commonbottomnavigationbar(),
      );
    },
    EditTaskPageRoute.name: (routeData) {
      final args = routeData.argsAs<EditTaskPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EditTaskPage(
          key: args.key,
          task: args.task,
          index: args.index,
        ),
      );
    },
    ForgotPasswordScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ForgotPasswordScreen(),
      );
    },
    HomeScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    ImportantPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ImportantPage(),
      );
    },
    LoginScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
      );
    },
    MobileNumberLoginScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MobileNumberLoginScreen(),
      );
    },
    OptionScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OptionScreen(),
      );
    },
    OtpPageRoute.name: (routeData) {
      final args = routeData.argsAs<OtpPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OtpPage(
          key: args.key,
          mobile: args.mobile,
        ),
      );
    },
    ProfileScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileScreen(),
      );
    },
    RecyclePageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RecyclePage(),
      );
    },
    SettingsPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsPage(),
      );
    },
    SignUpScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpScreen(),
      );
    },
    SplashScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
    UpdateAccountScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UpdateAccountScreen(),
      );
    },
  };
}

/// generated route for
/// [AddTaskScreen]
class AddTaskScreenRoute extends PageRouteInfo<void> {
  const AddTaskScreenRoute({List<PageRouteInfo>? children})
      : super(
          AddTaskScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddTaskScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [Commonbottomnavigationbar]
class CommonbottomnavigationbarRoute extends PageRouteInfo<void> {
  const CommonbottomnavigationbarRoute({List<PageRouteInfo>? children})
      : super(
          CommonbottomnavigationbarRoute.name,
          initialChildren: children,
        );

  static const String name = 'CommonbottomnavigationbarRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EditTaskPage]
class EditTaskPageRoute extends PageRouteInfo<EditTaskPageRouteArgs> {
  EditTaskPageRoute({
    Key? key,
    Tasks? task,
    required int index,
    List<PageRouteInfo>? children,
  }) : super(
          EditTaskPageRoute.name,
          args: EditTaskPageRouteArgs(
            key: key,
            task: task,
            index: index,
          ),
          initialChildren: children,
        );

  static const String name = 'EditTaskPageRoute';

  static const PageInfo<EditTaskPageRouteArgs> page =
      PageInfo<EditTaskPageRouteArgs>(name);
}

class EditTaskPageRouteArgs {
  const EditTaskPageRouteArgs({
    this.key,
    this.task,
    required this.index,
  });

  final Key? key;

  final Tasks? task;

  final int index;

  @override
  String toString() {
    return 'EditTaskPageRouteArgs{key: $key, task: $task, index: $index}';
  }
}

/// generated route for
/// [ForgotPasswordScreen]
class ForgotPasswordScreenRoute extends PageRouteInfo<void> {
  const ForgotPasswordScreenRoute({List<PageRouteInfo>? children})
      : super(
          ForgotPasswordScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeScreenRoute extends PageRouteInfo<void> {
  const HomeScreenRoute({List<PageRouteInfo>? children})
      : super(
          HomeScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ImportantPage]
class ImportantPageRoute extends PageRouteInfo<void> {
  const ImportantPageRoute({List<PageRouteInfo>? children})
      : super(
          ImportantPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ImportantPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginScreen]
class LoginScreenRoute extends PageRouteInfo<void> {
  const LoginScreenRoute({List<PageRouteInfo>? children})
      : super(
          LoginScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MobileNumberLoginScreen]
class MobileNumberLoginScreenRoute extends PageRouteInfo<void> {
  const MobileNumberLoginScreenRoute({List<PageRouteInfo>? children})
      : super(
          MobileNumberLoginScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'MobileNumberLoginScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OptionScreen]
class OptionScreenRoute extends PageRouteInfo<void> {
  const OptionScreenRoute({List<PageRouteInfo>? children})
      : super(
          OptionScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'OptionScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OtpPage]
class OtpPageRoute extends PageRouteInfo<OtpPageRouteArgs> {
  OtpPageRoute({
    Key? key,
    required String mobile,
    List<PageRouteInfo>? children,
  }) : super(
          OtpPageRoute.name,
          args: OtpPageRouteArgs(
            key: key,
            mobile: mobile,
          ),
          initialChildren: children,
        );

  static const String name = 'OtpPageRoute';

  static const PageInfo<OtpPageRouteArgs> page =
      PageInfo<OtpPageRouteArgs>(name);
}

class OtpPageRouteArgs {
  const OtpPageRouteArgs({
    this.key,
    required this.mobile,
  });

  final Key? key;

  final String mobile;

  @override
  String toString() {
    return 'OtpPageRouteArgs{key: $key, mobile: $mobile}';
  }
}

/// generated route for
/// [ProfileScreen]
class ProfileScreenRoute extends PageRouteInfo<void> {
  const ProfileScreenRoute({List<PageRouteInfo>? children})
      : super(
          ProfileScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RecyclePage]
class RecyclePageRoute extends PageRouteInfo<void> {
  const RecyclePageRoute({List<PageRouteInfo>? children})
      : super(
          RecyclePageRoute.name,
          initialChildren: children,
        );

  static const String name = 'RecyclePageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsPage]
class SettingsPageRoute extends PageRouteInfo<void> {
  const SettingsPageRoute({List<PageRouteInfo>? children})
      : super(
          SettingsPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpScreen]
class SignUpScreenRoute extends PageRouteInfo<void> {
  const SignUpScreenRoute({List<PageRouteInfo>? children})
      : super(
          SignUpScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashScreen]
class SplashScreenRoute extends PageRouteInfo<void> {
  const SplashScreenRoute({List<PageRouteInfo>? children})
      : super(
          SplashScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UpdateAccountScreen]
class UpdateAccountScreenRoute extends PageRouteInfo<void> {
  const UpdateAccountScreenRoute({List<PageRouteInfo>? children})
      : super(
          UpdateAccountScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'UpdateAccountScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
