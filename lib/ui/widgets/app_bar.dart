import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/ui/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppBar1 extends StatelessWidget implements PreferredSizeWidget {
  final Widget leading;
  final String? title;
  final PreferredSizeWidget? bottom;
  AppBar1({Key? key, required this.leading, this.title, this.bottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: darkBlueColor1,
      leading: leading,
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Column(
            children: [
              Spacer(
                flex: 1,
              ),
              GestureDetector(
                onTap: () async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        )
      ],
      bottom: bottom != null ? bottom : null,
      title: title == null
          ?  Text(
              "BE BOLD",
              style: TextStyle(color: Colors.white),
            )
          :  Text(
              title ?? "",
              style: TextStyle(color: Colors.white),
            ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      title != null ? Size.fromHeight(85) : Size.fromHeight(55);
}
