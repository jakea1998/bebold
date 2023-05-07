import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/ui/pages/forgot_password_page.dart';
import 'package:be_bold/ui/pages/home_page.dart';
import 'package:be_bold/ui/pages/registration_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            Image.asset(
              'lib/assets/Be_bold.png',
              fit: BoxFit.fitHeight,
              height: 150,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 30, right: 30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
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
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Colors.grey,
                      ),
                      contentPadding: EdgeInsets.all(20),
                      hintText: "E-mail ID",
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
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 30, right: 30),
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
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.grey,
                      ),
                      contentPadding: EdgeInsets.all(20),
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
                    } catch (e) {
                      EasyLoading.dismiss();
                      EasyLoading.showError("Error logging in.",
                          dismissOnTap: true);
                    }
                    EasyLoading.dismiss();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
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
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 20),
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
                          builder: (context) => ForgotPasswordPage()));
                },
                child:const Text(
                  "Forgot Password?",
                  style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Row(
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
                              builder: (context) => RegistrationPage()));
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ],
            )
          ]),
        )),
      ),
    );
  }
}
