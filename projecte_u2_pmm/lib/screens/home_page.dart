import 'package:flutter/material.dart';
import '../models/persona.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Persona persona = Persona(
    nom: 'Albert',
    cognom: 'Galán',
    dataNaixement: '2004-09-11',
    correu: 'agc@gmail.com',
    contrasenya: '12345678',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PROJECTE U2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nom complet actual: ${persona.nom + " " + persona.cognom}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final updatedPersona = await Navigator.pushNamed(
                  context,
                  '/personal',
                  arguments: persona,
                ) as Persona?;
                if (updatedPersona != null) {
                  setState(() {
                    persona = updatedPersona;
                  });
                }
              },
              child: Text('Personal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/widget');
              },
              child: Text('Widget'),
            ),
          ],
        ),
      ),
    );
  }
}
