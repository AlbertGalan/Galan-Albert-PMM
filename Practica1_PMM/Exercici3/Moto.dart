import 'Vehicle.dart';

class Moto extends Vehicle {
  int? _cilindrada;

  Moto() : super(null, null, null);

  Moto.matricula(String matricula) : super(matricula, null, null);

  Moto.complet(String matricula, String marca, String model, bool llogat,
      String? DNIassignat, int quilometratge, this._cilindrada)
      : super(matricula, marca, model, DNIassignat) {
    this.llogat = llogat;
    this.quilometratge = quilometratge;
  }

  int? get cilindrada => _cilindrada;
  set cilindrada(int? cilindrada) => _cilindrada = cilindrada;

  @override
  String toString() {
    return 'Moto(Matrícula: $matricula, Marca: $marca, Model: $model, Llogat: $llogat, Llogador: $DNIassignat, Quilometratge: $quilometratge, Cilindrada: $_cilindrada)';
  }
}
