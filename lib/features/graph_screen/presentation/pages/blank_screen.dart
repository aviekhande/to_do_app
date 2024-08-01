import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../../../flutter_gen/gen_l10n/app_localizations.dart';
import '../../../calender_details/presentation/bloc/bloc/add_tasks_bloc.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  Map<String, double> dataMap = {
    "InComplete Task": 5,
    "Completed Task": 5,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).colorScheme.surface == Colors.grey.shade700
                ? Theme.of(context).colorScheme.secondary
                : const Color.fromARGB(255, 214, 232, 215),
        title: Text(
          AppLocalizations.of(context)!.graph,
          style: GoogleFonts.poppins(fontSize: 20.sp),
        ),
      ),
      body: Center(
        child: BlocBuilder<AddTasksBloc, AddTasksState>(
          builder: (context, state) {
            if (state is AddTaskSuccess) {
              int totalTasks = state.task.length;
              int doneTasks = state.task.where((task) => task.done!).length;
              int incompleteTasks = totalTasks - doneTasks;

              double donePercentage = (doneTasks / totalTasks) * 100;
              double incompletePercentage =
                  (incompleteTasks / totalTasks) * 100;

              dataMap = {
                AppLocalizations.of(context)!.completedTasks: donePercentage,
                AppLocalizations.of(context)!.incompleteTask:
                    incompletePercentage,
              };
            }
            return PieChart(
              colorList: const [
                Color.fromARGB(255, 94, 185, 125),
                Color.fromARGB(255, 242, 136, 129)
              ],
              ringStrokeWidth: 30.w,
              animationDuration: const Duration(milliseconds: 5000),
              chartRadius: MediaQuery.of(context).size.width / 2,
              chartType: ChartType.ring,
              dataMap: dataMap,
              initialAngleInDegree: 50,
              chartValuesOptions: const ChartValuesOptions(
                showChartValuesInPercentage: true,
              ),
              legendOptions: LegendOptions(
                legendPosition: LegendPosition.bottom,
                legendTextStyle: GoogleFonts.poppins(
                    fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            );
          },
        ),
      ),
    );
  }
}
