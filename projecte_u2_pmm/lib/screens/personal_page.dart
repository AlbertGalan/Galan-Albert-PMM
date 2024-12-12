import 'package:flutter/material.dart';
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
    persona = ModalRoute.of(context)!.settings.arguments as Persona;

    // Inicialitzem els controllers.
    _nomController = TextEditingController(text: persona.nom);
    _cognomController = TextEditingController(text: persona.cognom);
    _dataNaixementController =
        TextEditingController(text: persona.dataNaixement);
    _correuController = TextEditingController(text: persona.correu);
    _contrasenyaController = TextEditingController(text: persona.contrasenya);
  }

  // Funció per mostrar el selector de data
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(persona.dataNaixement) ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        String formattedDate =
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
        _dataNaixementController.text = formattedDate;
        persona.dataNaixement =
            formattedDate; // Actualitzar l'objecte `persona`.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Introdueix Credencials'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomController,
                decoration: InputDecoration(labelText: 'Nom'),
              ),
              TextFormField(
                controller: _cognomController,
                decoration: InputDecoration(labelText: 'Cognom'),
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
                decoration: InputDecoration(labelText: 'Correu Electrònic'),
              ),
              TextFormField(
                controller: _contrasenyaController,
                decoration: InputDecoration(labelText: 'Contrasenya'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Persona nova
                  final updatedPersona = Persona(
                    nom: _nomController.text,
                    cognom: _cognomController.text,
                    dataNaixement: _dataNaixementController.text,
                    correu: _correuController.text,
                    contrasenya: _contrasenyaController.text,
                  );
                  // Retornem l'objecte a la HomePage.
                  Navigator.pop(context, updatedPersona);
                },
                child: Text('Desa'),
              ),
            ],
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
