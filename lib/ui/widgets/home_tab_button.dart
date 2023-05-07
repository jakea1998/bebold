import 'package:be_bold/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeTabButton extends StatelessWidget {
  final String text;
  final VoidCallback onTapped;
  const HomeTabButton({Key? key, required this.text, required this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTapped,
        child: Card(
          elevation: 2,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          color: lightBlueColor1,
          child: Container(
            
            width: 350,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Text(
                      text,
                      style: TextStyle(color: Colors.white,fontSize: 20),
                    ),
                    Spacer(flex: 1,),
                    Icon(Icons.keyboard_arrow_right,color: Colors.white,size: 30,)
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
