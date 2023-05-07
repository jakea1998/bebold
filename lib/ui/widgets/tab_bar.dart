import 'package:flutter/material.dart';

class AppTabBar extends StatelessWidget {
  final List<TabItem>? tabItems;
  final TabController? controller;
  AppTabBar({this.tabItems, this.controller});
  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        labelStyle: TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.w500),
        unselectedLabelStyle:
            TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.w500),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        isScrollable: false,
        // indicatorPadding: EdgeInsets.only(left: 30.0, right: 30, ),
        indicator: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 3.0, color: Colors.white)),

        ),tabs: this.tabItems!,);
        
  }
}

class TabItem extends StatelessWidget {
  final String? title;
  TabItem({this.title});
  @override
  Widget build(BuildContext context) {
    return Tab(
      text: title,
      
    );
  }
}