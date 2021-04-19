import 'package:flutter/material.dart';
import 'package:fruitapp/models/calender_model.dart';
import 'package:fruitapp/models/day_model.dart';
import 'package:fruitapp/screens/calender.dart';
import 'package:fruitapp/screens/day.dart';
import 'package:fruitapp/screens/detail.dart';
import 'package:fruitapp/screens/detail_tabs.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'models/fruit_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Providers at the top of the widget tree for keeping the state visible
  // everywhere in the application.
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CalenderModel()),
      ChangeNotifierProvider(create: (_) => DayModel()),
      ChangeNotifierProvider(create: (_) => FruitModel())
    ],
    builder: (context, widget) {
      return MyApp();
    },
  ));

  // Get storage permission from user
  var status = await Permission.storage.status;
  if (status.isUndetermined) {
    // Need to get read/write permission for SQLite to work.
    Map<Permission, PermissionStatus> statuses =
        await [Permission.storage].request();
    print(statuses[
        Permission.storage]); // it should print PermissionStatus.granted
  }
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
      initialRoute: '/day',
      routes: {
        '/day': (_) => DayPage(),
        '/calender': (_) => CalenderWidget(),
        '/detail': (_) => DetailTabsPage()
      },
    );
  }
}
