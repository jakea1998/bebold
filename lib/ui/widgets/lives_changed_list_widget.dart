import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/models/user_model.dart';
import 'package:be_bold/ui/pages/user_info_page.dart';
import 'package:flutter/material.dart';

class LivesChangedListWidget extends StatelessWidget {
  final UserModel userModel;
  const LivesChangedListWidget({Key? key, required this.userModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserInfoPage(
                      userModel: userModel,
                    )));
      },
      child: Column(
        children: [
          Row(children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: Text("${userModel.firstName} ${userModel.lastName}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.navigate_next,
                color: Colors.grey,
                size: 30,
              ),
            )
          ]),
          Divider(
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
