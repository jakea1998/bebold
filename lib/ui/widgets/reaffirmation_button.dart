
import 'package:be_bold/constants/colors.dart';
import 'package:flutter/material.dart';

class ReaffirmationButton extends StatelessWidget {
  final String title;
  final VoidCallback onTapped;
  const ReaffirmationButton({Key? key,required this.onTapped, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:12,horizontal: 20),
      child: GestureDetector(
        onTap: onTapped,
        child: Container(
        height: 50,
        child: Center(child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text("Start With This Prayer", style: TextStyle(color: darkBlueColor1,fontSize: 16,fontWeight: FontWeight.w400),),
              
                Icon(Icons.navigate_next,color: darkBlueColor1,size: 30,),
              
            ],),
        )),
        decoration: BoxDecoration(border: Border.all(color: darkBlueColor1,width: 1.5),borderRadius: BorderRadius.circular(5)),
      )),
    );
  }
}
