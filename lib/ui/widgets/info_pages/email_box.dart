import 'package:be_bold/utils/spacing.dart';
import 'package:be_bold/utils/text_styles.dart';
import 'package:flutter/material.dart';

class EmailBox extends StatelessWidget {
  final String email;

  const EmailBox({
    super.key,
    required this.email
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:15,vertical:8.0),
          child: Row(
            children: [
              const Icon(Icons.email,color: Colors.black,size: 25,),
              h_space_m,
              Expanded(
                child: Text(email,style:personalInfoTextStyle,),
              ),
            ],
          ),
        ),
      ),
    );;
  }
}
