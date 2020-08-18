import 'package:flutter/material.dart';
TextStyle kButtonStyle= TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold);

final kSnackBarForSaved = SnackBar(
  content: Text('Yay! Status Saved!'),
  backgroundColor: Colors.lightGreen,
  duration: Duration(seconds: 1),
  elevation: 6.0,
);

final kSnackBarForDelete = SnackBar(
  content: Text('Status Deleted'),
  backgroundColor: Colors.lightGreen,
  duration: Duration(seconds: 1),
  elevation: 6.0,
);


