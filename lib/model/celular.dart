class Celular {
  int _id;
  String _nome;
  String _marca;
  String _cor;
  String _tamanho;

  Celular(
      this._nome, this._marca, this._cor, this._tamanho);

  Celular.map(dynamic obj) {
    this._id = obj['id'];
    this._nome = obj['nome'];
    this._marca = obj['marca'];
    this._cor = obj['cor'];
    this._tamanho = obj['tamanho'];
  }

  int get id => _id;
  String get nome => _nome;
  String get marca => _marca;
  String get cor => _cor;
  String get tamanho => _tamanho;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['nome'] = _nome;
    map['marca'] = _marca;
    map['cor'] = _cor;
    map['tamanho'] = _tamanho;
    return map;
  }

  Celular.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nome = map['nome'];
    this._marca = map['marca'];
    this._cor = map['cor'];
    this._tamanho = map['tamanho'];
  }
}
