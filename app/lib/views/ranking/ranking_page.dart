import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sphinx/models/rankings.dart' as rankings;
import 'package:sphinx/views/ranking/ranking_tab.dart';

import '../../controllers/user_bloc.dart';
import '../../models/user.dart';
import '../../widgets/navigation_drawer.dart';

class RankingPage extends StatefulWidget {
  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
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
            title: Text("Rankings"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: CarouselSlider(
              items: this.tabs(context, rankings.ids, user.data),
              options: CarouselOptions(
                viewportFraction: 1.0,
                height: 600
              ),
            ),
          )
        );
      },
    );
  }

  List<Widget> tabs(BuildContext context, Map<rankings.Rankings, int> ids, User user) {
    return ids.entries.map((entry) => RankingTab(ranking: entry, user: user)).toList();
  }
}
