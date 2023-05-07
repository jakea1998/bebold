

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MoreTabWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTapped;
  final IconData iconData;
  const MoreTabWidget({Key? key,required this.iconData,required this.text,required this.onTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Expanded(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:8.0,bottom: 8,right:12,left:12),
                  child: Icon(
                    iconData,
                    color: Colors.grey,
                    size: 25,
                  ),
                ),
                Expanded(child: Text(text,style: TextStyle(color: Colors.black, fontSize: 20,),),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.keyboard_arrow_right,color: Colors.grey,size: 25,),
                )
              ],
            ),
          ),
          Divider(
            height: 1,
            indent: 50,
            thickness: 1,
            color: Colors.grey,
          )
        ]),
      ),
    );
  }
}
