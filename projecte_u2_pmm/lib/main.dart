import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/personal_page.dart';
import 'screens/widget_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/personal': (context) => PersonalPage(),
        '/widget': (context) => WidgetPage(),
      },
    );
  }
}
