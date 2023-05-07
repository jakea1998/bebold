import 'package:be_bold/blocs/lives_changed/lives_changed_bloc.dart';
import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/models/user_model.dart';
import 'package:be_bold/ui/pages/home_page.dart';
import 'package:be_bold/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UserInfoPage extends StatefulWidget {
  final UserModel? userModel;
  const UserInfoPage({Key? key, this.userModel}) : super(key: key);

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
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
  UserStatus userStatus = UserStatus.witnessed;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    firstNameController = TextEditingController();
    lastNameController = TextEditingController();

    emailController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    cityController = TextEditingController();
    stateController = TextEditingController();
    zipController = TextEditingController();
    notesController = TextEditingController();
    firstNameNode = FocusNode();
    lastNameNode = FocusNode();
    emailNode = FocusNode();
    phoneNode = FocusNode();
    addressNode = FocusNode();
    cityNode = FocusNode();
    stateNode = FocusNode();
    zipNode = FocusNode();
    notesNode = FocusNode();
    if (widget.userModel != null) {
      firstNameController.text = widget.userModel?.firstName ?? "";
      lastNameController.text = widget.userModel?.lastName ?? "";
      emailController.text = widget.userModel?.email ?? "";
      phoneController.text = widget.userModel?.phone ?? "";
      addressController.text = widget.userModel?.address ?? "";
      cityController.text = widget.userModel?.city ?? "";
      stateController.text = widget.userModel?.state ?? "";
      zipController.text = widget.userModel?.zipcode ?? "";
      notesController.text = widget.userModel?.notes ?? "";
      signUpForNewsLetter = widget.userModel?.subscribeToNewsletter ?? false;
      userStatus = widget.userModel?.userStatus ?? UserStatus.witnessed;
    }
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
                              /* if (value == null || value.isEmpty) {
                            return validatorString;
                                          }
                                          return null; */
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
                              /* if (value == null || value.isEmpty) {
                          return validatorString;
                          }
                          return null; */
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
                    Text("Does this person accept Jesus as their Savior?")
                  ]),
                  Row(children: [
                    userStatus == UserStatus.accepted
                        ? IconButton(
                            icon: Icon(
                              Icons.check_circle,
                              color: darkBlueColor1,
                            ),
                            onPressed: () {
                              setState(() {
                                userStatus = UserStatus.witnessed;
                              });
                            })
                        : IconButton(
                            icon: Icon(
                              Icons.circle_outlined,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                userStatus = UserStatus.accepted;
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
                            UserModel user = UserModel(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                address: addressController.text,
                                userId: "",
                                city: cityController.text,
                                state: stateController.text,
                                subscribeToNewsletter: signUpForNewsLetter,
                                userStatus: userStatus,
                                 creationDate:widget.userModel !=null ? widget.userModel?.creationDate :
                                    DateTime.now(),
                                zipcode: zipController.text,
                                notes: notesController.text);
                            BlocProvider.of<LivesChangedBloc>(context)
                                .add(LivesChangedEventAddLive(model: user));
                          } catch (e) {
                            EasyLoading.dismiss();
                            EasyLoading.showError(
                                "Error saving user information.",
                                dismissOnTap: true);
                          }
                          EasyLoading.dismiss();

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                        tabIndex: 2,
                                      )));
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
