import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sphinx/models/rankings.dart';
import 'package:sphinx/models/user.dart';
import 'package:sphinx/requests/GetRankingRequest.dart';
import 'package:http/http.dart' as http;

class RankingTab extends StatefulWidget {
  final MapEntry<Rankings, int> ranking;
  final User user;

  const RankingTab({Key key, this.ranking, this.user}) : super(key: key);

  @override
  _RankingTabState createState() => _RankingTabState();
}

class _RankingTabState extends State<RankingTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        this.header(context),
        this.ranking(context)
      ],
    );
  }

  Widget ranking(BuildContext context) {
    return FutureBuilder(
      future: GetRankingRequest(this.widget.user, [this.widget.ranking.value]).send(),
      builder: (BuildContext context, AsyncSnapshot<http.Response> response) {
        if (!response.hasData) return Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor)),
            ),
          ),
        );

        List<dynamic> data = jsonDecode(response.data.body);
        
        List<User> ranking = List.generate(data.length, (index) => User.fromJson(data[index]));

        List<Widget> children = List.generate(ranking.length, (index) => ListTile(
          title: Text(ranking[index].name),
          trailing: Text("${index + 1}"),
        ));

        return ListView(
          shrinkWrap: true,
          children: children
        );
      }
    );
  }

  Widget header(BuildContext context) {
    return ListTile(
      leading: Icon(icons[this.widget.ranking.key], color: Colors.white),
      tileColor: Theme.of(context).primaryColor,
      title: Text(
        names[this.widget.ranking.key],
        style: TextStyle(fontSize: 18.0, color: Colors.white),
      ),
    );
  }
}