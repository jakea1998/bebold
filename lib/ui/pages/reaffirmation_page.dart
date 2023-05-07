import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/ui/pages/rededication_prayer_page.dart';
import 'package:be_bold/ui/pages/salvation_prayer_page.dart';
import 'package:be_bold/ui/pages/user_info_page.dart';
import 'package:be_bold/ui/widgets/continue_button.dart';
import 'package:be_bold/ui/widgets/reaffirmation_button.dart';
import 'package:flutter/material.dart';

class ReaffirmationPage extends StatefulWidget {
  const ReaffirmationPage({Key? key}) : super(key: key);

  @override
  State<ReaffirmationPage> createState() => _ReaffirmationPageState();
}

class _ReaffirmationPageState extends State<ReaffirmationPage> {
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
          title: Text(
            'Reaffirmation',
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: Text(
                  'Pray the Salvation Prayer with the person(s) you are witnessing to.',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              ReaffirmationButton(
                  onTapped: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SalvationPrayerPage()));
                  },
                  title: "Start With This Prayer"),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: Text(
                    'Pray the Rededication Prayer with the person(s) you are witnessing to.',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ),
              ReaffirmationButton(
                  onTapped: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RededicationPrayerPage()));
                  },
                  title: "Start With This Prayer"),
              ContinueButton(onTapped: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserInfoPage()));
              })
            ],
          ),
        ),
      ),
    );
  }
}
