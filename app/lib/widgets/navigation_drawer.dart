import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Drawer build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(''),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text(''),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text(''),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      )
    );
  }
}