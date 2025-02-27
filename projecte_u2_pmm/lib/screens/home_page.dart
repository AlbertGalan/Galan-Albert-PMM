import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/persona.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Inicialitzam la variable persona amb les dades per defecte
  late Persona persona = Persona(
    nom: 'Albert',
    cognom: 'Galán',
    dataNaixement: '2004-09-11',
    correu: 'agc@gmail.com',
    contrasenya: '12345678',
  );

  @override
  void initState() {
    super.initState();
    _loadPersona();
  }

//Carregam les dades de 'persona' des de SharedPreferences
  Future<void> _loadPersona() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      //Si no hi ha dades guardades, es mantenen les dades per defecte
      persona = Persona(
        nom: prefs.getString('nom') ?? 'Albert',
        cognom: prefs.getString('cognom') ?? 'Galán',
        dataNaixement: prefs.getString('dataNaixement') ?? '2004-09-11',
        correu: prefs.getString('correu') ?? 'agc@gmail.com',
        contrasenya: prefs.getString('contrasenya') ?? '12345678',
      );
    });
    print(
        'Loaded Persona: ${persona.nom}, ${persona.cognom}, ${persona.dataNaixement}, ${persona.correu}, ${persona.contrasenya}');
  }

  //Métode per guardar nova persona
  Future<void> _savePersona() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nom', persona.nom);
    await prefs.setString('cognom', persona.cognom);
    await prefs.setString('dataNaixement', persona.dataNaixement);
    await prefs.setString('correu', persona.correu);
    await prefs.setString('contrasenya', persona.contrasenya);
    print(
        'Saved Persona: ${persona.nom}, ${persona.cognom}, ${persona.dataNaixement}, ${persona.correu}, ${persona.contrasenya}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PROJECTE U2 Reciclat amb SharedPreference'),
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
                  await _savePersona(); // Guardar dades actualitzades
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
