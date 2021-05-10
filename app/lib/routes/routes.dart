library routes;

import 'package:flutter/material.dart';
import 'package:sphinx/views/home/home_page.dart';
import 'package:sphinx/views/login/login_page.dart';
import 'package:sphinx/views/ranking/ranking_page.dart';

typedef Widget Route (BuildContext context);

Map<String, Route> named = {
  "/login": (BuildContext context) => LoginPage(),
  "/home": (BuildContext context) => HomePage(),
  "/ranking": (BuildContext context) => RankingPage(),
};