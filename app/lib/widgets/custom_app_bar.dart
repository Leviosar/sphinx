import 'package:flutter/material.dart';

import '../animations/particle.dart';
import '../models/user.dart';
import 'lifes_button.dart';
import 'trophy_button.dart';

class CustomAppBar extends StatelessWidget{

  final User user;

  CustomAppBar(this.user);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: 300.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(40.0))
                  ),
                )
              ),
              Positioned.fill(child: Particles(5)),
              Positioned.fill(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      LifesButton(),
                      CircleAvatar(
                        radius: 60.0,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 55.0,
                          backgroundImage: NetworkImage(this.user.photo),
                        ),
                      ),
                      TrophyButton(),
                    ],
                  ),
                )
              ),
            ],
          ),
        ),
        title: Text("Oi, ${this.user.name.split(' ').first}"),
      ),
    );
  }
}