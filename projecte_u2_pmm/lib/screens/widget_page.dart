import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetPage extends StatefulWidget {
  @override
  _WidgetPageState createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  double _size = 100.0; // Mida figura
  double _red = 0.0;
  double _green = 0.0;
  double _blue = 0.0;
  double _borderRadiusValue =
      10.0; // Valor inicial de borderRadius (quadrat per defecte)

  // Funció per actualitzar el color
  void _updateColor() {
    setState(() {
      // Actualitzar el color quan canviï el valor de RGB
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widgets'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Mostrar la figura amb animació
            AnimatedContainer(
              duration: Duration(seconds: 1),
              width: _size,
              height: _size,
              decoration: BoxDecoration(
                color: Color.fromRGBO(_red.toInt(), _green.toInt(),
                    _blue.toInt(), 1), // Color RGB
                borderRadius: BorderRadius.circular(
                    _borderRadiusValue), // Canviar forma (de quadrat a cercle)
              ),
            ),

            SizedBox(height: 20),

            // Slider per controlar el component vermell (Red)
            Text('Vermell: ${_red.toInt()}'),
            CupertinoSlider(
              value: _red,
              min: 0.0,
              max: 255.0,
              onChanged: (value) {
                setState(() {
                  _red = value;
                });
                _updateColor();
              },
            ),

            // Slider per controlar el component verd (Green)
            Text('Verd: ${_green.toInt()}'),
            CupertinoSlider(
              value: _green,
              min: 0.0,
              max: 255.0,
              onChanged: (value) {
                setState(() {
                  _green = value;
                });
                _updateColor();
              },
            ),

            Text('Blau: ${_blue.toInt()}'),
            CupertinoSlider(
              value: _blue,
              min: 0.0,
              max: 255.0,
              onChanged: (value) {
                setState(() {
                  _blue = value;
                });
                _updateColor();
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text "Quadrat" a l'esquerra del slider
                Text('Quadrat', style: TextStyle(fontSize: 16)),
                SizedBox(width: 10), // Espai entre text i slider
                CupertinoSlider(
                  value: _borderRadiusValue,
                  min: 0.0,
                  max: 100.0,
                  onChanged: (value) {
                    setState(() {
                      _borderRadiusValue = value;
                    });
                  },
                ),
                SizedBox(width: 10), // Espai entre slider i text
                // Text "Cercle" a la dreta del slider
                Text('Cercle', style: TextStyle(fontSize: 16)),
              ],
            ),

            SizedBox(height: 20),

            // Botó per tornar enrere a la pàgina anterior
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Tornar a la pàgina anterior'),
            ),
          ],
        ),
      ),
    );
  }
}
