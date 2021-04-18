import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/models/status_store.dart';
import 'package:statuskeeper/tabs/tabs.dart';
import 'package:statuskeeper/utils/checkStoragePermission.dart';
import 'package:statuskeeper/utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await PermissionCheck.checkStoragePermission();
    runApp(StatusKeeper());
  } catch (e) {
    print("No Permission");
    SystemNavigator.pop();
  }
}

class StatusKeeper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StatusStore>(
      create: (context) => StatusStore(),
      child: Builder(
        builder: (context) {
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
                  SnackBarThemeData(backgroundColor: Colors.lightGreenAccent),
            ),
            home: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (Constants.statusDirectory.existsSync())
                  Flexible(
                    child: DefaultTabController(
                      length: 3,
                      child: Tabs(),
                    ),
                  ),
                if (!Constants.statusDirectory.existsSync())
                  Flexible(
                    child: Scaffold(
                      body: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Card(
                            color: Colors.lightGreen,
                            child: Text(
                              'Your Whatsapp Status Directory is not: ${Constants.statusDirectory}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
