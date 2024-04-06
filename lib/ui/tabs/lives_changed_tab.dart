import 'package:be_bold/blocs/lives_changed/lives_changed_bloc.dart';
import 'package:be_bold/blocs/user/user_bloc.dart';
import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/models/user_model.dart';
import 'package:be_bold/ui/pages/user_info_page.dart';
import 'package:be_bold/ui/widgets/account_required_dialog.dart';
import 'package:be_bold/ui/widgets/lives_changed_list_widget.dart';
import 'package:flutter/material.dart';

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
        child: SizedBox(
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
                          if(BlocProvider.of<UserBloc>(context).state.userExists ?? false){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UserInfoPage(isExisting: false,)));
                          } else {
                            showDialog(
                        context: context,
                        builder: (context) => const AccountRequiredDialog(
                            title: "User Doesn't Exist",
                            text: "Please create an account or login."));
                          }
                          
                        },
                        child: Container(
                          width: buttonDiameter,
                          height: buttonDiameter,
                          decoration: BoxDecoration(
                              border: const Border.fromBorderSide(
                                  BorderSide(color: darkBlueColor1, width: 3)),
                              borderRadius:
                                  BorderRadius.circular(buttonDiameter / 2)),
                          child: const Center(
                              child: Icon(Icons.add,
                                  size: 70, color: darkBlueColor1)),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      const Text(
                        'Create New',
                        style: TextStyle(color: darkBlueColor1, fontSize: 20),
                      )
                    ],
                  ),
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        "Lives Changed:",
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
                const Divider(
                  color: Colors.black,
                ),
                Expanded(
                  child: BlocBuilder<LivesChangedBloc, LivesChangedState>(
                    builder: (context, state) {
                      if ((state.models?.length ?? 0) > 0) {
                        return ListView.builder(
                          itemCount: state.models?.length,
                          itemBuilder: ((context, index) {
                            return LivesChangedListWidget(
                                userModel: state.models?[index] ?? UserModel());
                          }),
                        );
                      } else {
                        return  const Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text('No Lives Changed yet!'),
                            )
                          ],
                        );
                      }
                    },
                  ),
                )
              ],
            )));
  }
}
