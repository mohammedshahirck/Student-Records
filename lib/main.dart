import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:studentidcollage/db/functions/db_functions.dart';
import 'package:studentidcollage/db/model/data_model.dart';
import 'package:studentidcollage/provider/provider_student.dart';
import 'package:studentidcollage/screens/home/screen_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StudentIdProvider()),
        ChangeNotifierProvider(create: (context) => DbFunctions()),
      ],
      child: MaterialApp(
        title: 'Student Database',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: ScreenHome(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
