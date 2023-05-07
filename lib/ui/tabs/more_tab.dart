import 'package:be_bold/ui/pages/contact_us_page.dart';
import 'package:be_bold/ui/widgets/more_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MoreTab extends StatelessWidget {
  MoreTab({Key? key}) : super(key: key);
  final iconDatas = [Icons.share_outlined, Icons.info_outline, Icons.phone];
  final texts = ['Share App', "About Us", "Contact Us"];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemBuilder: (context, index) {
            return MoreTabWidget(
                iconData: iconDatas[index],
                text: texts[index],
                onTapped: () {
                  print('tap');
                  if (index == 2) {
                    print('navigate');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactUsPage()));
                  }
                });
          },
          itemCount: 3),
    );
  }
}
