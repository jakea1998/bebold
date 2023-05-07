import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/ui/widgets/app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;

  late FocusNode emailNode;

  FirebaseAuth fbAuth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();

    emailNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: BackButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
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
              child: Column(children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 30, right: 30, bottom: 0, top: 20),
                  child: Text(
                    "Please enter your E-mail ID below to reset your password.  An E-mail will be sent to you with further instructions.",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 15, right: 15),
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
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        EasyLoading.show(
                            status: 'Sending password reset E-mail...');
                        try {
                          await fbAuth.sendPasswordResetEmail(
                            email: emailController.text,
                          );
                        } catch (e) {
                          EasyLoading.dismiss();
                          EasyLoading.showError("Error sending password reset E-mail.",
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
                      color: lightBlueColor1,
                      child: Container(
                        width: 350,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Center(
                              child: Text(
                                "Reset Password",
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
              ]),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ));
  }
}
