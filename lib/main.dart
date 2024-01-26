import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/data/database/dBhelper.dart';
import 'package:student_app_provider/presentation/provider/studentprovider.dart';
import 'package:student_app_provider/presentation/screens/studenthomepage.dart';

void main() async{
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper().initDatabase();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudentViewModel() ,
      child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: const StudentHomePage()
    ));
  }
}