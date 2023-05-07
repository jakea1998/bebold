import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class VerseListWidget extends StatelessWidget {
  final List<String> verses;
  final String title;
  final VoidCallback onTapped;
  const VerseListWidget(
      {Key? key,
      required this.verses,
      required this.title,
      required this.onTapped})
      : super(key: key);
  String _verseString() {
    String s = "";
    verses.forEach((element) {
      if (verses.indexOf(element) == verses.length - 1) {
        s += "$element";
      } else {
        s += "$element, ";
      }
    });
    return s;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: 
          onTapped
        ,
        child: Column(

          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.format_align_center,
                    size: 30,
                    color: Colors.grey[700],
                  ),
                  SizedBox(width: 30,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(title,style:TextStyle(color: Colors.black,fontSize: 18)), 
                    SizedBox(
                      width: MediaQuery.of(context).size.width-160,
                      child: Text(_verseString(),style:TextStyle(color: Colors.grey[700],fontSize: 14,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis)))],
                  ),
                  Spacer(flex: 1,),
                  Icon(Icons.navigate_next,color: Colors.grey,size: 40,)
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 12,
            )
          ],
        ));
  }
}
