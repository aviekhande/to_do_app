import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/features/important_details/presentation/widgets/shimmer_widget.dart';
import 'package:to_do_app/features/important_details/presentation/widgets/task_container.dart';
import '../../../../core/common/widget/appbar_widget.dart';
import '../../../../core/common/widget/drawer_widget.dart';
import '../../../../flutter_gen/gen_l10n/app_localizations.dart';
import '../../../home_screen/data/model/task_model.dart';
import '../bloc/important_task_bloc.dart';

@RoutePage()
class ImportantPage extends StatefulWidget {
  const ImportantPage({super.key});

  @override
  State<ImportantPage> createState() => _ImportantPageState();
}

class _ImportantPageState extends State<ImportantPage> {
  @override
  void initState() {
    super.initState();
    context.read<ImportantTaskBloc>().add(ImportantFetchTask());
  }

  List<Tasks>? tasks;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size(double.maxFinite, 50.h),
          child: CustomAppBar(
            title: AppLocalizations.of(context)!.imp,
            isBack: true,
          )),
      body: Column(
        children: [
          BlocConsumer<ImportantTaskBloc, ImportantTaskState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ImportantTaskLoading) {
                return Expanded(
                  child: ListView.builder(
                      physics: const ScrollPhysics(),
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return const ShimmerWidget();
                      }),
                );
              } else if (state is ImportantTask) {
                return state.task.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: state.task.length,
                          itemBuilder: (context, index) {
                            return TaskContainer(
                              taskData: state.task[index],
                              index: index,
                            );
                          },
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(height: 350.h),
                          Center(
                            child: Text(
                              "No Important Tasks",
                              style: GoogleFonts.poppins(
                                  fontSize: 16.sp, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
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
      drawer: const CommonDrawer(
        page: "Home",
      ),
    );
  }
}
