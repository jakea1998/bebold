import 'package:flutter/material.dart';

class EditSaveButton extends StatelessWidget {
  final bool editPressed;
  final Function() onTap;
  const EditSaveButton(
      {super.key, required this.editPressed, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: SizedBox(
        width: 85,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: editPressed
                ? const Row(
                    children: [
                      Icon(Icons.save_outlined,size:20),
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        "Save",
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                      )
                    ],
                  )
                : const Row(
                    children: [
                      Icon(Icons.edit,size: 20,),
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        "Edit",
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
