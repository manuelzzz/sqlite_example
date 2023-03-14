import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlConnection {
  Future<Database> openConnection() async {
    final databasePath = await getDatabasesPath();
    final databaseFinalPath = join(databasePath, 'SQLITE_EXAMPLE');

    return await openDatabase(
      databaseFinalPath,
      version: 3,
      // executado toda vez que o banco for aberto
      // sempre que for alterado
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
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
      onUpgrade: (db, oldVersion, newVersion) {
        final batch = db.batch();

        if (oldVersion == 1) {
          batch.execute('''
            create table produto(
              id Integer primary key autoincrement,
              nome varchar(200)
            )
          ''');

          // batch.execute('''
          // create table categoria(
          //  id Integer primary key autoincrement,
          //    nome varchar(200)
          //  )
          // ''');
        }

        // if (oldVersion == 2) {
        //   batch.execute('''
        //     create table categoria(
        //       id Integer primary key autoincrement,
        //       nome varchar(200)
        //     )
        //   ''');
        // }

        batch.commit();
      },
      // chamado sempre que houver uma alteração no "version" sendo decremental
      // (version--)
      onDowngrade: (db, oldVersion, newVersion) {
        final batch = db.batch();

        if (oldVersion == 3) {
          batch.execute('''
            drop table categoria
          ''');
        }

        batch.commit();
      },
    );
  }
}
