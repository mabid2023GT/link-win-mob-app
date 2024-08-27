import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:link_win_mob_app/core/config/colors.dart';

class NavFloatingActionButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  const NavFloatingActionButton({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Transform.rotate(
        angle: math.pi / 4,
        child: Container(
          width: 60.0,
          height: 60.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: kBlack,
            borderRadius: BorderRadius.circular(23.0),
          ),
          child: Transform.rotate(
            angle: -math.pi / 4,
            child: child,
          ),
        ),
      ),
    );
  }
}
