import 'package:be_bold/constants/colors.dart';
import 'package:flutter/material.dart';

class Rectangle extends StatelessWidget {
  const Rectangle({
    Key? key,
    required this.title,
    required this.number,
  }) : super(key: key);

  final String title;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkBlueColor1,
      width: double.infinity,
      height: 60,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 18),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              number,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
