import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/models/user_model.dart';
import 'package:be_bold/ui/widgets/lives_changed_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ReportsDetailsListPage extends StatefulWidget {
  final String title;
  final List<UserModel> people;
  const ReportsDetailsListPage(
      {Key? key, required this.people, required this.title})
      : super(key: key);

  @override
  State<ReportsDetailsListPage> createState() => _ReportsDetailsListPageState();
}

class _ReportsDetailsListPageState extends State<ReportsDetailsListPage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(appBarTheme: AppBarTheme(color: darkBlueColor1)),
      child: Scaffold(
          appBar: AppBar(
            title: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        "${widget.title}:",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
            leading: BackButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                /* Row(
                  children: [
                    
                    Spacer(
                      flex: 1,
                    )
                  ],
                ),
                Divider(
                  color: Colors.black,
                ), */
                Expanded(child: ListView.builder(
                          itemCount: widget.people.length,
                          itemBuilder: ((context, index) {
                            return LivesChangedListWidget(
                                userModel: widget.people[index]);
                          }),
                        ),)
              ],
            ),
          )),
    );
  }
}
