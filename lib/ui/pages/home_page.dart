import 'dart:async';
import 'dart:io';

import 'package:be_bold/blocs/lives_changed/lives_changed_bloc.dart';
import 'package:be_bold/blocs/user/user_bloc.dart';
import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/ui/pages/personal_info_page.dart';
import 'package:be_bold/ui/tabs/home_tab.dart';
import 'package:be_bold/ui/tabs/insight_tab.dart';
import 'package:be_bold/ui/tabs/lives_changed_tab.dart';
import 'package:be_bold/ui/tabs/more_tab.dart';
import 'package:be_bold/ui/tabs/reports_tab.dart';
import 'package:be_bold/ui/widgets/account_required_dialog.dart';
import 'package:be_bold/ui/widgets/app_bar.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:icons_plus/icons_plus.dart';

class HomePage extends StatefulWidget {
  final int? tabIndex;
  const HomePage({Key? key, this.tabIndex = 0}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int navIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    BlocProvider.of<UserBloc>(context).add(UserEventLoadUser(
        livesChangedBloc: BlocProvider.of<LivesChangedBloc>(context)));

    navIndex = widget.tabIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar1(
            //leading: Container(),

            leading: IconButton(
          icon: const Icon(
            Icons.person,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () {
            if (BlocProvider.of<UserBloc>(context).state.userExists ?? false) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PersonalInfoPage()));
            } else {
              showDialog(
                  context: context,
                  builder: (context) => const AccountRequiredDialog(
                      title: "User Doesn't Exist",
                      text: "Please create an account or login."));
            }
          },
        )),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          child: _buildBody(navIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: darkBlueColor1,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            selectedLabelStyle: const TextStyle(color: Colors.white),
            unselectedLabelStyle: const TextStyle(color: Colors.white),
            type: BottomNavigationBarType.fixed,
            currentIndex: navIndex,
            onTap: (index) {
              setState(() {
                navIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.lightbulb_outline,
                    color: Colors.white,
                  ),
                  label: "Insight"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.people_outline,
                    color: Colors.white,
                  ),
                  label: "List"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Bootstrap.receipt,
                    color: Colors.white,
                  ),
                  label: "Report"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.more_horiz_outlined,
                    color: Colors.white,
                  ),
                  label: "More")
            ]));
  }

  _buildBody(int? index) {
    if (index == 0) {
      return HomeTab();
    } else if (index == 1) {
      return InsightTab();
    } else if (index == 2) {
      return LivesChangedTab();
    } else if (index == 3) {
      return ReportsTab();
    } else if (index == 4) {
      return MoreTab();
    } else {
      return Container();
    }
  }
}
