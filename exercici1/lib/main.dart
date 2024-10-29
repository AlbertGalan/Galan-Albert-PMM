import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(new SaMevaApp());
}

class SaMevaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: HomePage(),
      ),
    );
  }
}
