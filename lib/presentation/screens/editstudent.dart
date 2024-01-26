import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/core/constants.dart';
import 'package:student_app_provider/data/model/studentmodel.dart';
import 'package:student_app_provider/presentation/provider/studentprovider.dart';
import 'package:student_app_provider/presentation/widgets/textfeild.dart';

class EditStduent extends StatelessWidget{
  EditStduent({super.key, required this.student});
  final StudentModel student;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController streamController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  initializingValues() {
    nameController.text = student.name!;
    classController.text = student.className!;
    streamController.text = student.stream!;
  }

  @override
  Widget build(BuildContext context) {
    var studentViewModel = Provider.of<StudentViewModel>(context, listen: false);
    initializingValues();
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Edit Details',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AddTextFeild(
                        controller: nameController, hintText: 'hintText'),
                    SizedBox(
                      height: 10,
                    ),
                    AddTextFeild(
                        controller: classController, hintText: 'hintText'),
                    SizedBox(
                      height: 10,
                    ),
                    AddTextFeild(
                        controller: streamController, hintText: 'Stream'),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                if (student.name != null &&
                                    student.className != null &&
                                    student.stream != null) {
                                  studentViewModel.updateStudent(StudentModel(
                                    name: nameController.text,
                                    id: student.id,
                                    className: classController.text,
                                    stream: streamController.text
                                  ));
                                  Navigator.pop(context);
                                }
                              },
                              child: Text('Update')),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}