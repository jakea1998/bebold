import 'package:be_bold/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PrayerTitle extends StatelessWidget {
  final String title;
  const PrayerTitle({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left:15,bottom: 8,top: 8),child: Text(title,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700,decoration: TextDecoration.underline),),);
  }
}