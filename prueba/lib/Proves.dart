import 'package:flutter/material.dart';

void main () {
  runApp(new SaMevaApp()); //Dona error perquè ens demana un argument es a dir un Widget
}

class SaMevaApp extends StatelessWidget {
  @override
  Widget build(context) {
    return MaterialApp(
        home: Center (
            child:Text('Hola món!'),
        ),
    );
  }
}

