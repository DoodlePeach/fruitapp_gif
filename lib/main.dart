import 'package:flutter/material.dart';
import 'package:fruitapp/models/calender_model.dart';
import 'package:fruitapp/screens/calender.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => CalenderModel())],
        builder: (context, widget) {
          return CalenderWidget();
        },
      ),
    );
  }
}

// Future getPermission() async {
//     // Get storage permission from user
//     var status = await Permission.storage.status;
//     if (status.isUndetermined) {
//       // Need to get read/write permission for SQLite to work.
//       Map<Permission, PermissionStatus> statuses =
//           await [Permission.storage].request();
//       print(statuses[
//           Permission.storage]); // it should print PermissionStatus.granted
//     }
