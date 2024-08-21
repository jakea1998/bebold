import 'package:be_bold/ui/pages/witness_page/witness_page.dart';
import 'package:be_bold/ui/widgets/home_tab_button.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double content_width = size.width > 450 ? 450 : size.width - 60;
    final double content_height = content_width * 1.45;

    return SafeArea(
      child: SizedBox(
        width: size.width,
        child: Center(
          child: SizedBox(
            width: content_width,
            height: content_height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  
                  padding: const EdgeInsets.only(right:8.0),
                  child: Image.asset(
                    'lib/assets/Be Bold Share Jesus.png',
                    
                                  fit: BoxFit.fitWidth,
                                  
                                  
                                ),
                ),
                const Spacer(flex: 1,),
                const Text(
                  'I Am Witnessing To:',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: content_height*0.013,),
                HomeTabButton(
                    text: "Acquaintance",
                    onTapped: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WitnessPage(
                                    title: "Acquaintance",
                                  )));
                    }),
                    SizedBox(height: content_height*0.013,),
                HomeTabButton(
                    text: "Family Member",
                    onTapped: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WitnessPage(
                                    title: "Family Member",
                                  )));
                    }),
                    SizedBox(height: content_height*0.013,),
                HomeTabButton(
                    text: "Friend",
                    onTapped: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WitnessPage(
                                    title: "Friend",
                                  )));
                    }),
                    SizedBox(height: content_height*0.013,),
                HomeTabButton(
                    text: "New Connection",
                    onTapped: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WitnessPage(
                                    title: "New Connection",
                                  )));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
