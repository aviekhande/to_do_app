import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/theme/colors.dart';
import '../../../features/auth/presentation/bloc/loginbloc/loginbloc.dart';
import '../../../features/auth/presentation/bloc/loginbloc/loginevent.dart';

class LogoutAlertDialogBox extends StatelessWidget {
  const LogoutAlertDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:
          Theme.of(context).colorScheme.surface == Colors.grey.shade700
              ? Theme.of(context).colorScheme.surface
              : const Color.fromARGB(255, 238, 245, 238),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   "Confirm Logout...!!!",
          //   style: GoogleFonts.poppins(fontSize: 18.sp),
          // ),
          const Center(
            child: Icon(
              Icons.question_mark_rounded,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Are you sure,you want to Logout?",
            style: GoogleFonts.poppins(fontSize: 14.sp),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () {
                  context.read<LoginBloc>().add(LogoutEvent());
                },
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.red)),
                child: Text(
                  "Yes",
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: kColorWhite,
                  ),
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(kColorPrimary)),
                child: Text(
                  "No",
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: kColorWhite,
                  ),
                )),
          ],
        ),
      ],
    );
  }
}
