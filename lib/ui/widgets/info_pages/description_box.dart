import 'package:be_bold/utils/spacing.dart';
import 'package:be_bold/utils/text_styles.dart';
import 'package:flutter/material.dart';

class DescriptionBox extends StatelessWidget {
  

  const DescriptionBox({
    super.key,
   
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 0,
        child: const Padding(
          padding:  EdgeInsets.symmetric(horizontal:15,vertical:8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
                  Text("In this section, write any pertinent information that will assist you with further ministry.",style:personalInfoTextStyle,),
                  v_space_s,
                  Text("Tips",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  v_space_s,
                  Text("If appropriate, get follow-up information to assist with discipleship.",style:personalInfoTextStyle,),
                  v_space_s,
                  Text("If appropriate, get follow-up information to share scriptures, give an invitation to a christian event, or extend an invite to your church.",style:personalInfoTextStyle,),
                
              
            ],
          ),
        ),
      ),
    );;
  }
}
