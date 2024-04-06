import 'package:be_bold/utils/spacing.dart';
import 'package:be_bold/utils/text_styles.dart';
import 'package:flutter/material.dart';

class AddressBox extends StatelessWidget {
  final bool editPressed;
  final FocusNode addressNode;
  final FocusNode cityNode;
  final FocusNode stateNode;
  final TextEditingController addressController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  const AddressBox(
      {super.key,
      required this.editPressed,
      required this.addressNode,
      required this.cityNode,
      required this.stateNode,
      required this.addressController,
      required this.cityController,
      required this.stateController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: editPressed?200:150,
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 0,
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Address",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              v_space_m,
              Expanded(
                child: editPressed ? Column(children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
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
                            hintText: "Address",
                            isDense: true,
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
                        controller: addressController,
                        focusNode: addressNode,
                        enabled: true,
                        obscureText: false,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
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
                            hintText: "City",
                            isDense: true,
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
                        controller: cityController,
                        focusNode: cityNode,
                        enabled: true,
                        obscureText: false,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          /* if (value == null || value.isEmpty) {
                                        return validatorString;
                                        }
                                        return null; */
                        },
                        style: personalInfoTextStyle,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                            contentPadding:  EdgeInsets.all(0),
                            hintText: "State",
                            filled: false,
                            isDense: true,
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
                        controller: stateController,
                        focusNode: stateNode,
                        enabled: true,
                        obscureText: false,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ]) : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  
                  Text(addressController.text,style: personalInfoTextStyle),
                  v_space_s,
                  Text(cityController.text, style: personalInfoTextStyle),
                  v_space_s,
                  Text(stateController.text, style: personalInfoTextStyle)
                ],),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
