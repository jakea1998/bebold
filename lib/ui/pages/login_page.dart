import 'package:be_bold/blocs/lives_changed/lives_changed_bloc.dart';
import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/ui/pages/forgot_password_page.dart';
import 'package:be_bold/ui/pages/home_page.dart';
import 'package:be_bold/ui/pages/registration_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../blocs/user/user_bloc.dart';
import '../../models/user_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode emailNode;
  late FocusNode passwordNode;
  FirebaseAuth fbAuth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailNode = FocusNode();
    passwordNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: darkBlueColor1,
          centerTitle: true,
          title: Image.asset(
            'lib/assets/logo_1.png',
            color: Colors.white,
            height: 30,
            fit: BoxFit.fitHeight,
          )),
      body: Form(
        key: formKey,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 80,
            child: Column(children: [
              Image.asset(
                'lib/assets/Be_bold.png',
                fit: BoxFit.fitHeight,
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required.";
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: Colors.grey,
                        ),
                        contentPadding: const EdgeInsets.all(20),
                        hintText: "E-mail ID",
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
                    controller: emailController,
                    focusNode: emailNode,
                    enabled: true,
                    obscureText: false,
                    maxLines: 1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required.";
                      } else if (value != passwordController.text) {
                        return "Please enter the same password as above.";
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Colors.grey,
                        ),
                        contentPadding: const EdgeInsets.all(20),
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
                    obscureText: true,
                    maxLines: 1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      EasyLoading.show(status: 'Logging In...');
                      try {
                        await fbAuth.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);
                        BlocProvider.of<UserBloc>(context).add(UserEventLoadUser(
                          livesChangedBloc:
                              BlocProvider.of<LivesChangedBloc>(context)));
                        EasyLoading.dismiss();
                      
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } catch (e) {
                        EasyLoading.dismiss();
                        EasyLoading.showError("Error logging in.",
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
                    child: Container(
                      width: 350,
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Center(
                            child: Text(
                              "Login",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage()));
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),

              /*  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child:  Text(
                      "Don't have an account?",
                      style:  TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegistrationPage()));
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                ],
              ), */
              /*  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child:  Text(
                      "Or",
                      style:  TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        
                        
                      EasyLoading.show(status: 'Logging In...');
                      try {
                        await fbAuth.signInAnonymously(
                            );
                        final id = fbAuth.currentUser;
            
                      UserModel user = UserModel(
              userId: id?.uid,
              address: "",
              firstName: "",
              lastName: "",
              email: "",
              phone: "",
              city: "",
              state: "",
              zipcode: "",
              notes: "",
              subscribeToNewsletter: false,
              creationDate: DateTime.now());
          
                      BlocProvider.of<UserBloc>(context)
                          .add(UserEventCreateUser(userModel: user));
                      EasyLoading.dismiss();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const HomePage()));
                      } catch (e) {
                        EasyLoading.dismiss();
                        EasyLoading.showError("Error logging in.",
                            dismissOnTap: true);
                      }
                      
                          
                      },
                      child: const Text(
                        "Skip Login",
                        style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                ],
              ) */
            ]),
          ),
        )),
      ),
    );
  }
}
