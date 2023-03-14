import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlConnection {
  Future<void> openConnection() async {
    final databasePath = await getDatabasesPath();
    final databaseFinalPath = join(databasePath, 'SQLITE_EXAMPLE');

    await openDatabase(
      databaseFinalPath,
      version: 1,
      // onCreate -> só é chamado no momento de criação do db
      // só é rodado quando o aplicativo é carregado a primeira vez
      onCreate: (db, version) {
        final batch = db.batch();

        batch.execute('''
          create table teste(
            id Integer primary key autoincrement,
            nome varchar(200)
          )
        ''');

        batch.commit();
      },
      // chamado sempre que houver uma alteração no "version" sendo incremental
      // (version++)
      onUpgrade: (db, oldVersion, newVersion) {},
      // chamado sempre que houver uma alteração no "version" sendo decremental
      // (version--)
      onDowngrade: (db, oldVersion, newVersion) {},
    );
  }
}