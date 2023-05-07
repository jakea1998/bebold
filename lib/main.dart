import 'dart:async';

import 'package:be_bold/blocs/reports/reports_bloc.dart';
import 'package:be_bold/blocs/audio_video/audio_video_bloc.dart';
import 'package:be_bold/blocs/lives_changed/lives_changed_bloc.dart';
import 'package:be_bold/blocs/user/user_bloc.dart';
import 'package:be_bold/ui/pages/home_page.dart';
import 'package:be_bold/ui/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    Widget getHomeScreen(BuildContext context) {
      try {
        final _auth = FirebaseAuth.instance;

        final user = _auth.currentUser;

        if (user == null) {
          return SplashScreen(
            widget: LoginPage(),
          );
        } else {
          return SplashScreen(widget: HomePage());
        }
      } catch (e) {
        print(e);
        return Container();
      }
    }

    final reportsBloc = ReportsBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context)=>reportsBloc),
        BlocProvider(
            lazy: false,
            create: (context) =>
                LivesChangedBloc(reportsBloc: reportsBloc)),
        BlocProvider(create: (context) => AudioVideoBloc())
      ],
      child: MaterialApp(
        title: 'Be Bold App',
        debugShowCheckedModeBanner: false,
        home: getHomeScreen(context),
        builder: EasyLoading.init(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  final Widget widget;

  SplashScreen({
    required this.widget,
  });
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => widget.widget)));
  }

  @override
  Widget build(BuildContext context) {
    // ScreenSize.height = MediaQuery.of(context).size.height;
    // ScreenSize.width = MediaQuery.of(context).size.width;
    return Material(
      child: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('lib/assets/logo_1.png',
                  height: 40, fit: BoxFit.fitHeight),
              Spacer(
                flex: 1,
              ),
              Center(
                child: Image.asset('lib/assets/Be_bold.png',
                    height: 150, fit: BoxFit.fitHeight),
              ),
              Spacer(
                flex: 1,
              ),
              Image.asset('lib/assets/helping_impact.png',
                  height: 150, fit: BoxFit.fitHeight),
            ],
          ),
        ),
      ),
    );
  }
}
