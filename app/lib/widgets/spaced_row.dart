import 'package:flutter/material.dart';

class SpacedRow extends StatelessWidget {
  
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;

  final double spacing;

  SpacedRow({
    this.children, 
    this.mainAxisAlignment = MainAxisAlignment.start, 
    this.mainAxisSize = MainAxisSize.max, 
    this.crossAxisAlignment = CrossAxisAlignment.start, 
    this.spacing = 15
  });
  
  @override
  Row build(BuildContext context) {
    List<SizedBox> spacers = this.children.map((e) => SizedBox(width: this.spacing)).toList();
    
    List<Widget> spacedChildren = List.generate(
      this.children.length * 2, 
      (index) => index % 2 == 0 ? this.children[(index / 2).floor()] : spacers[(index / 2).floor()]
    );

    return Row(
      children: spacedChildren,
      mainAxisAlignment: this.mainAxisAlignment,
      mainAxisSize: this.mainAxisSize,
      crossAxisAlignment: this.crossAxisAlignment,
    );
  }
}