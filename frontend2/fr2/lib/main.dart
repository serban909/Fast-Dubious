import 'package:flutter/material.dart';
import 'pages/home_page_view.dart';
import 'pages/create_account3_widget.dart';
import 'pages/dashboard_widget.dart';
import 'pages/login1_widget.dart';
import 'pages/choose_identity_widget.dart';
import 'pages/choose_insurance_widget.dart';
import 'pages/choose_passport_widget.dart';
import 'pages/enter_indetity_data_widget.dart';
import 'pages/enter_car_data_widget.dart';

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
      //home: const ChoosePassportWidget(), // 👈 THIS
      home: const Login1Widget(), // 👈 THIS
      routes: {
        HomePageWidget.routePath: (context) => const HomePageWidget(),
        CreateAccount3Widget.routePath: (context) =>
            const CreateAccount3Widget(),
        DashboardWidget.routePath: (context) => const DashboardWidget(),
        Login1Widget.routePath: (context) => const Login1Widget(),
        ChooseIdentityWidget.routePath: (context) =>
            const ChooseIdentityWidget(),
        ChooseInsuranceWidget.routePath: (context) =>
            const ChooseInsuranceWidget(),
        ChoosePassportWidget.routePath: (context) => const ChoosePassportWidget(),
        EnterIndetityDataWidget.routePath: (context) =>
            const EnterIndetityDataWidget(),
        EnterCarDataWidget.routePath: (context) => const EnterCarDataWidget(),
      },
    );
  }
} 