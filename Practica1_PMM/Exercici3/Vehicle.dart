abstract class Vehicle {
  String? _matricula;
  String? _marca;
  String? _model;
  bool _llogat = false;
  String? _DNIassignat;
  int _quilometratge = 0;

  Vehicle(this._matricula, this._marca, this._model, [this._DNIassignat]);

  // Métodos
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
  set llogat(bool llogat) => _llogat = llogat;
  set quilometratge(int quilometratge) => _quilometratge = quilometratge;
}
