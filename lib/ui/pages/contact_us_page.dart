import 'package:be_bold/constants/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return
    Theme(
        data: ThemeData(appBarTheme: const AppBarTheme(color: darkBlueColor1)),
    child: Scaffold(
     appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Contact Us',
          ),
        ),
      body: SafeArea(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Text(
                    'Visit the Be Bold Website link below:',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ),
           Padding(
             padding:const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
             child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Please visit:  ',
                                  style: TextStyle(color: Colors.black,fontSize: 16,
                          fontWeight: FontWeight.w500),
                                ),
                                TextSpan(
                                    text: 'beboldforjesus.com',
                                    style: const TextStyle(color: Colors.blue,decoration: TextDecoration.underline,fontSize: 16,
                          fontWeight: FontWeight.w500),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchUrlString(
                                            'https://beboldforjesus.com');
                                      }),
                               
                              ],
                            ),),
           ),
           Padding(
             padding:const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
             child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Contact us at:  ',
                                  style: TextStyle(color: Colors.black,fontSize: 16,
                          fontWeight: FontWeight.w500),
                                ),
                                TextSpan(
                                    text: 'contact@beboldforjesus.com',
                                    style: const TextStyle(color: Colors.blue,decoration: TextDecoration.underline,fontSize: 16,
                          fontWeight: FontWeight.w500),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        
                                        launchUrlString(
                                            'mailto:contact@beboldforjesus.com');
                                      }),
                               
                              ],
                            ),),
           )
      ],)) ));
  }
}