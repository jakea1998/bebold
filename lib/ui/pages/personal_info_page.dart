import 'package:be_bold/blocs/user/user_bloc.dart';
import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/models/user_model.dart' as model;
import 'package:be_bold/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PersonalInfoPage extends StatefulWidget {
  
  const PersonalInfoPage({Key? key}) : super(key: key);

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController zipController;
  late TextEditingController notesController;
  late FocusNode firstNameNode;
  late FocusNode lastNameNode;
  late FocusNode emailNode;
  late FocusNode phoneNode;
  late FocusNode addressNode;
  late FocusNode cityNode;
  late FocusNode stateNode;
  late FocusNode zipNode;
  late FocusNode notesNode;
  bool signUpForNewsLetter = false;
  model.UserStatus userStatus = model.UserStatus.na;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstNameController = TextEditingController(
        text: BlocProvider.of<UserBloc>(context).state.userModel?.firstName ??
            "");
    lastNameController = TextEditingController(
        text:
            BlocProvider.of<UserBloc>(context).state.userModel?.lastName ?? "");

    emailController = TextEditingController(
        text: BlocProvider.of<UserBloc>(context).state.userModel?.email ?? "");
    phoneController = TextEditingController(
        text: BlocProvider.of<UserBloc>(context).state.userModel?.phone ?? "");
    addressController = TextEditingController(
        text:
            BlocProvider.of<UserBloc>(context).state.userModel?.address ?? "");
    cityController = TextEditingController(
        text: BlocProvider.of<UserBloc>(context).state.userModel?.city ?? "");
    stateController = TextEditingController(
        text: BlocProvider.of<UserBloc>(context).state.userModel?.state ?? "");
    zipController = TextEditingController(
        text:
            BlocProvider.of<UserBloc>(context).state.userModel?.zipcode ?? "");
    notesController = TextEditingController(
        text: BlocProvider.of<UserBloc>(context).state.userModel?.notes ?? "");
    firstNameNode = FocusNode();
    lastNameNode = FocusNode();
    emailNode = FocusNode();
    phoneNode = FocusNode();
    addressNode = FocusNode();
    cityNode = FocusNode();
    stateNode = FocusNode();
    zipNode = FocusNode();
    notesNode = FocusNode();
    signUpForNewsLetter = BlocProvider.of<UserBloc>(context)
            .state
            .userModel
            ?.subscribeToNewsletter ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar1(
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required.";
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                hintText: "First Name",
                                filled: false,
                                labelStyle: TextStyle(color: Colors.black),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                  // borderRadius: BorderRadius.circular(30)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey[500] ?? Colors.grey,
                                  ),
                                )),
                            controller: firstNameController,
                            focusNode: firstNameNode,
                            enabled: true,
                            obscureText: false,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required.";
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                hintText: "Last Name",
                                filled: false,
                                labelStyle: TextStyle(color: Colors.black),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                  // borderRadius: BorderRadius.circular(30)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey[500] ?? Colors.grey,
                                  ),
                                )),
                            controller: lastNameController,
                            focusNode: lastNameNode,
                            enabled: true,
                            obscureText: false,
                            maxLines: 1,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        /* if (value == null || value.isEmpty) {
                          return validatorString;
                          }
                          return null; */
                      },
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      textInputAction: TextInputAction.done,
                      readOnly: true,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: "E-mail",
                          filled: false,
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            // borderRadius: BorderRadius.circular(30)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[500] ?? Colors.grey,
                            ),
                          )),
                      controller: emailController,
                      focusNode: emailNode,
                      enabled: false,
                      obscureText: false,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        /* if (value == null || value.isEmpty) {
                          return validatorString;
                          }
                          return null; */
                      },
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Phone",
                          filled: false,
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            // borderRadius: BorderRadius.circular(30)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[500] ?? Colors.grey,
                            ),
                          )),
                      controller: phoneController,
                      focusNode: phoneNode,
                      enabled: true,
                      obscureText: false,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        /* if (value == null || value.isEmpty) {
                          return validatorString;
                          }
                          return null; */
                      },
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Address",
                          filled: false,
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            // borderRadius: BorderRadius.circular(30)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[500] ?? Colors.grey,
                            ),
                          )),
                      controller: addressController,
                      focusNode: addressNode,
                      enabled: true,
                      obscureText: false,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        /* if (value == null || value.isEmpty) {
                          return validatorString;
                          }
                          return null; */
                      },
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: "City",
                          filled: false,
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            // borderRadius: BorderRadius.circular(30)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[500] ?? Colors.grey,
                            ),
                          )),
                      controller: cityController,
                      focusNode: cityNode,
                      enabled: true,
                      obscureText: false,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        /* if (value == null || value.isEmpty) {
                          return validatorString;
                          }
                          return null; */
                      },
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: "State",
                          filled: false,
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            // borderRadius: BorderRadius.circular(30)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[500] ?? Colors.grey,
                            ),
                          )),
                      controller: stateController,
                      focusNode: stateNode,
                      enabled: true,
                      obscureText: false,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        /* if (value == null || value.isEmpty) {
                          return validatorString;
                          }
                          return null; */
                      },
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Zip",
                          filled: false,
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            // borderRadius: BorderRadius.circular(30)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[500] ?? Colors.grey,
                            ),
                          )),
                      controller: zipController,
                      focusNode: zipNode,
                      enabled: true,
                      obscureText: false,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        /* if (value == null || value.isEmpty) {
                          return validatorString;
                          }
                          return null; */
                      },
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: "NOTES",
                          hintStyle: TextStyle(color: Colors.orange),
                          filled: true,
                          fillColor: Colors.grey[100],
                          labelStyle: TextStyle(color: Colors.orange),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            // borderRadius: BorderRadius.circular(30)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[500] ?? Colors.grey,
                            ),
                          )),
                      controller: notesController,
                      focusNode: notesNode,
                      enabled: true,
                      obscureText: false,
                      maxLines: 5,
                    ),
                  ),
                  Row(children: [
                    signUpForNewsLetter
                        ? IconButton(
                            icon: Icon(
                              Icons.check_circle,
                              color: darkBlueColor1,
                            ),
                            onPressed: () {
                              setState(() {
                                signUpForNewsLetter = false;
                              });
                            })
                        : IconButton(
                            icon: Icon(
                              Icons.circle_outlined,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                signUpForNewsLetter = true;
                              });
                            }),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Sign Up For News Letter")
                  ]),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        if (formKey.currentState?.validate() ?? false) {
                          EasyLoading.show(status: 'Saving...');
                          try {
                           model.UserModel user = model.UserModel(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                address: addressController.text,
                                userId: BlocProvider.of<UserBloc>(context)
                                        .state
                                        .userModel
                                        ?.userId ??
                                    "",
                                city: cityController.text,
                                state: stateController.text,
                                subscribeToNewsletter: signUpForNewsLetter,
                                userStatus: userStatus,
                                zipcode: zipController.text,
                                creationDate: BlocProvider.of<UserBloc>(context)
                                        .state
                                        .userModel
                                        ?.creationDate ??
                                    DateTime.now(),

                                notes: notesController.text);
                            BlocProvider.of<UserBloc>(context)
                                .add(UserEventCreateUser(userModel: user));
                          } catch (e) {
                            EasyLoading.dismiss();
                            EasyLoading.showError(
                                "Error saving user information.",
                                dismissOnTap: true);
                          }
                          EasyLoading.dismiss();
                          Navigator.pop(context);
                        }
                      },
                      child: Card(
                        elevation: 2,
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: greenColor1,
                        child: Container(
                          width: 350,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Center(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
