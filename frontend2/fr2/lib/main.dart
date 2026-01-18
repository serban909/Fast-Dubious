import 'package:flutter/material.dart';
import 'package:fr2/pages/choose_passport_widget.dart';
import 'pages/homePageView.dart';
import 'pages/create_account3_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test App',
      theme: ThemeData(useMaterial3: false),
      home: const ChoosePassportWidget(), // 👈 THIS
      //home: const Login1Widget(), // 👈 THIS
      routes: {
        HomePageWidget.routePath: (context) => const HomePageWidget(),
        CreateAccount3Widget.routePath: (context) =>
            const CreateAccount3Widget(),
      },
    );
  }
}
