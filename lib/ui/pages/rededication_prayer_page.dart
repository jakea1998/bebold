import 'package:be_bold/blocs/user/user_bloc.dart';
import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/ui/pages/user_info_page.dart';
import 'package:be_bold/ui/widgets/account_required_dialog.dart';
import 'package:be_bold/ui/widgets/continue_button.dart';
import 'package:be_bold/ui/widgets/prayer_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/prayer_title.dart';

class RededicationPrayerPage extends StatefulWidget {
  const RededicationPrayerPage({Key? key}) : super(key: key);

  @override
  State<RededicationPrayerPage> createState() => _RededicationPrayerPageState();
}

class _RededicationPrayerPageState extends State<RededicationPrayerPage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(appBarTheme: const AppBarTheme(color: darkBlueColor1)),
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const PrayerTitle(
                        title: "Rededication/Out of Fellowship Prayer"),
                    const SizedBox(
                      height: 7,
                    ),
                    const PrayerContent(
                        content:
                            "Father, in the Name of Jesus, I confess and acknowledge my sins before you.  I asked you to forgive me and cleanse me from all unrighteousness and wrong doing.  Because you are faithful and just; I know that my sins are forgiven and I am clean.  Father, you have no more remembrance of my past sins and I do not either.  I am free to live without the burden of the past.\nAmen."),
                    const SizedBox(
                      height: 7,
                    ),
                    ContinueButton(onTapped: () {
                      if (!(BlocProvider.of<UserBloc>(context)
                              .state
                              .userExists ??
                          false)) {
                        showDialog(
                            context: context,
                            builder: (context) => const AccountRequiredDialog(
                                title: "User Doesn't Exist",
                                text: "Please create an account or login."));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserInfoPage(isExisting: false,)));
                      }
                    })
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
