import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

showSnackBarWidget(BuildContext context, String text,
    [Color color = Colors.black45]) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
    content: Text(
      text,
      style: GoogleFonts.poppins(color: Colors.white),
    ),
  ));
}
