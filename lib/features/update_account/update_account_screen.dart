import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/common/widget/authmethod.dart';
import '../../../core/theme/colors.dart';

@RoutePage()
class UpdateAccountScreen extends StatefulWidget {
  const UpdateAccountScreen({super.key});

  @override
  State<UpdateAccountScreen> createState() => _UpdateAccountScreenState();
}

class _UpdateAccountScreenState extends State<UpdateAccountScreen> {
  GlobalKey<FormState> checkkey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool unShowPass1 = true;
  bool unShowPass = true;
  Icon toggleIcon() {
    return Icon(
        unShowPass ? Icons.remove_red_eye_outlined : Icons.remove_red_eye);
  }

  Icon toggleIcon1() {
    return Icon(
        unShowPass1 ? Icons.remove_red_eye_outlined : Icons.remove_red_eye);
  }

  void signUpUser() async {
    // set is loading to true.

    String res = await AuthMethod().signUpUser(
        email: emailController.text,
        password: passwordController.text,
        name: firstNameController.text);
    // if string return is success, user has been creaded and navigate to next screen other witse show error.
    if (res == "success") {
      //navigate to the next screen
      // AutoRouter.of(context).push(const SplashScreenRoute());
      // showSnackBar(context, res);
    } else {
      // show error
      // showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            AutoRouter.of(context).popForced();
          },
          child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kColorWhite,
              ),
              child: SvgPicture.asset("assets/icons/back_ic.svg")),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 10.h, right: 15.w, left: 15.w),
          child: Form(
            key: checkkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        height: 80.h,
                        child: Image.asset("assets/images/profile_image.png"),
                      ),
                      Positioned(
                        bottom: 3,
                        left: 68,
                        child: GestureDetector(
                          onTap: () {
                            showOptionBottomSheet();
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: kColorWhite,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 203, 202, 202),
                                      offset: Offset(0, 2),
                                      blurRadius: 1,
                                      spreadRadius: 0)
                                ]),
                            height: 30.h,
                            width: 30.w,
                            child: const Icon(
                              Icons.photo_camera_outlined,
                              color: kColorPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("First Name"),
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          width: 150.w,
                          child: TextFormField(
                            // key: checkkey,
                            controller: firstNameController,
                            decoration: InputDecoration(
                              hintStyle:
                                  GoogleFonts.poppins(color: kColorLightBlack),
                              contentPadding: const EdgeInsets.only(
                                  left: 15, bottom: 20, top: 8, right: 10),
                              hintText: "Jhon",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Name";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Last Name"),
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          width: 150.w,
                          child: TextFormField(
                            // key: checkkey,
                            controller: lastNameController,
                            decoration: InputDecoration(
                              hintStyle:
                                  GoogleFonts.poppins(color: kColorLightBlack),
                              contentPadding: const EdgeInsets.only(
                                  left: 15, bottom: 20, top: 8, right: 10),
                              hintText: "Doe",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Last Name";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 300.h,
                ),
                GestureDetector(
                  onTap: () {
                    if (checkkey.currentState!.validate()) {
                      signUpUser();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 50.w, right: 50.w, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        color: kColorPrimary,
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                        child: Text(
                      "Update Account",
                      style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: kColorWhite),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showOptionBottomSheet() async {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 100.h,
          width: 360.w,
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    uploadPhoto("cam");
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
                    uploadPhoto("gal");
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

  Future<void> uploadPhoto(String option) async {
    final ImagePicker picker = ImagePicker();
    // String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
    XFile? file = await picker.pickImage(
        source: option == "cam" ? ImageSource.camera : ImageSource.gallery);
    AutoRouter.of(context).popForced();
    // if (file == null) return;

    // Reference referenceToUpload =
    //     FirebaseStorage.instance.ref().child('images').child(uniqueFileName);

    // try {
    //   context.read<ProfiledataBloc>().add(ProfileUpdate(image: file.path));
    //   context.loaderOverlay.show();
    //   await referenceToUpload.putFile(File(file.path));
    //   imageUrl = await referenceToUpload.getDownloadURL();
    //   context.read<ProfiledataBloc>().add(ProfileUpdate(image: file.path));

    //   context.loaderOverlay.hide();
    //   log(imageUrl);
    // } catch (e) {
    //   log("IN Catch");
    //   rethrow;
    // }
  }
}
