import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/core/constants.dart';
import 'package:student_app_provider/data/model/studentmodel.dart';
import 'package:student_app_provider/presentation/provider/studentprovider.dart';
import 'package:student_app_provider/presentation/screens/addstudent.dart';
import 'package:student_app_provider/presentation/screens/editstudent.dart';
import 'package:student_app_provider/presentation/screens/studentdetails.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var studentViewModel = Provider.of<StudentViewModel>(context, listen: false);
    print('sss');
    StudentModel student = StudentModel();
    studentViewModel.fetchAllStudent();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return AddStudent();
        },));
      }, child: const Icon(Icons.add),),
      // backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child:Consumer<StudentViewModel>(builder: (context, value, child) {
            return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Student List!', style: TextStyle( fontSize: 18),),
                ],
              ),
              sizedtwenty(context),
              studentViewModel.allStudent.isEmpty
                    ? const Center(
                        child: Text('No students available'),
                      )
                    : Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: value.allStudent.length,                         separatorBuilder: (context, index) {
                            return sizedten(context);
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                  return StudentDetailsPage(student: studentViewModel.allStudent[index]);
                                },));
                              },
                              child: Container(
                                height: screenHeight/12,
                                width: screenWidth-40,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(children: [
                                    const CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage('assets/images/myAvatar.png')),
                                    sizedwten(context),
                                    Text('${value.allStudent[index].name}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                    const Spacer(),
                                    PopupMenuButton(
                                      onSelected: (value) {
                                        print(value);
                                      },
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            onTap: (){
                                             Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditStduent(student: studentViewModel.allStudent[index]),));
                                            },
                                            value: 1,child: Text('Edit'),),
                                          PopupMenuItem(
                                            onTap: () { studentViewModel.deleteStudent(studentViewModel.allStudent[index].id!);
                                          },
                                            value: 2,child: Text('Delete'),)
                                        ];
                                      },)
                                  ],),
                                ),
                              ),
                            );
                          },
                        )
                        ) 
            ]);
          }
          ),
        ),
      ),
    );
  }
}