import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../controllers/user_bloc.dart';
import '../../models/user.dart';
import '../../widgets/navigation_drawer.dart';
import 'game_history_list.dart';

class GameHistoryPage extends StatefulWidget {
  @override
  _GameHistoryPageState createState() => _GameHistoryPageState();
}

class _GameHistoryPageState extends State<GameHistoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: BlocProvider.getBloc<UserBloc>().getUser,
      builder: (BuildContext context, AsyncSnapshot<User> user) {
        if (!user.hasData) return Container();

        return Scaffold(
          drawer: NavigationDrawer(user.data),
          appBar: AppBar(
            title: Text("Game history"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: GameHistoryList(user: user.data)
          )
        );
      },
    );
  }
}
