import 'package:be_bold/constants/colors.dart';
import 'package:flutter/material.dart';

class ExpandableTab extends StatefulWidget {
  final String title;
  final Widget body;
  final Color? color;
  const ExpandableTab({Key? key,this.color = lightBlueColor1, required this.title, required this.body})
      : super(key: key);

  @override
  State<ExpandableTab> createState() => _ExpandableTabState();
}

class _ExpandableTabState extends State<ExpandableTab> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Card(
              elevation: 3,
              child: Container(
                color: widget.color,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.title.toUpperCase(),
                          style: TextStyle(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        isExpanded ? Icons.remove : Icons.add,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: new Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: isExpanded
                ? Card(
                    elevation: 3,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: widget.body))
                : Container(),
          )
        ],
      ),
    );
  }
}
