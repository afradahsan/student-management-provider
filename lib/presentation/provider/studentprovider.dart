import 'package:flutter/foundation.dart';
import 'package:student_app_provider/data/model/studentmodel.dart';
import 'package:student_app_provider/data/repositories/student_repository.dart'; 

class StudentViewModel extends ChangeNotifier{

  var allStudent = <StudentModel>[];
  StudentRepo studentRepo = StudentRepo();

  fetchAllStudent() async{
    print('fetchhh');
    allStudent = await studentRepo.getStudent();
    print("done!");
    notifyListeners();
  }

  addStudent(StudentModel studentModel){
    studentRepo.add(studentModel);
    fetchAllStudent();
  }

  updateStudent(StudentModel studentModel) {
    studentRepo.updateData(studentModel);
    print('updated');
    fetchAllStudent();
  }

  deleteStudent(int id){
    studentRepo.delete(id);
    fetchAllStudent();
  }

}