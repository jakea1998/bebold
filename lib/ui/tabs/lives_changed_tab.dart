import 'package:be_bold/blocs/lives_changed/lives_changed_bloc.dart';
import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/models/user_model.dart';
import 'package:be_bold/ui/pages/personal_info_page.dart';
import 'package:be_bold/ui/pages/reaffirmation_page.dart';
import 'package:be_bold/ui/pages/user_info_page.dart';
import 'package:be_bold/ui/widgets/lives_changed_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LivesChangedTab extends StatefulWidget {
  const LivesChangedTab({Key? key}) : super(key: key);

  @override
  State<LivesChangedTab> createState() => _LivesChangedTabState();
}

class _LivesChangedTabState extends State<LivesChangedTab> {
  final double buttonDiameter = 80;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserInfoPage()));
                        },
                        child: Container(
                          width: buttonDiameter,
                          height: buttonDiameter,
                          child: Center(
                              child: Icon(Icons.add,
                                  size: 70, color: darkBlueColor1)),
                          decoration: BoxDecoration(
                              border: Border.fromBorderSide(
                                  BorderSide(color: darkBlueColor1, width: 3)),
                              borderRadius:
                                  BorderRadius.circular(buttonDiameter / 2)),
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        'Create New',
                        style: TextStyle(color: darkBlueColor1, fontSize: 20),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        "Lives Changed :",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    )
                  ],
                ),
                 Divider(
                              color: Colors.black,
                            ),
                Expanded(
                  child: BlocBuilder<LivesChangedBloc, LivesChangedState>(
                    builder: (context, state) {
                      if ((state.models?.length ?? 0) > 0)
                        return ListView.builder(
                          itemCount: state.models?.length,
                          itemBuilder: ((context, index) {
                            return LivesChangedListWidget(
                                userModel: state.models?[index] ?? UserModel());
                          }),
                        );
                      else
                        return Container(
                            child: Column(
                          children: [
                           
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text('No Lives Changed yet!'),
                            )
                          ],
                        ));
                    },
                  ),
                )
              ],
            )));
  }
}
