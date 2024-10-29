import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final estil = TextStyle(fontSize: 24);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contador'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nombre de clicks:', style: estil),
            Text(
              '0',
              style: estil,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Uep, com anam?');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
