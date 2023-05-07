import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/models/user_model.dart';
import 'package:be_bold/ui/pages/reports_details_list_page.dart';
import 'package:be_bold/ui/widgets/rectangle.dart';

import 'package:flutter/material.dart';


class ReportsDetailsPage extends StatefulWidget {
  final List<UserModel> witnessed;
  final List<UserModel> accepted;
  final String fromDateString;
  final String toDateString;
  const ReportsDetailsPage(
      {Key? key,
      required this.fromDateString,
      required this.toDateString,
      required this.witnessed,
      required this.accepted})
      : super(key: key);

  @override
  State<ReportsDetailsPage> createState() => _ReportsDetailsPageState();
}

class _ReportsDetailsPageState extends State<ReportsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(appBarTheme: AppBarTheme(color: darkBlueColor1)),
        child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'REPORT RANGE',
                    style: TextStyle(
                        color: lightBlueColor1,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${widget.fromDateString} TO ${widget.toDateString}',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                      onTap: () {
                        if (widget.witnessed.length > 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReportsDetailsListPage(
                                      people: widget.witnessed,
                                      title: "Witnessed")));
                        }
                      },
                      child: Rectangle(
                          title: "Witnessed",
                          number: widget.witnessed.length.toString())),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: (){
                      if (widget.accepted.length > 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReportsDetailsListPage(
                                      people: widget.accepted,
                                      title: "Accepted")));
                        }
                    },
                    child: Rectangle(
                        title: "Accepted",
                        number: widget.accepted.length.toString()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )));
  }
}
