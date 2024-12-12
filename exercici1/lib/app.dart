import 'package:exercici1/screens/home_page.dart';
import 'contador_pages.dart';
import 'package:flutter/material.dart';

class SaMevaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        child: ContadorPage(),
      ),
    );
  }
}
