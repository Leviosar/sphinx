import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:sphinx/controllers/user_bloc.dart';
import 'package:sphinx/models/user.dart';

class HomePageRanking extends StatefulWidget {
  @override
  _HomePageRankingState createState() => _HomePageRankingState();
}

class _HomePageRankingState extends State<HomePageRanking> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: BlocProvider.getBloc<UserBloc>().getRanking,
      builder: (BuildContext context, AsyncSnapshot<List<User>> users) => users.hasData ? Column(
        children: List.generate(
          users.data.length, 
          (int index) => ListTile(
            title: Text(users.data[index].name),
            // leading: CircleAvatar(backgroundImage: NetworkImage(users.data[index].photo)),
            trailing: Text("${index + 1}"),
          )
        ),
      ) : Container()
    );
  }
}