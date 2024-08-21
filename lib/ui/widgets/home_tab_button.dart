import 'package:be_bold/constants/colors.dart';
import 'package:flutter/material.dart';


class HomeTabButton extends StatelessWidget {
  final String text;
  final VoidCallback onTapped;
  const HomeTabButton({Key? key, required this.text, required this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 0,left:0,
        top:0),
      child: GestureDetector(
        onTap: onTapped,
        child: Card(
          elevation: 2,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          color: lightBlueColor1,
          child: SizedBox(
            
            width: double.infinity,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                child: Row(
                  children: [
                    Text(
                      text,
                      style: const TextStyle(color: Colors.white,fontSize: 20),
                    ),
                    const Spacer(flex: 1,),
                    const Icon(Icons.keyboard_arrow_right,color: Colors.white,size: 30,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
