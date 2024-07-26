import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../features/auth/presentation/bloc/loginbloc/loginbloc.dart';
import '../../../features/auth/presentation/bloc/loginbloc/loginevent.dart';

class LogoutAlertDialogBox extends StatelessWidget {
  const LogoutAlertDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Confirm Logout...!!!",
            style: GoogleFonts.poppins(fontSize: 18.sp),
          ),
          Text(
            "Are you sure,you want to logout",
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
                child: const Text(
                  "Yes",
                  style: TextStyle(color: Colors.black),
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "No",
                  style: TextStyle(color: Colors.black),
                )),
          ],
        ),
      ],
    );
  }
}
