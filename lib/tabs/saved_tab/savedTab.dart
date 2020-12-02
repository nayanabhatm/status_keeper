import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statuskeeper/models/status_store.dart';
import 'package:statuskeeper/tabs/saved_tab/imagesSavedTab.dart';
import 'package:statuskeeper/tabs/saved_tab/videosSavedTab.dart';

class Saved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<StatusStore>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Transform.scale(
            scale: 3.0,
            child: Switch(
              value: state.isSwitched,
              onChanged: (newSwitchValue) {
                state.toggleIsSwitched(newSwitchValue);
              },
              activeTrackColor: Colors.lightGreenAccent.shade200,
              activeColor: Colors.lightGreenAccent,
              inactiveThumbColor: Colors.green.shade400,
              inactiveTrackColor: Colors.green.shade400,
            ),
          ),
        ),
        state.isSwitched
            ? Expanded(
                child: Column(
                  children: [
                    Text("Images"),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: ImagesSaved(),
                    ),
                  ],
                ),
              )
            : Expanded(
                child: Column(
                  children: [
                    Text("Videos"),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: VideosSaved(),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
