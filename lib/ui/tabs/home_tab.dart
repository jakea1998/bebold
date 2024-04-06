import 'package:be_bold/ui/pages/witness_page/witness_page.dart';
import 'package:be_bold/ui/widgets/home_tab_button.dart';
import 'package:flutter/material.dart';


class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/BeBOLD_Logo.png',
                fit: BoxFit.fitHeight,
                height: 180,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'I Am Witnessing To:',
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
                            builder: (context) => const WitnessPage(
                                  title: "Acquaintance",
                                )));
                  }),
              HomeTabButton(text: "Family Member", onTapped: () {
                 Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WitnessPage(
                                  title: "Family Member",
                                )));
              }),
              HomeTabButton(text: "Friend", onTapped: () {
                 Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WitnessPage(
                                  title: "Friend",
                                )));
              }),
              HomeTabButton(text: "New Connection", onTapped: () {
                 Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WitnessPage(
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
