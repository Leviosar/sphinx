import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/challenge.dart';
import '../../models/user.dart';
import '../../requests/GetChallenges.dart';

class HomePageChallenges extends StatefulWidget {

  final User user;

  const HomePageChallenges({Key key, this.user}) : super(key: key);

  @override
  _HomePageChallengesState createState() => _HomePageChallengesState();
}

class _HomePageChallengesState extends State<HomePageChallenges> {

  List<Challenge> challenges = [];
  bool searching;

  @override
  initState() {
    super.initState();
    this.fetchChallenges();
  }

  @override
  Widget build(BuildContext context) {
    if (this.challenges.isEmpty) return Container();

    return ListView(
      shrinkWrap: true,
      children: List.generate(
        this.challenges.length, 
        (int index) {
          if (this.challenges[index].finished) return this.buildFinishedChallenge(this.challenges[index]);

          if (this.challenges[index].amIChallenger(this.widget.user)) return this.buildAwaitingOponentChallenge(this.challenges[index]);
          
          if (this.challenges[index].amIChallenged(this.widget.user)) return this.buildPlayableChallenge(this.challenges[index]);
          
          return Container();
        }
      ),
    );
  }

  void fetchChallenges() async {
    this.searching = true;
    
    http.Response response = await (new GetChallenges(this.widget.user)).send();
    List<dynamic> data = jsonDecode(response.body);

    setState(() {
      this.challenges = data.map((challenge) => Challenge.fromJson(challenge)).toList();
    });
    
    this.searching = false;
  }

  Widget buildFinishedChallenge(Challenge challenge) {
    bool won = false;

    if (this.widget.user.id == challenge.challengedUser.id) {
      won = challenge.challengedGame.points > challenge.challengerGame.points;
    } else {
      won = challenge.challengedGame.points < challenge.challengerGame.points;
    }
    
    return ListTile(
      trailing: CircleAvatar(
        backgroundColor: won ? Colors.green : Colors.red,
        child: Icon(won ? Icons.check : Icons.close, color: Colors.white),
      ),
      title: Text(challenge.amIChallenger(this.widget.user) ? challenge.challengedUser.name : challenge.challengerUser.name),
      subtitle: Text(challenge.amIChallenger(this.widget.user) ? challenge.challengedUser.email : challenge.challengerUser.email),
    );
  }

  Widget buildAwaitingOponentChallenge(Challenge challenge) {
    return ListTile(
      title: Text(challenge.challengedUser.name),
      subtitle: Text(challenge.challengedUser.email),
      trailing: ElevatedButton(child: Text("Awaiting oponent")),
    );
  }

  Widget buildPlayableChallenge(Challenge challenge) {
    return ListTile(
      title: Text(challenge.challengerUser.name),
      subtitle: Text(challenge.challengerUser.email),
      trailing: ElevatedButton(child: Text("Play"), onPressed: (){}),
    );
  }
}