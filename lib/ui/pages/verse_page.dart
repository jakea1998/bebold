import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/ui/pages/reaffirmation_page.dart';
import 'package:be_bold/ui/widgets/app_bar.dart';
import 'package:be_bold/ui/widgets/continue_button.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class VersePage extends StatefulWidget {
  final Widget? child;
  const VersePage({Key? key,this.child}) : super(key: key);

  @override
  State<VersePage> createState() => _VersePageState();
}

class _VersePageState extends State<VersePage> {
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
              'Verse',
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(children: [
              /* Image.asset("lib/assets/blue_pattern.jpg",
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            ), */

              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5,),
                    widget.child ?? Container(),
                    ContinueButton(onTapped: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReaffirmationPage()));
                    },)
                  ],
                ),
              )
            ]),
          )),
    );
  }
}
