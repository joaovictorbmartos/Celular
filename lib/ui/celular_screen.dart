import 'package:flutter/material.dart';
import '../model/celular.dart';
import '../db/database_helper.dart';

class CelularScreen extends StatefulWidget {
  final Celular celular;
  CelularScreen(this.celular);
  @override
  State<StatefulWidget> createState() => new _CelularScreenState();
}

class _CelularScreenState extends State<CelularScreen> {
  DatabaseHelper db = new DatabaseHelper();
  TextEditingController _nomeController;
  TextEditingController _marcaController;
  TextEditingController _corController;
  TextEditingController _tamanhoController;

  @override
  void initState() {
    super.initState();
    _nomeController = new TextEditingController(text: widget.celular.nome);
    _marcaController = new TextEditingController(text: widget.celular.marca);
    _corController =
        new TextEditingController(text: widget.celular.cor);
    _tamanhoController = new TextEditingController(text: widget.celular.tamanho);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Celular')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            Image.network(
            'https://www.guiadosmartphone.com/wp-content/uploads/2018/11/MARCAS-DE-CELULAR.png',
             width: 500,
             height: 300,
             alignment: Alignment.center,
            ),
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _marcaController,
              decoration: InputDecoration(labelText: 'Marca'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _corController,
              decoration: InputDecoration(labelText: 'Cor'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _tamanhoController,
              decoration: InputDecoration(labelText: 'Tamanho'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.celular.id != null)
                  ? Text('Alterar')
                  : Text('Inserir'),
              onPressed: () {
                if (widget.celular.id != null) {
                  db.updateCelular(Celular.fromMap({
                    'id': widget.celular.id,
                    'nome': _nomeController.text,
                    'marca': _marcaController.text,
                    'cor': _corController.text,
                    'tamanho': _tamanhoController.text
                  }))
                      .then((_) {
                    Navigator.pop(context, 'update');
                  });
                } else {
                  db
                      .inserirCelular(Celular(
                          _nomeController.text,
                          _marcaController.text,
                          _corController.text,
                          _tamanhoController.text))
                      .then((_) {
                    Navigator.pop(context, 'save');
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}