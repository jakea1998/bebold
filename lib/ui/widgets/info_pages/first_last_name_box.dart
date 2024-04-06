import 'package:be_bold/utils/spacing.dart';
import 'package:be_bold/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class FirstLastNameBox extends StatelessWidget {
  final bool editPressed;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final FocusNode firstNameNode;
  final FocusNode lastNameNode;
  
  const FirstLastNameBox(
      {super.key,
      required this.editPressed,
      required this.firstNameController,
      required this.lastNameController,
      required this.firstNameNode,
      required this.lastNameNode});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 0,
      child: SizedBox(
        height: 75,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:15,vertical:8.0),
          child: Row(
            children: [
              Icon(
                            FontAwesome.user_solid,
                            color: Colors.grey[800] ?? Colors.grey,
                            size: 22,
                          ),
              h_space_m,
              Expanded(
                child: editPressed
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                
                        children: [
                         
                          
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Spacer(flex:1),
                                  TextFormField(
                                  readOnly: !editPressed,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "This field is required.";
                                    }
                                    return null;
                                  },
                                  style: personalInfoTextStyle,
                                  textInputAction: TextInputAction.done,
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(0),
                                      hintText: "First Name",
                                      filled: false,
                                      isDense: true,
                                      labelStyle: personalInfoTextStyle,
                                      hintStyle: personalInfoTextStyle,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      )),
                                  controller: firstNameController,
                                  focusNode: firstNameNode,
                                  enabled: true,
                                  obscureText: false,
                                  maxLines: 1,
                                ),
                                const Spacer(flex: 1,)
                                ]
                              ),
                            ),
                          ),
                          h_space_s,
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Spacer(flex: 1,),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "This field is required.";
                                      }
                                      return null;
                                    },
                                    style: personalInfoTextStyle,
                                    textInputAction: TextInputAction.done,
                                    decoration: const InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(0),
                                        hintText: "Last Name",
                                        filled: false,
                                        hintStyle: personalInfoTextStyle,
                                        labelStyle: personalInfoTextStyle,
                                        enabledBorder:  UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          ),
                                          // borderRadius: BorderRadius.circular(30)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.blue,
                                          ),
                                        )),
                                    controller: lastNameController,
                                    focusNode: lastNameNode,
                                    enabled: true,
                                    obscureText: false,
                                    maxLines: 1,
                                  ),
                                  const Spacer(flex: 1,),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    : Row(
                        children: [
                          
                         
                          Text(
                            firstNameController.text,
                            style: personalInfoTextStyle
                          ),
                          h_space_s,
                          Text(
                            lastNameController.text,
                            style: personalInfoTextStyle
                          )
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
