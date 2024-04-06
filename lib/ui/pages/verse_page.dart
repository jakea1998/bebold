import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/ui/pages/affirmation_page.dart';
import 'package:be_bold/ui/widgets/continue_button.dart';
import 'package:flutter/material.dart';

class VersePage extends StatefulWidget {
  final Widget? child;
  const VersePage({Key? key, this.child}) : super(key: key);

  @override
  State<VersePage> createState() => _VersePageState();
}

class _VersePageState extends State<VersePage> {
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
            title: const Text(
              'Verse',style: TextStyle(color: Colors.white),
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            color: const Color.fromARGB(255, 126, 166, 234),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  widget.child ?? Container(),
                  ContinueButton(
                    onTapped: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AffirmationPage()));
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
