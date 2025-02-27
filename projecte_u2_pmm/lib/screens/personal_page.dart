import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/persona.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomController;
  late TextEditingController _cognomController;
  late TextEditingController _dataNaixementController;
  late TextEditingController _correuController;
  late TextEditingController _contrasenyaController;
  late Persona persona;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Obtenim les dades de la persona passades com argument.
    persona = ModalRoute.of(context)!.settings.arguments as Persona;

    // Inicialitzem els controllers amb ses dades.
    _nomController = TextEditingController(text: persona.nom);
    _cognomController = TextEditingController(text: persona.cognom);
    _dataNaixementController =
        TextEditingController(text: persona.dataNaixement);
    _correuController = TextEditingController(text: persona.correu);
    _contrasenyaController = TextEditingController(text: persona.contrasenya);
  }

//Guardqam les dades de la persona
  Future<void> _savePersona() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nom', persona.nom);
    await prefs.setString('cognom', persona.cognom);
    await prefs.setString('dataNaixement', persona.dataNaixement);
    await prefs.setString('correu', persona.correu);
    await prefs.setString('contrasenya', persona.contrasenya);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(persona.dataNaixement),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.parse(persona.dataNaixement)) {
      setState(() {
        persona.dataNaixement = picked.toIso8601String().split('T')[0];
        _dataNaixementController.text = persona.dataNaixement;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Persona'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _nomController,
                  onChanged: (value) {
                    persona.nom = value;
                  },
                  decoration: InputDecoration(labelText: 'Nom'),
                ),
                TextFormField(
                  controller: _cognomController,
                  onChanged: (value) {
                    persona.cognom = value;
                  },
                  decoration: InputDecoration(labelText: 'Llinatges'),
                ),
                TextFormField(
                  controller: _dataNaixementController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Data de Naixement',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () => _selectDate(context),
                ),
                TextFormField(
                  controller: _correuController,
                  onChanged: (value) {
                    persona.correu = value;
                  },
                  decoration: InputDecoration(labelText: 'Correu Electrònic'),
                ),
                TextFormField(
                  controller: _contrasenyaController,
                  onChanged: (value) {
                    persona.contrasenya = value;
                  },
                  decoration: InputDecoration(labelText: 'Contrasenya'),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _savePersona();
                      Navigator.pop(
                          context, persona); // Retornar les dades actualitzades
                    }
                  },
                  child: Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Allibeam els recursos dels controllers.
    _nomController.dispose();
    _cognomController.dispose();
    _dataNaixementController.dispose();
    _correuController.dispose();
    _contrasenyaController.dispose();
    super.dispose();
  }
}
