import 'package:flutter/material.dart';

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
