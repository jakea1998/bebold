import 'package:flutter/material.dart';

class VerseContent extends StatelessWidget {
  final String content;
  const VerseContent({Key? key,required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left:15,bottom: 0,top: 0),child: Text(content,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),),);
  }
}