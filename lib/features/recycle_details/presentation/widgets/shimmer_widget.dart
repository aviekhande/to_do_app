import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatefulWidget {
  const ShimmerWidget({
    super.key,
  });

  @override
  State<ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 60.h,
        margin: EdgeInsets.only(
          top: 15.w,
          right: 15.w,
          left: 15.w,
        ),
        decoration: BoxDecoration(
            boxShadow: [
              if (Theme.of(context).colorScheme.shadow !=
                  const Color.fromARGB(255, 111, 109, 109))
                BoxShadow(
                    color: Theme.of(context).colorScheme.shadow,
                    blurRadius: 5,
                    offset: const Offset(0, 3))
            ],
            color: Theme.of(context).colorScheme.surface == Colors.grey.shade700
                ? Theme.of(context).colorScheme.surface
                : const Color.fromARGB(255, 238, 245, 238),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
