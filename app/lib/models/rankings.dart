library rankings;

import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Rankings {
  global,
  animal,
  brainTeasers,
  celebrities,
  entertainment,
  forKids,
  general,
  geography,
  history,
  hobbies,
  humanities,
  literature,
  movies,
  music,
  newest,
  people,
  rated,
  religion,
  scienceTechnology,
  sports,
  television,
  videoGames,
  world
}

Map<Rankings, int> ids = {
  Rankings.global: 0,
  Rankings.animal: 1,
  Rankings.brainTeasers: 2,
  Rankings.celebrities: 3,
  Rankings.entertainment: 4,
  Rankings.forKids: 5
};

Map<Rankings, String> names = {
  Rankings.global: "Global",
  Rankings.animal: "Animal",
  Rankings.brainTeasers: "Brain teasers",
  Rankings.celebrities: "Celebrities",
  Rankings.entertainment: "Entertainment",
  Rankings.forKids: "For Kids",
  Rankings.general: "General",
  Rankings.geography: "Geography",
  Rankings.history: "History",
  Rankings.hobbies: "Hobbies",
  Rankings.humanities: "Humanities",
  Rankings.literature: "Literature",
  Rankings.movies: "Movies",
  Rankings.music: "Music",
  Rankings.newest: "Newest",
  Rankings.people: "People",
  Rankings.rated: "Rated",
  Rankings.religion: "Religion",
  Rankings.scienceTechnology: "Science technology",
  Rankings.sports: "Sports",
  Rankings.television: "Television",
  Rankings.videoGames: "Video games",
  Rankings.world: "World",
};

Map<Rankings, IconData> icons = {
  Rankings.global: FontAwesomeIcons.medal,
  Rankings.animal: FontAwesomeIcons.paw,
  Rankings.brainTeasers: FontAwesomeIcons.brain,
  Rankings.celebrities: FontAwesomeIcons.plus,
  Rankings.entertainment: FontAwesomeIcons.plus,
  Rankings.forKids: FontAwesomeIcons.child,
  Rankings.general: FontAwesomeIcons.plus,
  Rankings.geography: FontAwesomeIcons.globeAmericas,
  Rankings.history: FontAwesomeIcons.pen,
  Rankings.hobbies: FontAwesomeIcons.plus,
  Rankings.humanities: FontAwesomeIcons.plus,
  Rankings.literature: FontAwesomeIcons.plus,
  Rankings.movies: FontAwesomeIcons.film,
  Rankings.music: FontAwesomeIcons.music,
  Rankings.newest: FontAwesomeIcons.newspaper,
  Rankings.people: FontAwesomeIcons.users,
  Rankings.rated: FontAwesomeIcons.star,
  Rankings.religion: FontAwesomeIcons.cross,
  Rankings.scienceTechnology: FontAwesomeIcons.flask,
  Rankings.sports: FontAwesomeIcons.futbol,
  Rankings.television: FontAwesomeIcons.tv,
  Rankings.videoGames: FontAwesomeIcons.gamepad,
  Rankings.world: FontAwesomeIcons.globe,
};