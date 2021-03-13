import 'dart:ui';

import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:fruitapp/models/calender_model.dart';
import 'package:fruitapp/screens/calender.dart';
=======
import './Card/GridCard.dart';
import './Card/GridDataModel.dart';
import './Dialog/NameFruitDialog.dart';
>>>>>>> 84eff8a9664ca97cf092bafecb3da3df3d03aea3
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
<<<<<<< HEAD
  runApp(MyApp());
=======

  WidgetsFlutterBinding.ensureInitialized();
  // Get storage permission from user
  runApp(MyApp());

  var status = await Permission.storage.status;
  if (status.isUndetermined) {
    // Need to get read/write permission for SQLite to work.
    Map<Permission, PermissionStatus> statuses =
    await [Permission.storage].request();
    print(statuses[
    Permission.storage]); // it should print PermissionStatus.granted
  }

>>>>>>> 84eff8a9664ca97cf092bafecb3da3df3d03aea3
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
<<<<<<< HEAD
      home: MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => CalenderModel())],
        builder: (context, widget) {
          return CalenderWidget();
        },
      ),
    );
=======
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            RaisedButton(onPressed: () async {
              final result = await showDialog(
                context: context,
                builder: (_) => NameFruitDialog("date"),
              );
            },
                child:Text("Click")),
          ],
        ));
>>>>>>> 84eff8a9664ca97cf092bafecb3da3df3d03aea3
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
