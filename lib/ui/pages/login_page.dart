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
    final Size size = MediaQuery.of(context).size;
    final double content_width = size.width > 450 ? 450 : size.width - 60;
    final double content_height = content_width * 1.35;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: darkBlueColor1,
          centerTitle: true,
          
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "BE BOLD",
            style: TextStyle(color: Colors.white),
          )),
      body: Form(
        key: formKey,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: SizedBox(
            width: size.width,
            height: size.height -
                (kToolbarHeight + MediaQuery.of(context).padding.top),
            child: Center(
              child: SizedBox(
                width: content_width,
                height: content_height,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Image.asset(
                          'lib/assets/Be Bold Share Jesus.png',
                          fit: BoxFit.contain,
                          
                        ),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
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
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                       SizedBox(height: content_height*0.07,),
                      GestureDetector(
                        onTap: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            EasyLoading.show(status: 'Logging In...');
                            try {
                              await fbAuth.signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text);
                              BlocProvider.of<UserBloc>(context).add(
                                  UserEventLoadUser(
                                      livesChangedBloc:
                                          BlocProvider.of<LivesChangedBloc>(
                                              context)));
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
                          child: const SizedBox(
                            width: 350,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
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
                                    builder: (context) =>
                                        const ForgotPasswordPage()));
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ),

                     
                    ]),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
