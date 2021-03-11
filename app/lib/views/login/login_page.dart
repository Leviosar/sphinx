import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../widgets/logo.dart';
import 'login_form.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 50.0),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Logo(),
              LoginForm(),
              WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [Colors.blue, Theme.of(context).accentColor],
                    [Colors.blue[800], Colors.blue[300]],
                    [Colors.blue[500], Colors.blue[300].withAlpha(80)],
                    [Colors.blue[300], Colors.blue[300].withAlpha(50)]
                  ],
                  durations: [35000, 19440, 10800, 6000],
                  heightPercentages: [0.20, 0.23, 0.25, 0.30],
                  blur: MaskFilter.blur(BlurStyle.solid, 10),
                  gradientBegin: Alignment.bottomLeft,
                  gradientEnd: Alignment.topRight,
                ),
                size: Size(MediaQuery.of(context).size.width, 100)
              )
            ],
          ),
        )
      ),
    );
  }
}