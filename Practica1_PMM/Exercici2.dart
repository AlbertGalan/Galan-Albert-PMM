import 'dart:io';

void main() {
  print('Introdueix un nombre màxim per generar nombres primers:');
  int? max = int.tryParse(stdin.readLineSync()!);

  if (max != null && max > 0) {
    //que max sigui diferente de null i més de 0 ja que no es poden treure nombres primers de nombres
    List<int> primers = generaPrimers(
        max); //Que faci una llista de ints de nom primers i que empri el mètode generaPrimer i empri max
    print('Nombres primers normals');
    for (var primer in primers) {
      print(primer);
    }

    print('Parelles de nombres primers amb diferencia de 2');
    generaParelles(primers);
  } else {
    print('InputError: Introdueix un nombre vàlid superior a 0.');
  }
}

List<int> generaPrimers(int max) {
  List<int> primers = [];

  for (int num = 2; num <= max; num++) {
    //si num es menor o igual a max que vagi sumant
    if (esPrimer(num)) {
      //si el nombre dona com a true al mètode que comprova si un nombre es primer
      primers.add(num); // Que s'afegesqui a l'array de primers
    }
  }

  return primers;
}

bool esPrimer(int num) {
  //Un boolea que mira a veure si el nombre de la llista es un nombre primer
  if (num <= 1) return false;
  for (int i = 2; i * i <= num; i++) {
    if (num % i == 0) return false;
  }
  return true;
}

void generaParelles(List<int> primers) {
  //Mètode que treu les parelles de nombres primers amb diferència de
  for (int i = 0; i < primers.length - 1; i++) {
    if (primers[i + 1] - primers[i] == 2) {
      print('${primers[i]} i ${primers[i + 1]}');
    }
  }
}
