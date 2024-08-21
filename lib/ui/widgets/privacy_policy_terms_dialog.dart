import 'package:be_bold/constants/urls.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../constants/colors.dart';

class PrivacyTermsDialog extends StatelessWidget {
  
  const PrivacyTermsDialog({ super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
     child:AlertDialog(
      title: const Text("Privacy Policy and Terms",style: TextStyle(fontWeight: FontWeight.bold),),
      content: const Text("View our Privacy Policy and Terms of Service below. ",style: TextStyle(fontWeight: FontWeight.normal),),
      actions: [
        GestureDetector(
              onTap: () async{
                await launchUrlString(
                      privacy_policy);
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
                          "Privacy Policy",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          GestureDetector(
              onTap: () async {
                 
                  
                  await launchUrlString(
                      terms_of_service);
                
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
                          "Terms of Service",
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
            Navigator.pop(context);
          },
          child: Card(
            elevation: 2,
            clipBehavior: Clip.hardEdge,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: lightBlueColor1,
            child: const SizedBox(
              width: double.infinity,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Center(
                    child: Text(
                      "Dismiss",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
