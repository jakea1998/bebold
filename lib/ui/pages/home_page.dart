import 'package:be_bold/blocs/lives_changed/lives_changed_bloc.dart';
import 'package:be_bold/blocs/repos/audio_video_repo.dart';
import 'package:be_bold/blocs/user/user_bloc.dart';
import 'package:be_bold/constants/colors.dart';
import 'package:be_bold/models/firebase_file.dart';
import 'package:be_bold/ui/pages/personal_info_page.dart';
import 'package:be_bold/ui/tabs/home_tab.dart';
import 'package:be_bold/ui/tabs/insight_tab.dart';
import 'package:be_bold/ui/tabs/lives_changed_tab.dart';
import 'package:be_bold/ui/tabs/more_tab.dart';
import 'package:be_bold/ui/tabs/reports_tab.dart';
import 'package:be_bold/ui/widgets/app_bar.dart';
import 'package:be_bold/ui/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    BlocProvider.of<UserBloc>(context).add(UserEventLoadUser());
     BlocProvider.of<LivesChangedBloc>(context).add(LivesChangedEventLoadLives());
    navIndex = widget.tabIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar1(
          leading: IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PersonalInfoPage()));
            },
          ),
        ),
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 100),
          child: _buildBody(navIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: darkBlueColor1,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            selectedLabelStyle: TextStyle(color: Colors.white),
            unselectedLabelStyle: TextStyle(color: Colors.white),
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
                    Icons.speaker_notes_outlined,
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
    } else
      return Container();
  }
}
