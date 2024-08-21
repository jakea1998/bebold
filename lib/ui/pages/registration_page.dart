import 'package:be_bold/blocs/lives_changed/lives_changed_bloc.dart';
import 'package:be_bold/blocs/user/user_bloc.dart';
import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/constants/urls.dart';
import 'package:be_bold/models/user_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';

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
  bool agreeToTermsAndPrivacyPolicy = false;
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
    final Size size = MediaQuery.of(context).size;
    final double content_width = size.width > 450 ? 450 : size.width - 40;
    final double content_height = size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom < 800 ? size.height-MediaQuery.of(context).padding.top-MediaQuery.of(context).padding.bottom : 800;
    return  Scaffold(
      body: Form(
          key: formKey,
          child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: SizedBox(
          width: size.width,
          height: size.height 
              ,
          child: Center(
            child: SizedBox(
              width: content_width,
              height: content_height,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(top:20.0, bottom: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            )),
                        const Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Image.asset(
                      'lib/assets/Be Bold Share Jesus.png',
                      fit: BoxFit.contain,
                      
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "This field is required.";
                                  }
                                  return null;
                                },
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 16),
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    hintText: "First Name",
                                    filled: false,
                                    labelStyle:
                                        const TextStyle(color: Colors.black),
                                    enabledBorder: const UnderlineInputBorder(
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
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "This field is required.";
                                  }
                                  return null;
                                },
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 16),
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    hintText: "Last Name",
                                    filled: false,
                                    labelStyle:
                                        const TextStyle(color: Colors.black),
                                    enabledBorder: const UnderlineInputBorder(
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
                        padding: const EdgeInsets.symmetric(horizontal:0.0,vertical: 4),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "This field is required.";
                            }
                            return null;
                          },
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 16),
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              hintText: "E-mail",
                              filled: false,
                              labelStyle: const TextStyle(color: Colors.black),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
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
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "This field is required.";
                            } else if (value.length <= 8) {
                              return "Please enter a password longer than 8 characters.";
                            }
                            return null;
                          },
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 16),
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              hintText: "Password",
                              filled: false,
                              labelStyle: const TextStyle(color: Colors.black),
                              enabledBorder: const UnderlineInputBorder(
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
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "This field is required.";
                            } else if (value != passwordController.text) {
                              return "Please enter the same password as above.";
                            }
                            return null;
                          },
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 16),
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              hintText: "Confirm Password",
                              filled: false,
                              labelStyle: const TextStyle(color: Colors.black),
                              enabledBorder: const UnderlineInputBorder(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(children: [
                      signUpForNewsLetter
                          ? IconButton(
                              icon: const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                setState(() {
                                  signUpForNewsLetter = false;
                                });
                              })
                          : IconButton(
                              icon: const Icon(
                                Icons.circle_outlined,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  signUpForNewsLetter = true;
                                });
                              }),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text("Sign Up For News Letter")
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                    child: RichText(
                        text: TextSpan(
                            style: const TextStyle(color: Colors.black),
                            children: <TextSpan>[
                          const TextSpan(
                              text: 'By clicking Register, you agree to our '),
                          TextSpan(
                              text: 'Terms of Service',
                              style: const TextStyle(
                                color: darkBlueColor1,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  await launchUrl(Uri.parse(terms_of_service));
                                }),
                          const TextSpan(text: ' and '),
                          TextSpan(
                              text: 'Privacy Policy',
                              style: const TextStyle(
                                color: darkBlueColor1,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  await launchUrl(Uri.parse(privacy_policy));
                                }),
                        ])),
                  ),
                  const Spacer(flex: 1,),
                  Padding(
                    padding: const EdgeInsets.only(bottom:10.0),
                    child: GestureDetector(
                      onTap: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          EasyLoading.show(status: 'Creating your Account...');
                          try {
                            final result =
                                await fbAuth.createUserWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text);
                            if (result.user != null) {
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
                                ..add(UserEventCreateUser(userModel: user))
                                ..add(UserEventLoadUser(
                                    livesChangedBloc:
                                        BlocProvider.of<LivesChangedBloc>(
                                            context)));
              
                              EasyLoading.dismiss();
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          } catch (e) {
                            EasyLoading.dismiss();
                            EasyLoading.showError("Error creating your Account.",
                                dismissOnTap: true);
                          }
                        }
      
                      },
                      
                      child: Card(
                        elevation: 2,
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: lightBlueColor1,
                        child: const SizedBox(
                          width: 350,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Center(
                                child: Text(
                                  "Register",
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
        
      ),
    );
  }
}
