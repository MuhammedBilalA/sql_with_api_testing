import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_with_api_testing/src/data/repositories/repositories.dart';
import 'package:sql_with_api_testing/src/domain/models/local_model_class/local_model_class.dart';
import 'package:sql_with_api_testing/src/domain/models/remote_model_class/remote_model_class.dart';

class DataBaseFunctions {
  late Database _db;

  Future<void> initDataBase() async {
    try {
      _db = await openDatabase(
        'details.db',
        version: 1,
        onCreate: (db, version) async {
          db.execute(
              'CREATE TABLE details (id INTEGER PRIMARY KEY, name TEXT, email TEXT, body TEXT)');
        },
      );
    } catch (e) {
      Get.snackbar('something went wrong', e.toString());
    }
  }

  Future<List<LocalModelClass>> addDetails() async {
    try {
      await initDataBase();
      
      final int count = await _db.query('details').then((results) => results.length);

      if (count == 0) {
        List<RemoteModelClass> dataList = await ApiFunctions().getData();

        for (var element in dataList) {
          await _db.rawInsert('INSERT INTO details (name,email,body) VALUES (?,?,?)',
              [element.name, element.email, element.body]);
        }
      }
      return getAllData();
    } catch (e) {
      Get.snackbar('something went wrong', e.toString());

      throw Exception();
    }
  }

  Future<List<LocalModelClass>> getAllData() async {
    try {
      List<LocalModelClass> localModelClass = [];

      final List<Map<String, Object?>> values = await _db.rawQuery('SELECT * FROM details');

      for (int i = 0; i < 200; i++) {
        for (var map in values) {
          final LocalModelClass details = LocalModelClass.fromMap(map);

          localModelClass.add(details);
        }
      }
      return localModelClass;
    } catch (e) {
      Get.snackbar('something went wrong', e.toString());

      throw Exception();
    }
  }
}
