import 'Vehicle.dart';

class Cotxe extends Vehicle {
  Cotxe() : super(null, null, null);

  Cotxe.matricula(String matricula) : super(matricula, null, null);

  Cotxe.complet(String matricula, String marca, String model, bool llogat,
      String? DNIassignat, int quilometratge)
      : super(matricula, marca, model, DNIassignat) {
    this.llogat = llogat;
    this.quilometratge = quilometratge;
  }

  @override
  String toString() {
    return 'Cotxe(Matrícula: $matricula, Marca: $marca, Model: $model, Llogat: $llogat, Llogador: $DNIassignat, Quilometratge: $quilometratge)';
  }
}
