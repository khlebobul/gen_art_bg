import 'package:flutter/material.dart';

import 'demo_home_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'gen_art_bg',
      theme: ThemeData(useMaterial3: true),
      home: const DemoHomePage(),
    );
  }
}

void main() {
  runApp(const MainApp());
}
