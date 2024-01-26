import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/core/constants.dart';
import 'package:student_app_provider/data/model/studentmodel.dart';
import 'package:student_app_provider/presentation/provider/studentprovider.dart';
import 'package:student_app_provider/presentation/widgets/textfeild.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var classController = TextEditingController();
    var streamController = TextEditingController();
    var studentViewModel = Provider.of<StudentViewModel>(context, listen: false);

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Add New Student',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            sizedten(context),
            AddTextFeild(controller: nameController, hintText: 'Enter Name',),
            sizedten(context),
            AddTextFeild(controller: classController, hintText: 'Class'),
            sizedten(context),
            AddTextFeild(controller: streamController, hintText: 'Choose Subject'),
            sizedten(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (nameController.text != '' && classController.text != '' && streamController.text != '') {
                        studentViewModel.addStudent(
                            StudentModel(name: nameController.text, className: classController.text, stream: streamController.text));
                        nameController.clear();
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Add')),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
