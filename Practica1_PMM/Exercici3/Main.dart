import 'Client.dart';
import 'Cotxe.dart';
import 'Moto.dart';

void main() {
  List<Cotxe> cotxes = [
    Cotxe.complet("1234ABC", "Rayo", "Mqueen", false, null, 10000),
    Cotxe.complet("2345DEF", "Travieso", "Escrot", false, null, 15000),
    Cotxe.complet("3456GHI", "Honda", "Civic", false, null, 20000),
    Cotxe.complet("4567JKL", "Mazda", "3", false, null, 25000),
    Cotxe.complet("5678MNO", "Nissan", "Sentra", false, null, 5000),
  ];

  List<Moto> motos = [
    Moto.complet("1234XYZ", "Yamaha", "MT-07", false, null, 8000, 689),
    Moto.complet("2345UVW", "Kawasaki", "Ninja 650", false, null, 12000, 649),
    Moto.complet("3456RST", "Suzuki", "SV650", false, null, 10000, 645),
    Moto.complet("4567QOP", "Honda", "CB500X", false, null, 15000, 471),
    Moto.complet("5678LMN", "BMW", "G310GS", false, null, 3000, 313),
  ];

  Client client1 = Client("12345678A", "Que RicaPija",
      "perepaparra69@gmail.com", 123456789, "1111222233334444");
  Client client2 = Client("87654321B", "Maria Unpajote",
      "mariaunpajote@gmail.com", 987654321, "4444333322221111");

  cotxes[0].llogar(client1.DNI!);
  cotxes[2].llogar(client2.DNI!);
  motos[1].llogar(client1.DNI!);
  motos[3].llogar(client2.DNI!);

  int cotxesLlogats = cotxes.where((cotxe) => cotxe.estaLlogat()).length;
  int motosLlogades = motos.where((moto) => moto.estaLlogat()).length;
  int totalLlogats = cotxesLlogats + motosLlogades;

  Cotxe cotxeMesQuilometratge =
      cotxes.reduce((a, b) => a.quilometratge > b.quilometratge ? a : b);
  Moto motoMesQuilometratge =
      motos.reduce((a, b) => a.quilometratge > b.quilometratge ? a : b);

  print("Cotxes llogats: $cotxesLlogats");
  print("Motos llogades: $motosLlogades");
  print("Total vehicles llogats: $totalLlogats");
  print("\nCotxe amb més quilòmetres:\n${cotxeMesQuilometratge.toString()}");
  print("\nMoto amb més quilòmetres:\n${motoMesQuilometratge.toString()}");
}
