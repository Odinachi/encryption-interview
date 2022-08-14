import 'package:apex/data/local/storage.dart';
import 'package:apex/res/strings.dart';
import 'package:apex/view/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await AppStorage.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRoutes,
      initialRoute: getInitialScreen(),
    );
  }

  String getInitialScreen() {
    var _p = AppStorage.instance;
    if (_p.getSeenSplash() == true) {
      return AppRouteStrings.loginScreen;
    }
    return AppRouteStrings.onBoardingScreen;
  }
}
