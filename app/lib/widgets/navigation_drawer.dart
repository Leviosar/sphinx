import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sphinx/models/user.dart';

class NavigationDrawer extends StatelessWidget {

  final User user;

  const NavigationDrawer(this.user);

  @override
  Drawer build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                child: CircleAvatar(
                  foregroundImage: NetworkImage(user.photo, scale: 0.5),
                ),
                onTap: () => this.push(context, "/home"),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: IconButton(
              icon: Icon(FontAwesomeIcons.home, color: Theme.of(context).primaryColor),
              onPressed: () {},
            ),
            title: Text('Home'),
            onTap: () => this.push(context, "/home"),
          ),
          ListTile(
            leading: IconButton(
              icon: Icon(FontAwesomeIcons.gamepad, color: Theme.of(context).primaryColor),
              onPressed: () {},
            ),
            title: Text('Game history'),
            onTap: () {},
          ),
          ListTile(
            leading: IconButton(
              icon: Icon(FontAwesomeIcons.medal, color: Theme.of(context).primaryColor),
              onPressed: () {},
            ),
            title: Text('Ranking'),
            onTap: () => this.push(context, "/ranking")
          ),
          ListTile(
            leading: IconButton(
              icon: Icon(FontAwesomeIcons.signOutAlt, color: Theme.of(context).primaryColor),
              onPressed: () {},
            ),
            title: Text('Sign out'),
            onTap: () {},
          ),
        ],
      )
    );
  }

  void push(BuildContext context, String route) {
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(route);
  }
}