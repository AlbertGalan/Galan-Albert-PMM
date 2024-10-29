import 'dart:io'; //Import necessari per poder fer que un usuari escrigui i es rebi a una variable

void main() {
  print('Escriu una hora del dia (format 24 hores)'); //HORES

  String? inputHora = stdin
      .readLineSync(); //Variable d'entrada String que rep una cadena (també se pot fer int.parse(stdin.readLineSync()))
  int? Hora = int.tryParse(
      inputHora!); // Variable que rep el inputHora amb "!"(no es null) i el pasa a int.

  if (Hora == null || Hora < 0 || Hora > 23) {
    // Si hora no esta en format que toca, bota error
    print(
        "InputError: el valor d'entrada no esta en un format correcte (format hora(23))");
    return;
  }

  print("Escriu minuts, (màxim 59)"); //MINUTS

  String? inputMinut =
      stdin.readLineSync(); //Repetim el procés amb minuts i segons
  int? Minut = int.tryParse(inputMinut!);

  if (Minut == null || Minut < 0 || Minut > 59) {
    print(
        "Input Error: el valor d'entrada no esta en un format correcte (format minuts(59))");
    return;
  }

  print("Escriu una quantitat de segons (màxim 59)"); //SEGONS

  String? inputSegons = stdin.readLineSync();
  int? Segons = int.tryParse(inputSegons!);

  if (Segons == null || Segons < 0 || Segons > 59) {
    print(
        "InputError: el valor d'entrada no esta en un format correcte(format 59 segons)");
    return;
  }

  print("La hora completa es: $Hora:$Minut:$Segons");
}