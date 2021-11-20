import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/models/status_store.dart';
import 'package:statuskeeper/tabs/tabs.dart';
import 'package:statuskeeper/utils/checkStoragePermission.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await PermissionCheck.checkStoragePermission();
    runApp(StatusKeeper());
  } catch (e) {
    print("No Permission");
  }
}

class StatusKeeper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StatusStore>(
      create: (context) => StatusStore(),
      child: MaterialApp(
        title: 'Status Keeper',
        theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize: 16.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
            ),
            bodyText2: TextStyle(
              fontSize: 16.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
            ),
            // caption: TextStyle(),
          ),
          primaryColor: Colors.lightGreen,
          indicatorColor: Colors.lightGreen,
          primaryColorLight: Colors.lightGreen,
          snackBarTheme:
              SnackBarThemeData(backgroundColor: Colors.lightGreenAccent),
        ),
        home: DefaultTabController(
          length: 3,
          child: Tabs(),
        ),
      ),
    );
  }
}
