import 'dart:core';

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

class Client {
  String? _DNI;
  String? _nomComplet;
  String? _correu;
  int? _telefon;
  String? _targetaCredit;

  // Constructor
  Client(this._DNI, this._nomComplet,
      [this._correu, this._telefon, this._targetaCredit]);

  String? get DNI => _DNI;
  String? get nomComplet => _nomComplet;
  String? get correu => _correu;
  int? get telefon => _telefon;
  String? get targetaCredit => _targetaCredit;

  set DNI(String? dni) => _DNI = dni;
  set nomComplet(String? nom) => _nomComplet = nom;
  set correu(String? correu) => _correu = correu;
  set telefon(int? telefon) => _telefon = telefon;
  set targetaCredit(String? targeta) => _targetaCredit = targeta;

  @override
  String toString() {
    return 'Client(DNI: $_DNI, Nom complet: $_nomComplet, Correu: $_correu, Telèfon: $_telefon, Targeta de crèdit: $_targetaCredit)';
  }
}

abstract class Vehicle {
  String? _matricula;
  String? _marca;
  String? _model;
  bool _llogat = false;
  String? _DNIassignat;
  int _quilometratge = 0;

  Vehicle(this._matricula, this._marca, this._model, [this._DNIassignat]);

  void llogar(String dni) {
    _llogat = true;
    _DNIassignat = dni;
  }

  void retornar() {
    _llogat = false;
    _DNIassignat = null;
  }

  bool estaLlogat() {
    return _llogat;
  }

  int compareTo(Object a) {
    if (a is Vehicle && a.runtimeType == this.runtimeType) {
      return _quilometratge.compareTo(a._quilometratge);
    } else {
      throw ArgumentError("No es poden comparar vehicles de diferent tipus");
    }
  }

  String? get matricula => _matricula;
  String? get marca => _marca;
  String? get model => _model;
  bool get llogat => _llogat;
  String? get DNIassignat => _DNIassignat;
  int get quilometratge => _quilometratge;

  set matricula(String? matricula) => _matricula = matricula;
  set marca(String? marca) => _marca = marca;
  set model(String? model) => _model = model;
  set quilometratge(int quilometratge) => _quilometratge = quilometratge;
}

class Cotxe extends Vehicle {
  Cotxe() : super(null, null, null);

  Cotxe.matricula(String matricula) : super(matricula, null, null);

  Cotxe.complet(String matricula, String marca, String model, bool llogat,
      String? DNIassignat, int quilometratge)
      : super(matricula, marca, model, DNIassignat) {
    this._llogat = llogat;
    this.quilometratge = quilometratge;
  }

  @override
  String toString() {
    return 'Cotxe(Matrícula: $matricula, Marca: $marca, Model: $model, Llogat: $llogat, Llogador: $DNIassignat, Quilometratge: $quilometratge)';
  }
}

class Moto extends Vehicle {
  int? _cilindrada;

  Moto() : super(null, null, null);

  Moto.matricula(String matricula) : super(matricula, null, null);

  Moto.complet(String matricula, String marca, String model, bool llogat,
      String? DNIassignat, int quilometratge, this._cilindrada)
      : super(matricula, marca, model, DNIassignat) {
    this._llogat = llogat;
    this.quilometratge = quilometratge;
  }

  int? get cilindrada => _cilindrada;
  set cilindrada(int? cilindrada) => _cilindrada = cilindrada;

  @override
  String toString() {
    return 'Moto(Matrícula: $matricula, Marca: $marca, Model: $model, Llogat: $llogat, Llogador: $DNIassignat, Quilometratge: $quilometratge, Cilindrada: $_cilindrada)';
  }
}
