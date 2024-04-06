import 'package:be_bold/utils/spacing.dart';
import 'package:be_bold/utils/text_styles.dart';
import 'package:flutter/material.dart';

class PhoneBox extends StatelessWidget {
  final bool editPressed;
  final FocusNode phoneNode;
  final TextEditingController phoneController;
  const PhoneBox({super.key,required this.editPressed,required this.phoneNode,required this.phoneController});

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
              const Icon(Icons.phone,color: Colors.black,size: 25,),
              h_space_m,
              Expanded(
                child: editPressed ? TextFormField(
                  validator: (value) {
                    /* if (value == null || value.isEmpty) {
                                    return validatorString;
                                    }
                                    return null; */
                  },
                  style: personalInfoTextStyle,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      isDense: true,
                      hintText: "Phone",
                      filled: false,
                      
                                        labelStyle: personalInfoTextStyle,
                                        hintStyle: personalInfoTextStyle,
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
                  controller: phoneController,
                  focusNode: phoneNode,
                  enabled: true,
                  obscureText: false,
                  maxLines: 1,
                ) : Text(phoneController.text,style: personalInfoTextStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
