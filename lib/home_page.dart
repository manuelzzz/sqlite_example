import 'package:flutter/material.dart';
import 'package:sqlite_example/database/sql_connection.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _database();
  }

  Future<void> _database() async {
    final database = await SqlConnection().openConnection();

    database.rawInsert('insert into teste values(null, ?)', ['manuel']);
    database.rawUpdate('update teste set nome = ? where id = ?', ['manel', 3]);
    database.rawDelete('delete from teste where id = ?', [3]);
    var result = await database.rawQuery('select * from teste');
    print(result);

    // var result = await database.query('teste');
    // print(result);

    // também funciona como ORM
    // database.insert('table', {'chave': 'valor'});
    // database.delete('table', where: 'x = ?', whereArgs: []);
    // database.update('table', {'chave': 'valor'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sql Tests'),
      ),
      body: Container(),
    );
  }
}
