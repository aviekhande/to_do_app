import 'dart:developer';

import 'package:alarm/alarm.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/common/widget/appbar_widget.dart';

import '../../../../core/common/widget/logout_alert_dialog_box.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/services/alarm_services/alarm_services.dart';
import '../../../../core/services/localizationbloc/locbloc_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/bloc/theme_bloc_bloc.dart';
import '../../../../core/theme/colors.dart';
import '../../../../flutter_gen/gen_l10n/app_localizations.dart';
import '../../../auth/presentation/bloc/loginbloc/loginbloc.dart';
import '../../../auth/presentation/bloc/loginbloc/loginstate.dart';
import '../../../home_screen/presentation/pages/home_screen.dart';

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

bool isDarkTheme = false;

class _SettingsPageState extends State<SettingsPage> {
  void changeTheme() {
    isDarkTheme = !isDarkTheme;
    setState(() {});
  }

  String selectedValue = "English";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 50.h),
        child: CustomAppBar(
          title: AppLocalizations.of(context)!.set,
          isBack: true,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Container(
            padding: EdgeInsets.all(8.0.h),
            margin: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: isDarkTheme ? Colors.grey[850] : Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.translate,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 16.sp),
                ),
                SizedBox(height: 15.h),
                Row(
                  children: [
                    const Icon(Icons.g_translate_sharp),
                    SizedBox(width: 10.w),
                    BlocBuilder<LocBloc, LocState>(
                      builder: (context, state) {
                        final Locale currentLocale = state is ChangeState
                            ? state.loc
                            : const Locale('en');
                        selectedValue = currentLocale == const Locale("en")
                            ? "English"
                            : "Hindi";
                        return DropdownButton(
                          isDense: true,
                          autofocus: true,
                          value: selectedValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue!;
                              log(newValue);
                              if (newValue == "English") {
                                BlocProvider.of<LocBloc>(context)
                                    .add(ChangeLang(loc: const Locale('en')));
                              } else {
                                BlocProvider.of<LocBloc>(context)
                                    .add(ChangeLang(loc: const Locale('hi')));
                              }
                            });
                          },
                          items: [
                            DropdownMenuItem(
                              value: "English",
                              child: Text(
                                "English",
                                style: GoogleFonts.poppins(fontSize: 12.sp),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "Hindi",
                              child: Text(
                                "Hindi",
                                style: GoogleFonts.poppins(fontSize: 12.sp),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.all(8.0.h),
            margin: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: isDarkTheme ? Colors.grey[850] : Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.theme,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 16.sp),
                ),
                SizedBox(height: 15.h),
                Row(
                  children: [
                    Icon(
                      Icons.sunny,
                      color: isDarkTheme
                          ? const Color.fromARGB(255, 205, 203, 203)
                          : Colors.amber,
                    ),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: () {
                        isDarkTheme
                            ? context
                                .read<ThemeBlocBloc>()
                                .add(ThemeBlocEvent(themeData: lightMode))
                            : context
                                .read<ThemeBlocBloc>()
                                .add(ThemeBlocEvent(themeData: darkMode));
                        changeTheme();
                        log("changeTheme");
                      },
                      child: Container(
                        height: 23.h,
                        width: 45.w,
                        decoration: BoxDecoration(
                          color: isDarkTheme
                              ? const Color.fromARGB(255, 54, 14, 135)
                              : const Color.fromARGB(255, 205, 203, 203),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: kColorLightBlack, width: 2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 12.w,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: isDarkTheme
                                    ? const Color.fromARGB(255, 54, 14, 135)
                                    : kColorLightBlack,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Container(
                              width: 17.w,
                              height: 17.h,
                              decoration: BoxDecoration(
                                color: isDarkTheme
                                    ? kColorWhite
                                    : const Color.fromARGB(255, 205, 203, 203),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Icon(
                      Icons.dark_mode,
                      color: isDarkTheme
                          ? const Color.fromARGB(255, 54, 14, 135)
                          : kColorLightBlack,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.all(8.0.h),
            margin: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: isDarkTheme ? Colors.grey[850] : Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.logout,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 16.sp),
                ),
                SizedBox(height: 15.h),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is Logout) {
                      log("IN LogoutState");
                      AutoRouter.of(context)
                          .replaceAll([const OptionScreenRoute()]);
                    }
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => const LogoutAlertDialogBox());
                       AlarmService().resetService();
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.logout),
                          SizedBox(width: 10.w),
                          Text(
                            AppLocalizations.of(context)!.logout,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, fontSize: 16.sp),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
