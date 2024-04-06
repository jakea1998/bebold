import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String text;
  const ErrorDialog({required this.title, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
     child:AlertDialog(
      title: Text(title,style: const TextStyle(fontWeight: FontWeight.bold),),
      content: Text(text,style: const TextStyle(fontWeight: FontWeight.normal),),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Card(
            elevation: 2,
            clipBehavior: Clip.hardEdge,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: lightBlueColor1,
            child: const SizedBox(
              width: double.infinity,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Center(
                    child: Text(
                      "Dismiss",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
