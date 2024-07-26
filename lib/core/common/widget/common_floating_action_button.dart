import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/core/theme/colors.dart';

import '../../routes/app_router.dart';

class CommonFloatingActionButton extends StatefulWidget {
  const CommonFloatingActionButton({super.key});

  @override
  State<CommonFloatingActionButton> createState() =>
      _CommonFloatingActionButtonState();
}

class _CommonFloatingActionButtonState
    extends State<CommonFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: [
        BoxShadow(
            color: Color.fromARGB(255, 148, 170, 153),
            spreadRadius: 2,
            offset: Offset(0, 4),
            blurRadius: 10)
      ]),
      child: FloatingActionButton(
        backgroundColor: kColorPrimary,
        elevation: 0,
        onPressed: () {
          AutoRouter.of(context).push(const AddTaskScreenRoute());
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Icon(
          Icons.add,
          color: kColorWhite,
        ),
      ),
    );
  }
}
