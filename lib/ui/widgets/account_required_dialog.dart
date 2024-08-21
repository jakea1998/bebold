import 'package:be_bold/ui/pages/login_page.dart';
import 'package:be_bold/ui/pages/registration_page.dart';
import 'package:be_bold/ui/widgets/continue_button.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class AccountRequiredDialog extends StatelessWidget {
  final String title;
  final String text;
  const AccountRequiredDialog(
      {super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: [
            GestureDetector(
              onTap: () {
                
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegistrationPage()));
              },
              child: Card(
                elevation: 2,
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: lightBlueColor1,
                child: const SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(12),
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
            GestureDetector(
              onTap: () {
                
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Card(
                elevation: 2,
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: lightBlueColor1,
                child: const SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Center(
                        child: Text(
                          "Log In",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ContinueButton(onTapped: () {
              Navigator.pop(context);
            })
          ],
        ));
  }
}
