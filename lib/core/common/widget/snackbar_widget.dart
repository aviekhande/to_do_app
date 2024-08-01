import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/theme/colors.dart';

showSnackBarWidget(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: kColorPrimary,
    content: Text(
      text,
      style: GoogleFonts.poppins(color: Colors.white),
    ),
  ));
}
