import 'package:flutter/material.dart';

import '../../../utils/spacing.dart';
import '../../../utils/text_styles.dart';

class NotesBox extends StatelessWidget {
  final bool editPressed;
  final TextEditingController notesController;
  final FocusNode notesNode;
  final double height;
  const NotesBox(
      {super.key,
      required this.editPressed,
      required this.notesController,
      required this.height,
      required this.notesNode});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Notes",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              v_space_m,
              Expanded(
                child: !editPressed
                    ? Column(children: [
                        Text(
                          notesController.text,
                          style: personalInfoTextStyle,
                        ),
                        const Spacer(
                          flex: 1,
                        )
                      ])
                    : TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required.";
                          }
                          return null;
                        },
                        style: personalInfoTextStyle,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          //isDense: true,
                          contentPadding: EdgeInsets.all(0),
                          hintText: "Enter any notes here...",
                          filled: false,
                          hintStyle: personalInfoTextStyle,
                          labelStyle: personalInfoTextStyle,
                          border: InputBorder.none,
                        ),
                        controller: notesController,
                        focusNode: notesNode,
                        expands: true,
                        enabled: true,
                        obscureText: false,
                        maxLines: null,
                      ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
