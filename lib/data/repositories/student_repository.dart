import 'package:student_app_provider/data/database/dBhelper.dart';
import 'package:student_app_provider/data/model/studentmodel.dart';

class StudentRepo {
  DBHelper dbHelper = DBHelper();

  Future<List<StudentModel>> getStudent() async {
    print('get');
    var dbClient = await dbHelper.db;
    try {
      List<Map> maps = await dbClient.query(DBHelper.tableName,
          columns: ['id', 'name', 'className', 'stream']);
      List<StudentModel> studentList = [];

      for (int i = 0; i < maps.length; i++) {
        studentList.add(StudentModel.fromMap(maps[i]));
      }

      return studentList;
    } catch (e) {
      print('Error in getStudent: $e');
      return [];
    }
  }

  Future<int> add(StudentModel studentModel) async {
    print('beforeclient');
    var dbClient = await dbHelper.db;
    return await dbClient.insert(DBHelper.tableName, studentModel.toMap());
  }
  
  Future<int> updateData(StudentModel studentModel) async {
    var dbClient = await dbHelper.db;
    return await dbClient.update(DBHelper.tableName, studentModel.toMap(),
        where: 'id = ?', whereArgs: [studentModel.id]);
  }

  Future<int> delete(int id) async {
    var dbClient = await dbHelper.db;
    return await dbClient
        .delete(DBHelper.tableName, where: 'id = ?', whereArgs: [id]);
  }
}
