import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:sphinx/views/home/home_page_challenges.dart';
import 'package:sphinx/views/home/home_page_ranking.dart';

import '../../controllers/user_bloc.dart';
import '../../models/user.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/navigation_drawer.dart';
import '../../widgets/side_banner.dart';
import 'game_mode_selection.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ScrollController controller = ScrollController();

  onScroll() {
    controller.offset;
  }

  @override
  void initState() {
    this.controller.addListener(this.onScroll);
    super.initState();
  }

  @override
  void dispose() {
    this.controller.dispose();
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
          body: CustomScrollView(
            slivers: [
              CustomAppBar(user.data),
              SliverToBoxAdapter(
                child: SideBanner(title: "Jogar"),
              ),
              SliverToBoxAdapter(
                child: GameModeSelection(),
              ),
              SliverToBoxAdapter(
                child: SideBanner(title: "Ranking", direction: SideBannerDirection.right),
              ),
              SliverToBoxAdapter(
                child: HomePageRanking(),
              ),
              SliverToBoxAdapter(
                child: SideBanner(title: "Challenges", direction: SideBannerDirection.left),
              ),
              SliverToBoxAdapter(
                child: HomePageChallenges(user: user.data),
              ),
              SliverFixedExtentList(
                itemExtent: 50.0,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.lightBlue[100 * (index % 9)],
                    );
                  },
                ),
              ),
            ],
          )
        );
      },
    );
  }
}