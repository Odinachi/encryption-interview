import 'package:apex/res/strings.dart';
import 'package:apex/view/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRoutes,
      initialRoute: AppRouteStrings.onBoardingScreen,
      // home: Scaffold(body: HomeScreen()),
    );
  }
}
