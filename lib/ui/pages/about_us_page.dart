import 'package:be_bold/constants/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Theme(
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
                'About Us',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: SafeArea(
                child: Scrollbar(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                                controller: _scrollController,
                              
                                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      child: Text(
                          '\nWe believe we are to empower, train, and encourage believers to boldly and effectively share the message of salvation through Jesus Christ.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: '\nThe ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                              text: 'Be Bold',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900),
                            ),
                            TextSpan(
                              text:
                                  ' app was created to assist Believers, Churches, Missionaries, and Evangelism Teams in sharing the love of God and the gift of Jesus with the world.',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      child: Text(
                          '\nWe believe that boldness has a voice-as it echoes faith living in the heart.  Therefore, no believer should be silent.  Rather, as an act of faith, every believer should live a life of Evangelism, obeying the Great Commission, and increasing God\'s family!',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      child: Text(
                          '\nWe encourage every Believer to use their voice to share God\'s love, Jesus\'s sacrifice, and the benefits of being a Christian with others.  Therefore, lift your voice and live out the boldness within!',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      child: Text('\nMatthew 24:14, Acts 4:33, Mark 16:15-20',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      child: Text('\nVisit the Be Bold Website below:',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: '\nPlease visit:  ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                                text: 'Beboldforjesus.com',
                                style: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launchUrlString('https://beboldforjesus.com');
                                  }),
                          ],
                        ),
                      ),
                    )
                  ],
                                ),
                              ),
                ))));
  }
}
