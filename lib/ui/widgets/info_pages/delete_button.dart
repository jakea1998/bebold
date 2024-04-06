import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  
  final Function() onTap;
  const DeleteButton(
      {super.key,  required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: SizedBox(
        width: 105,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 0,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
                    children: [
                      Icon(Icons.delete,size: 20,),
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        "Delete",
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
