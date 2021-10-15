import 'package:business_card_creator/pages/colors_page.dart';
import 'package:business_card_creator/pages/config_page.dart';
import 'package:business_card_creator/pages/home_page.dart';
import 'package:business_card_creator/pages/preview_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: 'HomePage',
      routes: {
        'HomePage': (_) => const HomePage(),
        'ConfigPage': (_) => const ConfigPage(),
        'ColorsPage': (_) => const ColorsPage(),
        'PreviewPage': (_) => const PreviewPage(),
      },
    );
  }
}
