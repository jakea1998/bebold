import 'package:be_bold/constants/colors.dart';
import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  final VoidCallback onTapped;
  const ContinueButton({Key? key,required this.onTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
                    padding: const EdgeInsets.all(15),
                    child: GestureDetector(
                      onTap: onTapped,
                      child: Container(
                          height: 50,
                          width: double.infinity,
                          color: greenColor1,
                          child: const Center(
                              child: Text(
                            "Continue",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ))),
                    ),
                  );
  }
}