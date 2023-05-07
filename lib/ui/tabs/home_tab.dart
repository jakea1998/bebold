import 'package:be_bold/ui/pages/witness_page.dart';
import 'package:be_bold/ui/widgets/home_tab_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/BeBOLD_Logo.png',
                fit: BoxFit.fitHeight,
                height: 150,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'I Am Witnessing To A :',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              HomeTabButton(
                  text: "Acquaintance",
                  onTapped: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WitnessPage(
                                  title: "Acquaintance",
                                )));
                  }),
              HomeTabButton(text: "Family Member", onTapped: () {
                 Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WitnessPage(
                                  title: "Family Member",
                                )));
              }),
              HomeTabButton(text: "Friend", onTapped: () {
                 Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WitnessPage(
                                  title: "Friend",
                                )));
              }),
              HomeTabButton(text: "New Connection", onTapped: () {
                 Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WitnessPage(
                                  title: "New Connection",
                                )));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
