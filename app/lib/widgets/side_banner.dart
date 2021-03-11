import 'package:flutter/material.dart';

enum SideBannerDirection {
  left, right
}

class SideBanner extends StatelessWidget {

  final String title;
  final SideBannerDirection direction;
  final Color backgroundColor;

  const SideBanner({Key key, this.title, this.direction = SideBannerDirection.left, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: this.direction == SideBannerDirection.left ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              color: this.backgroundColor ?? Theme.of(context).accentColor,
              borderRadius: BorderRadius.horizontal(
                right: this.direction == SideBannerDirection.left ? Radius.circular(100.0) : Radius.circular(0),
                left: this.direction == SideBannerDirection.left ? Radius.circular(0.0) : Radius.circular(100.0),
              )
            ),
            child: Center(
              child: Text(this.title, style: Theme.of(context).textTheme.subtitle1),
            ),
          )
        ],
      ),
    );
  }
}