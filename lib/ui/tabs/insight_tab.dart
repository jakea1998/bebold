import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/ui/widgets/expandable_tab.dart';
import 'package:be_bold/utils/underline_string.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class InsightTab extends StatefulWidget {
  const InsightTab({Key? key}) : super(key: key);

  @override
  State<InsightTab> createState() => _InsightTabState();
}

class _InsightTabState extends State<InsightTab> {
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            Spacer(flex: 1,),
            Padding(
    padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
    child: Text(
      'Insight',
      style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: 18),
    ),
    ),
    Spacer(flex: 1,),
          ],
        ),
        ExpandableTab(
          title: "Next Steps After Witnessing",
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'After a person confesses Jesus as their Lord and Savior:\n\n1. Convey to them the importance of praying daily to God - simply talking to him from their heart.\n\n2. Help them to understand that, because they have received salvation, they were also received into a family.  God became their father; Jesus became their brother and the Holy Spirit came to live in their heart.  As a result, they are now God\'s son or daughter.  They were brought into a relationship with Him.  God desires to spend time with them.  He wants to communicate with them, lead them, guide them and show them how much He loves them.\n\n3. Express to them how important it is to read chapters from the Bible on a daily basis.  Start with the gospel of St. John.\n\n4. Advise them to attend a Bible teaching church.  Invite them to your church if they don\'t have one.\n\n5. Express the importance of surrounding themselves with strong believers.  This is for spiritual growth and accountability.',
              softWrap: true,
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        ExpandableTab(
          title: "Follow-up Instructions",
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '1. Ask if they have a Bible.  If not, be sure to purchase and mail one to them immediately.\n\n2. Give or mail them a booklet on the topic of salvation from your church or Christian bookstore.\n\n3. Give or mail them a Christian book on topics that address their needs/ issues.\n\n4. Invite them to plays, concerts, meetings, etc. in the area for fellowship.\n\n5. Email them encouraging scriptures.\n\n6. Pray for their growth in Christ; start with Colossians 1:9-12.  Pray also for issues they have shared with you in conversation.\n\n7. Call them periodically.  Show that you care and ask how things are going.  Pray for them.',
              softWrap: true,
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        ExpandableTab(
          title: "Handling Rejection",
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'When ministering to others, there will be times that they won\'t receive from you, but keep in mind, you have either planted or watered a seed.  It is never wasted and don\'t throw in the towel or give up because it "seemed" unsuccessful.\n\nRemember God\'s Word is spirit and life.  His Word penetrates the hearers\' spirit.  When the person hears God\'s Word, but makes a decision to reject the Word that is heard, they are not rejecting you; they are rejecting the gift of Jesus and the provision of God.\n\nGive it time.  The seeds from God\'s Word will grow.  You may not always see the results of the seeds you have sown, but remember, "God\'s Word will not return unto Him void..."-Isaiah 55:11.\n\nKeep in mind Romans 1:16 that says, "For I am not ashamed of the gospel of Christ: for it is the power of God unto salvation to everyone that believeth; to the Jew first, and also to the Greek."\n\nContinue to "Be BOLD" and share Jesus!',
              softWrap: true,
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        ExpandableTab(
          title: "The Power of your story!",
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Sharing your personal testimony is one of the most powerful witnessing tools there is! When you\'re able to relate to the person.... when you\'re able to share that you have experienced the same life challenge(s), you become living proof that God can and will bring you through and deliver you out of the situation.\n\nWhen telling your story, simply share that you know how they must feel.  Give them details of your own story and what happened in your life.  Transparency will help the person you\'re witnessing to see that they are not alone and that others have also experienced the same.  When you openly share your personal testimony, you become their evidence of the power of God to change...to heal and to make new!\n\nMany people are waiting to hear what God has done for you.  BE BOLD and share your story!',
              softWrap: true,
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        ExpandableTab(
          title: "Prayers, declaration, and Scriptures",
          body: Column(children: [
            ExpandableTab(title: "Just For You", body: Column(
              children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text.rich(
    TextSpan(
      children: [
        TextSpan(
            text: 'Prayers:\n',
            style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: 'Father, in the Name of Jesus,\n\n'),
        TextSpan(text: 'As a laborer together with you, and your fellow worker, I ask you to strengthen me with the power of the Holy Spirit to boldly witness of Jesus as an ambassador for Christ.  As I witness to others, may I be filled with your peace, your wisdom, and most of all, your love.  I yield myself to be led, guided and used by your Spirit.  In Jesus\' Name.  Amen.\n\n'),
        TextSpan(
            text: 'Declaration:\n',
            style: TextStyle(fontWeight: FontWeight.bold)),
        
        TextSpan(text: 'I declare in Jesus\' Name that I will do the great commission.  I declare that I will preach the truth of the gospel.  I declare that because I am a believer in Christ that signs will follow me.  I expect Jesus to confirm the word that we are sharing with signs following, as we work together to win the lost, and those who are out of fellowship or backslidden.\n\n'),
         TextSpan(
            text: 'Scriptures to Pray Over Yourself:\n',
            style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: '1 Corinthians 3:9, 2 Corinthians 5:17-20, Mark 16:15, 17-20, and Hebrews 2:4'),
      ],
    ),
  ),
                  )
               // Padding(padding: EdgeInsets.only(left:15,bottom: 8,top: 8),child: Text("Prayer",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w700,decoration: TextDecoration.underline),),)
                /* Text("Father, in the name of Jesus",softWrap: true,
                style: 
             TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),,), */
              ],
            )),
            ExpandableTab(title: "For The Unsaved", body: Column(
              children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text.rich(
    TextSpan(
      children: [
        
        TextSpan(text: 'Father, in the Name of Jesus, I pray for '),
        TextSpan(text: "${getUnderlineString(length:20)}",style: TextStyle(decoration: TextDecoration.underline)),
        TextSpan(
            text: '.  I break Satan\'s power off of his/her life.  Satan is bound and powerless and can no longer blind his/her mind.  I ask that you send laborers equipped with the Word of God to continue to minister to him/her in ways that he/she will receive.\n\n',
            ),
        
        TextSpan(text: 'The gospel of Jesus Christ is no longer hidden from '),
        TextSpan(text: "${getUnderlineString(length:15)}",style: TextStyle(decoration: TextDecoration.underline)),
        TextSpan(text: '.  '),
           TextSpan(text: "${getUnderlineString(length:15)} ",style: TextStyle(decoration: TextDecoration.underline)),
            TextSpan(text: 'will know and experience Jesus and His sacrifice for him/her.\n\n'),
           TextSpan(text: 'Father, because you always hear me when I pray, I know that you have answered my prayer.  From this day forward, I thank you that '),
           TextSpan(text: "${getUnderlineString(length:15)} ",style: TextStyle(decoration: TextDecoration.underline)),
        TextSpan(text: 'is saved and is in right standing with you.  Amen.\n\n'),
         TextSpan(
            text: 'Scriptures to Pray Over the Unsaved:\n',
            style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: '2 Corinthians 4:3-4, Matthew 9:37-38'),
      ],
    ),
  ),
                  )
               // Padding(padding: EdgeInsets.only(left:15,bottom: 8,top: 8),child: Text("Prayer",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w700,decoration: TextDecoration.underline),),)
                /* Text("Father, in the name of Jesus",softWrap: true,
                style: 
             TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),,), */
              ],
            )),
             ExpandableTab(title: "For the Backslidden / Out of Fellowship", body: Column(
              children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text.rich(
    TextSpan(
      children: [
        
        TextSpan(text: 'Father, in the Name of Jesus, I pray for '),
        TextSpan(text: "${getUnderlineString(length:15)}",style: TextStyle(decoration: TextDecoration.underline)),
        TextSpan(text: ".  I ask that you fill ",),
        TextSpan(text: "${getUnderlineString(length:15)} ",style: TextStyle(decoration: TextDecoration.underline)),
        
        TextSpan(text: 'with the knowledge of your will in all wisdom and spiritual understanding.  I pray the eyes of his/her understanding be enlightened and that he/she may know what is the hope of your calling.  I also ask that '),
          TextSpan(text: " ${getUnderlineString(length:15)} ",style: TextStyle(decoration: TextDecoration.underline)),
        TextSpan(text: ' knows his/her inheritance as saints and the exceeding greatness of your power towards him/her according to Ephesians 1:16-20.'),
      ],
    ),
  ),
                  )
               // Padding(padding: EdgeInsets.only(left:15,bottom: 8,top: 8),child: Text("Prayer",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w700,decoration: TextDecoration.underline),),)
                /* Text("Father, in the name of Jesus",softWrap: true,
                style: 
             TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),,), */
              ],
            )),
          ],),
        ),
        
        /*  ExpandableTheme(data: ExpandableThemeData(), child: 
      ExpandablePanel(
      header: Container(
        color: lightBlueColor1,
        padding: EdgeInsets.all(10),
        child: Text('Next Steps After Witnessing',style: TextStyle(color: Colors.white),)),
      collapsed: Container(color: lightBlueColor1,),
      
      theme:ExpandableThemeData(
        expandIcon: Icons.add,
        iconColor: Colors.black,
        iconPlacement: ExpandablePanelIconPlacement.left,
        headerAlignment: ExpandablePanelHeaderAlignment.center,
        hasIcon: true,
        tapHeaderToExpand: true,
        useInkWell: true,
        collapseIcon: Icons.minimize),
      expanded: Text('After a person confesses Jesus as their lord and savior', softWrap: true, ),
      
    )) */
      ],
    );
  }
}
