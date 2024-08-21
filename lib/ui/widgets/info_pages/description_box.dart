import 'package:be_bold/ui/widgets/expandable_tab.dart';
import 'package:be_bold/utils/spacing.dart';
import 'package:be_bold/utils/text_styles.dart';
import 'package:flutter/material.dart';

/* class DescriptionBox extends StatelessWidget {
  const DescriptionBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DescriptionBox(
      title: "Description",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "In this section, write any pertinent information that will assist you with further ministry.",
            style: personalInfoTextStyle,
          ),
          v_space_s,
          Text(
            "Tips",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          v_space_s,
          Text(
            "If appropriate, get follow-up information to assist with discipleship.",
            style: personalInfoTextStyle,
          ),
          v_space_s,
          Text(
            "If appropriate, get follow-up information to share scriptures, give an invitation to a christian event, or extend an invite to your church.",
            style: personalInfoTextStyle,
          ),
        ],
      ),
      color: Colors.white,
    );
    /* SizedBox(
      height: 280,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 0,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "In this section, write any pertinent information that will assist you with further ministry.",
                style: personalInfoTextStyle,
              ),
              v_space_s,
              Text(
                "Tips",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              v_space_s,
              Text(
                "If appropriate, get follow-up information to assist with discipleship.",
                style: personalInfoTextStyle,
              ),
              v_space_s,
              Text(
                "If appropriate, get follow-up information to share scriptures, give an invitation to a christian event, or extend an invite to your church.",
                style: personalInfoTextStyle,
              ),
            ],
          ),
        ),
      ),
    ); */
    
  }
} */



class DescriptionBox extends StatefulWidget {
  
  
  const DescriptionBox({Key? key,})
      : super(key: key);

  @override
  State<DescriptionBox> createState() => _DescriptionBoxState();
}

class _DescriptionBoxState extends State<DescriptionBox> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: SizedBox(
            height: 75,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              child: Container(
                
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal:15),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline,color: Colors.black,),
                      const SizedBox(width: 8,),
                      const Expanded(
                        child: Text(
                          "More Information",
                          style: personalInfoTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        AnimatedContainer(
          duration:const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          child: isExpanded
              ? Card(
                  elevation: 0,
                  
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "In this section, write any pertinent information that will assist you with further ministry.",
                                style: personalInfoTextStyle,
                              ),
                              v_space_s,
                              Text(
                                "Click on the Witness Status button to show if the person you are witnessing to has accepted Jesus as their Savior.",
                                style: personalInfoTextStyle,
                              ),
                              v_space_s,
                              Text(
                                "Tips",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              v_space_s,
                              Text(
                                "If appropriate, get follow-up information to assist with discipleship.",
                                style: personalInfoTextStyle,
                              ),
                              v_space_s,
                              Text(
                                "If appropriate, get follow-up information to share scriptures, give an invitation to a christian event, or extend an invite to your church.",
                                style: personalInfoTextStyle,
                              ),
                            ],
                          ),))
              : Container(),
        )
      ],
    );
  }
}
