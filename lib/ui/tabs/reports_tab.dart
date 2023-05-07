import 'package:be_bold/blocs/reports/reports_bloc.dart';
import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/ui/pages/reports_details_page.dart';
import 'package:be_bold/ui/widgets/rectangle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportsTab extends StatefulWidget {
  const ReportsTab({Key? key}) : super(key: key);

  @override
  State<ReportsTab> createState() => _ReportsTabState();
}

class _ReportsTabState extends State<ReportsTab> {
  DateTime? fromDate;
  String? fromDateString;
  DateTime? toDate;
  String? toDateString;

  Widget calendarIcon(
      {required String hintText,
      String? valueText,
      required VoidCallback onTapped}) {
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        height: 50,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                valueText ?? hintText,
                style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
              Spacer(
                flex: 1,
              ),
              Icon(
                Icons.calendar_month_outlined,
                size: 25,
                color: Colors.grey[800],
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border:
                Border.all(color: Colors.grey[800] ?? Colors.grey, width: 1)),
      ),
    );
  }

  List months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlocBuilder<ReportsBloc, ReportsState>(
        builder: (context, state) {
          return Column(
            children: [
              Text(
                'TODAY',
                style: TextStyle(
                    color: lightBlueColor1,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${months[DateTime.now().month - 1]} ${DateTime.now().day}, ${DateTime.now().year}',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              Rectangle(
                  title: "Witnessed",
                  number: (state.witnessed?.length ?? 0).toString()),
              SizedBox(
                height: 10,
              ),
              Rectangle(
                  title: "Accepted",
                  number: (state.accepted?.length ?? 0).toString()),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: calendarIcon(
                          hintText: "From",
                          valueText: state.startDate != null ? "${state.startDate!.month}-${state.startDate!.day}-${state.startDate!.year}" : null,
                          onTapped: () async {
                            fromDate = await showDatePicker(
                                context: context,
                                initialDate: state.startDate ?? DateTime.now(),
                                currentDate: DateTime.now(),
                                firstDate: DateTime(1970, 1, 1),
                                lastDate: DateTime(2070, 1, 1));
                            BlocProvider.of<ReportsBloc>(context).add(
                                ReportsEventUpdateDate(
                                    startDate: fromDate,
                                    endDate: state.endDate));
                            
                            
                          })),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: calendarIcon(
                          hintText: "To",
                          valueText: state.endDate != null ? "${state.endDate!.month}-${state.endDate!.day}-${state.endDate!.year}" : null,
                          onTapped: () async {
                            toDate = await showDatePicker(
                                context: context,
                                initialDate: state.endDate ?? DateTime.now(),
                                currentDate: DateTime.now(),
                                firstDate: DateTime(1970, 1, 1),
                                lastDate: DateTime(2070, 1, 1));
                            
                            BlocProvider.of<ReportsBloc>(context).add(
                                ReportsEventUpdateDate(
                                    startDate: state.startDate,
                                    endDate: toDate));
                           
                          }))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  if (state.startDate != null && state.endDate != null) {
                    if (state.startDate!.isBefore(state.endDate!)) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReportsDetailsPage(
                                  witnessed: state.witnessed ?? [],
                                  accepted: state.accepted ?? [],
                                  fromDateString: "${state.startDate!.month}-${state.startDate!.day}-${state.startDate!.year}",
                                  toDateString: "${state.endDate!.month}-${state.endDate!.day}-${state.startDate!.year}")));
                    }
                  }
                },
                child: Container(
                    height: 50,
                    width: double.infinity,
                    color: greenColor1,
                    child: Center(
                        child: Text(
                      "Reports",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ))),
              ),
            ],
          );
        },
      ),
    );
  }
}
