import 'dart:io';

import 'package:be_bold/blocs/lives_changed/lives_changed_bloc.dart';
import 'package:be_bold/blocs/user/user_bloc.dart';
import 'package:be_bold/ui/pages/about_us_page.dart';
import 'package:be_bold/ui/pages/contact_us_page.dart';
import 'package:be_bold/ui/widgets/more_tab_widget.dart';
import 'package:be_bold/ui/widgets/privacy_policy_terms_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:share_plus/share_plus.dart';

class MoreTab extends StatelessWidget {
  MoreTab({Key? key}) : super(key: key);

  final iconDatas = [
    //Icons.share_outlined,
    Icons.info_outline,
    Icons.phone_outlined,
    Icons.lock_outline,
    
    FontAwesome.trash_can
  ];
  final texts = [
    //"Share App",
    "About Us",
    "Contact Us",
    "Privacy Policy and Terms",
    
    "Delete Account"
  ];
  // set up the button

  // set up the AlertDialog
  getDeleteAccountDialog(BuildContext context) {
    return AlertDialog(
        title: const Text("Delete Account"),
        content: const Text("Are you sure you want to delete your account?"),
        actions: [
          TextButton(
            child: const Text("Yes"),
            onPressed: () {
              BlocProvider.of<UserBloc>(context).add(UserEventDeleteUser(
                  userModel:
                      BlocProvider.of<UserBloc>(context).state.userModel!,
                  livesChangedBloc:
                      BlocProvider.of<LivesChangedBloc>(context)));
            },
          ),
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ]);
  }
  Future<void> _onShare(BuildContext context)async{
    final box = context.findRenderObject() as RenderBox?;
  const iosLink = "https://apps.apple.com/us/app/be-bold-for-jesus/id1218692880";
  
  await Share.share(
  "Check out the Be Bold App:${Platform.isIOS ? iosLink : "https:www.google.com"}",
  subject: "Check out the Be Bold App!",
  sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
);
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return Builder(builder: (context) {
            return MoreTabWidget(
                iconData: iconDatas[index],
                text: texts[index],
                textColor: index == 3
                        ? Colors.red
                        : null,
                onTapped: () async {
                  /* if (index == 0) {
                    await _onShare(context);
                  } else  */if (index ==0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AboutUsPage()));
                  } else if (index == 1) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ContactUsPage()));
                  } else if (index == 2) {
                    showDialog(
                        context: context,
                        builder: (context) => const PrivacyTermsDialog());
                  
                  } else if (index == 3) {
                    showDialog(
                        context: context,
                        builder: (context) => getDeleteAccountDialog(context));
                  }
                });
          });
        },
        itemCount:
            (BlocProvider.of<UserBloc>(context).state.userExists ?? false)
                ? 4
                : 3);
  }
}
