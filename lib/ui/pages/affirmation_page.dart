import 'package:be_bold/blocs/user/user_bloc.dart';
import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/ui/pages/rededication_prayer_page.dart';
import 'package:be_bold/ui/pages/salvation_prayer_page.dart';
import 'package:be_bold/ui/pages/user_info_page.dart';
import 'package:be_bold/ui/widgets/account_required_dialog.dart';
import 'package:be_bold/ui/widgets/continue_button.dart';
import 'package:be_bold/ui/widgets/reaffirmation_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AffirmationPage extends StatefulWidget {
  const AffirmationPage({Key? key}) : super(key: key);

  @override
  State<AffirmationPage> createState() => _AffirmationPageState();
}

class _AffirmationPageState extends State<AffirmationPage> {
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
          centerTitle: true,
          title: const Text(
            'Affirmation',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
                            builder: (context) => const SalvationPrayerPage()));
                  },
                  title: "Salvation Prayer"),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
                            builder: (context) =>
                                const RededicationPrayerPage()));
                  },
                  title: "Rededication/Out of Fellowship Prayer"),
              ContinueButton(onTapped: () {
                if (!(BlocProvider.of<UserBloc>(context).state.userExists ??
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
    );
  }
}
