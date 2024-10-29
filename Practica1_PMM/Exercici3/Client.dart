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
