import 'dart:developer';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_app/core/theme/colors.dart';
import '../../../calender_details/presentation/bloc/bloc/add_tasks_bloc.dart';
import '../../../home_screen/data/model/task_model.dart';

Future<void> showOptionBottomSheet(
    BuildContext context, Tasks task, int index) async {
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
                  uploadPhoto("dev", context, task, index);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.folder_outlined,
                      color: kColorPrimary,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "Device files",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 16.sp),
                    )
                  ],
                ),
              ),
              SizedBox(height: 25.w),
              GestureDetector(
                onTap: () {
                  uploadPhoto("cam", context, task, index);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.camera_alt_outlined,
                      color: kColorPrimary,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "Camera",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 16.sp),
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

final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
Future<void> uploadPhoto(
    String option, BuildContext context, Tasks task, int ind) async {
  try {
    String? filePath;
    String? fileName;

    // Picking the file or image based on the option
    if (option == "cam") {
      final ImagePicker picker = ImagePicker();
      XFile? file = await picker.pickImage(source: ImageSource.camera);

      if (file != null) {
        filePath = file.path;
        fileName = file.name;
      }
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        filePath = result.files.first.path;
        fileName = result.files.first.name;
      }
    }
    AutoRouter.of(context).popForced();
    if (filePath == null || fileName == null) return;

    // Uploading to Firebase Storage
    final storageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    await storageRef.putFile(File(filePath));
    String imageUrl = await storageRef.getDownloadURL();
    log(imageUrl);
    task.files = [
      {"name": "$fileName", "url": "$imageUrl"}
    ];
    context.read<AddTasksBloc>().add(EditTask(task: task, index: ind));
  } catch (e) {
    debugPrint('Error uploading photo: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error uploading photo: $e')),
    );
  }
}

Future<String> uploadPhoto1(File file) async {
  String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
  Reference referenceToUpload =
      FirebaseStorage.instance.ref().child('images').child(uniqueFileName);
  try {
    await referenceToUpload.putFile(File(file.path));
    String imageUrl = await referenceToUpload.getDownloadURL();
    log("uploadPhoto");
    return imageUrl;
  } catch (e) {
    rethrow;
  }
}
