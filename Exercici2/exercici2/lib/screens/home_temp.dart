import 'package:flutter/material.dart';

class HomePageTemp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Components Temp'),
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text('Titol ListTile'),
            ),
            Divider(),
            ListTile(
              title: Text('Títol ListTile'),
            ),
            ListTile(
              title: Text('Títol ListTile'),
            )
          ],
        )
        );
  }
}

/*import 'package:flutter/material.dart';

class HomePageTamp extends StatelessWWidget {

    final elements = ['Element 1', 'Element 2', 'Element 3', 'Element 4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Components Temp'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: _crearElementsList(),
      ),
    );
  }
}

List<Widget> _crearElementsList {

}
*/