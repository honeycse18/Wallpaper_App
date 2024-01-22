import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/const/app_color.dart';
import 'package:wallpaper_app/const/app_string.dart';
import 'package:wallpaper_app/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyATOUDRm-tgaTzS3J9o3ZX4VJoa3zw0IC0",
          appId: "1:323035553755:android:f7f171ebaf8227f13251fe",
          messagingSenderId: "323035553755",
          projectId: "wallpaper-project-f5178"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.bg,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          iconSize: 30,
        ),
      ),
      home: Splash(),
    );
  }
}
