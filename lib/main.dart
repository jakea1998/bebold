import 'dart:async';
import 'dart:io';

import 'package:be_bold/blocs/reports/reports_bloc.dart';
import 'package:be_bold/blocs/audio_video/audio_video_bloc.dart';
import 'package:be_bold/blocs/lives_changed/lives_changed_bloc.dart';
import 'package:be_bold/blocs/user/user_bloc.dart';
import 'package:be_bold/firebase_options.dart';
import 'package:be_bold/ui/pages/home_page.dart';
import 'package:be_bold/ui/widgets/updater.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  if (Platform.isIOS) {
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  }
  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );
  //await Updater().perform_file_name_update();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  /* if (Platform.isAndroid) {
    await FirebaseAppCheck.instance.activate(
      // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
      // argument for `webProvider`
      //webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
      // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
      // your preferred provider. Choose from:
      // 1. Debug provider
      // 2. Safety Net provider
      // 3. Play Integrity provider
      androidProvider: AndroidProvider.debug,
      // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
      // your preferred provider. Choose from:
      // 1. Debug provider
      // 2. Device Check provider
      // 3. App Attest provider
      // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
      appleProvider: AppleProvider.appAttest,
    );
  } */
  runApp(BeBoldApp());
}

class BeBoldApp extends StatefulWidget with WidgetsBindingObserver {
  const BeBoldApp({Key? key}) : super(key: key);
  @override
  State<BeBoldApp> createState() => _BeBoldAppState();
}

class _BeBoldAppState extends State<BeBoldApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isIOS) {
      Timer(const Duration(seconds: 2), () {
        FlutterNativeSplash.remove();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final reportsBloc = ReportsBloc();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => reportsBloc),
        BlocProvider(
            lazy: false,
            create: (context) => LivesChangedBloc(reportsBloc: reportsBloc)),
        BlocProvider(create: (context) => AudioVideoBloc())
      ],
      child: MaterialApp(
        title: 'Be Bold App',
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(
            builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
              TargetPlatform.values,
              value: (dynamic _) =>
                  const CupertinoPageTransitionsBuilder(), //applying old animation
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

/* class SplashScreen extends StatefulWidget {
  final Widget widget;

  const SplashScreen({
    Key? key,
    required this.widget,
  }) : super(key: key);
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => widget.widget)));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('lib/assets/logo_1.png',
                  height: 40, fit: BoxFit.fitHeight),
              const Spacer(
                flex: 1,
              ),
              Center(
                child: Image.asset('lib/assets/Be_bold.png',
                    height: 150, fit: BoxFit.fitHeight),
              ),
              const Spacer(
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
 */