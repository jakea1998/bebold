import 'package:be_bold/blocs/user/user_bloc.dart';
import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/models/user_model.dart';
import 'package:be_bold/ui/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late FocusNode firstNameNode;
  late FocusNode lastNameNode;
  late FocusNode emailNode;
  late FocusNode passwordNode;
  late FocusNode confirmPasswordNode;
  bool signUpForNewsLetter = false;
  final formKey = GlobalKey<FormState>();
  final fbAuth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    firstNameNode = FocusNode();
    lastNameNode = FocusNode();
    emailNode = FocusNode();
    passwordNode = FocusNode();
    confirmPasswordNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SafeArea(
            child: Container(
                child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      )),
                  Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),
            Image.asset('lib/assets/logo_1.png',
                height: 40, fit: BoxFit.fitHeight),
            SizedBox(
              height: 20,
            ),
            Image.asset('lib/assets/Be_bold.png',
                height: 130, fit: BoxFit.fitHeight),
            Padding(
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
                        if (value == null || value.isEmpty) {
                          return "This field is required.";
                        }
                        return null;
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
                        if (value == null || value.isEmpty) {
                          return "This field is required.";
                        } else if (value.length <= 8) {
                          return "Please enter a password longer than 8 characters.";
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Password",
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
                      controller: passwordController,
                      focusNode: passwordNode,
                      enabled: true,
                      obscureText: false,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required.";
                        } else if (value != passwordController.text) {
                          return "Please enter the same password as above.";
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Confirm Password",
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
                      controller: confirmPasswordController,
                      focusNode: confirmPasswordNode,
                      enabled: true,
                      obscureText: false,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(children: [
                signUpForNewsLetter
                    ? IconButton(
                        icon: Icon(
                          Icons.check_circle,
                          color: Colors.green,
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  if (formKey.currentState?.validate() ?? false) {
                  
                     EasyLoading.show(status: 'Creating your Account...');
                    try {
                      final result = await fbAuth.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text);
                    if (result != null) {
                      final id = fbAuth.currentUser;
                      
                        UserModel user = UserModel(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        email: emailController.text,
                        phone: "",
                        address: "",
                        userId: id?.uid,
                        city: "",
                        state: "",
                        subscribeToNewsletter: signUpForNewsLetter,
                        zipcode: "",
                        creationDate: DateTime.now(),
                        notes: "");
                      BlocProvider.of<UserBloc>(context)
                          .add(UserEventCreateUser(userModel: user));
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                    } catch (e) {
                      EasyLoading.dismiss();
                      EasyLoading.showError("Error creating your Account.",
                          dismissOnTap: true);
                    }
                    EasyLoading.dismiss();
                    
                  }
                },
                child: Card(
                  elevation: 2,
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  color: lightBlueColor1,
                  child: Container(
                    width: 350,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Center(
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ))),
      ),
    );
  }
}
