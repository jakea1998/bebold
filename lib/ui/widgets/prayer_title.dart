import 'package:flutter/material.dart';

class PrayerTitle extends StatelessWidget {
  final String title;
  const PrayerTitle({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(left:15,bottom: 8,top: 8),child: Text(title,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700,decoration: TextDecoration.underline),),);
  }
}