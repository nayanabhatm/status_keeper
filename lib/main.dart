import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/models/status_store.dart';
import 'package:statuskeeper/tabs/tabs.dart';
import 'package:statuskeeper/utils/checkStoragePermission.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    PermissionCheck.checkStoragePermission();
  } catch (e) {
    print("No Permission");
  }
  runApp(StatusKeeper());
}

class StatusKeeper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StatusStore>(
      create: (context) => StatusStore(),
      child: Builder(builder: (context) {
        return MaterialApp(
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
                  SnackBarThemeData(backgroundColor: Colors.lightGreenAccent)),
          home: DefaultTabController(
            length: 3,
            child: Tabs(),
          ),
        );
      }),
    );
  }
}
