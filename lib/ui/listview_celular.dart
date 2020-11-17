import 'package:flutter/material.dart';
import '../model/celular.dart';
import '../db/database_helper.dart';
import 'celular_screen.dart';

class ListViewCelular extends StatefulWidget {
  @override
  _ListViewCelularState createState() => new _ListViewCelularState();
}


class _ListViewCelularState extends State<ListViewCelular> {
  List<Celular> items = new List();
  DatabaseHelper db = new DatabaseHelper();
  @override
  void initState() {
    super.initState();
    db.getCelular().then((celulares) {
      setState(() {
        celulares.forEach((celular) {
          items.add(Celular.fromMap(celular));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Celulares'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Column(
                  children: [
                    Divider(height: 5.0),
                    ListTile(
                      title: Text(
                        '${items[position].nome}',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      subtitle: Row(children: [
                        Text('Marca: ${items[position].marca} - Cor: ${items[position].cor} - Tamanho: ${items[position].tamanho}',
                            style: new TextStyle(
                              fontSize: 18.0,
                              fontStyle: FontStyle.italic,
                            )),
                      
                        IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () => _deleteCelular(
                                context, items[position], position)),
                      ]),
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple,
                        radius: 15.0,
                        child: Text(
                          '${items[position].id}',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () => _navigateToCelular(context, items[position]),
                    ),
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewCelular(context),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }

  void _deleteCelular(BuildContext context, Celular celular, int position) async {
    db.deleteCelular(celular.id).then((celulares) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToCelular(BuildContext context, Celular celular) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CelularScreen(celular)),
    );
    if (result == 'update') {
      db.getCelular().then((celulares) {
        setState(() {
          items.clear();
          celulares.forEach((celular) {
            items.add(Celular.fromMap(celular));
          });
        });
      });
    }
  }

  void _createNewCelular(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CelularScreen(Celular('', '', '', ''))),
    );
    if (result == 'save') {
      db.getCelular().then((celulares) {
        setState(() {
          items.clear();
          celulares.forEach((celular) {
            items.add(Celular.fromMap(celular));
          });
        });
      });
    }
  }
}
