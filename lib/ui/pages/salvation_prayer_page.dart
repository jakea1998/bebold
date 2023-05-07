import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/ui/pages/user_info_page.dart';
import 'package:be_bold/ui/widgets/continue_button.dart';
import 'package:be_bold/ui/widgets/prayer_content.dart';
import 'package:be_bold/ui/widgets/prayer_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SalvationPrayerPage extends StatefulWidget {
  const SalvationPrayerPage({Key? key}) : super(key: key);

  @override
  State<SalvationPrayerPage> createState() => _SalvationPrayerPageState();
}

class _SalvationPrayerPageState extends State<SalvationPrayerPage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(appBarTheme: AppBarTheme(color: darkBlueColor1)),
      child: Scaffold(
       appBar:AppBar(
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
              padding: const EdgeInsets.symmetric(horizontal: 5,vertical:15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PrayerTitle(title: "Salvation Prayer"),
                  SizedBox(height: 7,),
                  PrayerContent(content: "I believe that God sent His Son Jesus to die on the cross for me and for my sins.  I believe that Jesus rose from the dead and He is alive now.  Jesus, I ask you to come into my heart now and make me new.  I believe that you are my Lord and Savior.  I say with my mouth and I believe in my heart that I am saved and in right standing with God.  I have become His son/daughter.\nAmen."),
                  SizedBox(height: 7,),
                  ContinueButton(onTapped: (){
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserInfoPage()));
                  })
                  
                ],),
            ),
          ),
        ),
      ));
  }
}