import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'controllers/categories_bloc.dart';
import 'controllers/game_bloc.dart';
import 'controllers/user_bloc.dart';
import 'routes/routes.dart' as routes;
import 'views/login/login_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: this.blocs(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
        routes: routes.named,
        theme: ThemeData(
          accentColor: Color(0xfff4e3bd),
          primaryColor: Color(0xff1f89ca),
        ),
      ),
    );
  }

  List<Bloc<BlocBase>> blocs() {
    return [
      Bloc((i) => UserBloc()),
      Bloc((i) => CategoriesBloc()),
      Bloc((i) => GameBloc()),
    ];
  }
}