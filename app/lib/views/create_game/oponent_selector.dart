import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sphinx/models/user.dart';
import 'package:sphinx/requests/SearchUsers.dart';
import 'package:http/http.dart' as http;
import 'package:sphinx/widgets/side_banner.dart';

typedef OponentSelectorCallback = Function(User user);

class OponentSelector extends StatefulWidget {

  final OponentSelectorCallback onChanged;

  const OponentSelector({Key key, this.onChanged}) : super(key: key);

  @override
  _OponentSelectorState createState() => _OponentSelectorState();
}

class _OponentSelectorState extends State<OponentSelector> {

  TextEditingController controller = new TextEditingController(text: "");

  int selectIndex = -1;

  List<User> users = [];

  bool searching = false;

  @override
  initState() {
    super.initState();
    this.fetchUsers();

    this.controller.addListener(() {
      this.fetchUsers();
    });
  }

  void fetchUsers() async {
    this.searching = true;
    http.Response response = await (new SearchUsers(this.controller.value.text)).send();
    List<dynamic> data = jsonDecode(response.body);
    this.users = data.map((user) => User.fromJson(user)).toList();
    this.searching = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SideBanner(title: "Challenge"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: TextField(
            controller: this.controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffixIcon: Icon(FontAwesomeIcons.search),
              labelText: "E-mail"
            ),
          ),
        ),
        buildUserList(context)
      ],
    );
  }

  Widget buildUserList(BuildContext context) {
    if (this.searching && this.users.isEmpty) return CircularProgressIndicator();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) => CheckboxListTile(
          title: Text(users[index].name),
          subtitle: Text(users[index].email),
          secondary: CircleAvatar(backgroundImage: NetworkImage(users[index].photo)),
          activeColor: Theme.of(context).primaryColor,
          value: this.selectIndex == index,
          onChanged: (bool value) {
            setState(() {
              this.selectIndex = index;
              this.widget.onChanged(users[index]);
            });
          },
        ),
        itemCount: users.length,
      ),
    );
  }
}