import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final bool? isBack;
  const CustomAppBar({super.key, this.title, this.isBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: !isBack!,
      backgroundColor:
          Theme.of(context).colorScheme.surface == Colors.grey.shade700
              ? Theme.of(context).colorScheme.secondary
              : const Color.fromARGB(255, 214, 232, 215),
      title: Row(
        children: [
          isBack!
              ? GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    AutoRouter.of(context).popForced();
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/back_ic.svg",
                        height: 25.h,
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                    ],
                  ))
              : const SizedBox(),
          Text(
            title!,
            style: GoogleFonts.poppins(
                fontSize: 20.sp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
