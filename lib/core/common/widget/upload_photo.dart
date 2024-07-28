import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/theme/colors.dart';
import '../../../features/auth/presentation/bloc/bloc/signup_bloc.dart';
import '../../../features/auth/presentation/bloc/bloc/signup_event.dart';

Future<void> showOptionBottomSheet(BuildContext context) async {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 120.h,
        width: 411.42857142857144.w,
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  uploadPhoto("cam", context);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.camera,
                      color: kColorPrimary,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "Camera",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              SizedBox(height: 25.w),
              GestureDetector(
                onTap: () {
                  uploadPhoto("gal", context);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.photo,
                      color: kColorPrimary,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "Gallery",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> uploadPhoto(String option, BuildContext context) async {
  final ImagePicker picker = ImagePicker();
  // String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
  XFile? file = await picker.pickImage(
      source: option == "cam" ? ImageSource.camera : ImageSource.gallery);

  if (file == null) return;

  // Reference referenceToUpload =
  //     FirebaseStorage.instance.ref().child('images').child(uniqueFileName);

  try {
    // await referenceToUpload.putFile(File(file.path));
    context.read<SignUpBloc>().add(ProfileImageSelect(image: file.path));
    // String imageUrl = await referenceToUpload.getDownloadURL();
    // log("$imageUrl");
    AutoRouter.of(context).popForced();
  } catch (e) {
    rethrow;
  }
}

Future<String> uploadPhoto1(File file) async {
  String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();

  Reference referenceToUpload =
      FirebaseStorage.instance.ref().child('images').child(uniqueFileName);

  try {
    await referenceToUpload.putFile(File(file.path));
    String imageUrl = await referenceToUpload.getDownloadURL();
    return imageUrl;
  } catch (e) {
    rethrow;
  }
}
