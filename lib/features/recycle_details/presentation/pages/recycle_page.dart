import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/common/widget/appbar_widget.dart';
import 'package:to_do_app/features/calender_details/presentation/bloc/recyclebloc/recyclebin_bloc.dart';
import 'package:to_do_app/features/recycle_details/presentation/widgets/shimmer_widget.dart';
import 'package:to_do_app/features/recycle_details/presentation/widgets/task_container.dart';

import '../../../../core/common/widget/snackbar_widget.dart';
import '../../../../core/theme/colors.dart';
import '../../../../flutter_gen/gen_l10n/app_localizations.dart';
import '../../../calender_details/presentation/bloc/bloc/add_tasks_bloc.dart';

@RoutePage()
class RecyclePage extends StatefulWidget {
  const RecyclePage({super.key});

  @override
  State<RecyclePage> createState() => _RecyclePageState();
}

class _RecyclePageState extends State<RecyclePage> {
  @override
  void initState() {
    context.read<RecycleBinBloc>().add((GetBin()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.maxFinite, 50.h),
          child: CustomAppBar(
            title: AppLocalizations.of(context)!.recycle,
            isBack: true,
          )),
      body: Column(
        children: [
          BlocConsumer<RecycleBinBloc, RecycleBinState>(
            listener: (context, state) {
              if (state is TasksDeleteSuccess) {
                showSnackBarWidget(
                    context, "Task deleted", Colors.red.shade700);
              }
              if (state is AddTaskSuccess1) {
                showSnackBarWidget(context, "Task Added", kColorPrimary);
              }
            },
            builder: (context, state) {
              if (state is AddTaskLoading) {
                return Expanded(
                  child: ListView.builder(
                      physics: const ScrollPhysics(),
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return const ShimmerWidget();
                      }),
                );
              } else if (state is AddRecycleTaskState) {
                return state.tasks.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            SizedBox(height: 100.h),
                            SizedBox(
                              height: 230.h,
                              child: SvgPicture.asset(
                                "assets/images/empty_img.svg",
                                height: 230.h,
                              ),
                            ),
                            Text(
                              "Recycle Bin Empty !!!",
                              style: GoogleFonts.poppins(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: state.tasks.length,
                          itemBuilder: (context, index) {
                            return TaskContainer(
                              taskData: state.tasks[index],
                              index: index,
                            );
                          },
                        ),
                      );
              } else {
                return Expanded(
                  child: ListView.builder(
                      itemCount: 8,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return const ShimmerWidget();
                      }),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
