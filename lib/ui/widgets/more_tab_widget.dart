import 'package:flutter/material.dart';

class MoreTabWidget extends StatelessWidget {
  final String text;
  final Color? textColor;
  final VoidCallback onTapped;
  final IconData iconData;
  const MoreTabWidget(
      {Key? key,
      required this.iconData,
      required this.text,
      this.textColor,
      required this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Expanded(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, right: 12, left: 12),
                  child: Icon(
                    iconData,
                    color: Colors.grey,
                    size: 25,
                  ),
                ),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: textColor ??Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                    size: 25,
                  ),
                )
              ],
            ),
          ),
          const Divider(
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
