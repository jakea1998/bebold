import 'package:be_bold/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ContinueButton extends StatelessWidget {
  final VoidCallback onTapped;
  const ContinueButton({Key? key,required this.onTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
                    padding: EdgeInsets.all(15),
                    child: GestureDetector(
                      onTap: onTapped,
                      child: Container(
                          height: 50,
                          width: double.infinity,
                          color: greenColor1,
                          child: Center(
                              child: Text(
                            "Continue",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ))),
                    ),
                  );
  }
}