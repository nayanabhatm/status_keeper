import 'package:flutter/material.dart';
import 'package:statuskeeper/tabs/tabs.dart';
import 'package:statuskeeper/functionalities/checkStoragePermission.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/models/viewModel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PermissionCheck().checkStoragePermission();
  runApp(StatusKeeper());
}

class StatusKeeper extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider<StatusViewModel>(
      create: (context) => StatusViewModel(),
      child: Builder(
        builder: (context){
          return MaterialApp(
              title: 'Status Keeper',
              theme: ThemeData.dark().copyWith(
                  primaryColor: Colors.lightGreen,
                  indicatorColor: Colors.lightGreen,
                  primaryColorLight: Colors.lightGreen,
                  snackBarTheme: SnackBarThemeData(
                      backgroundColor: Colors.lightGreenAccent
                  )
              ),
              home: DefaultTabController(
                  length: 3,
                  child: Tabs()
              )
          );
        }
      ),
    );
  }


}





