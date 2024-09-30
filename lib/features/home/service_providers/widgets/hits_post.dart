import 'package:flutter/material.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class HitsPost extends StatelessWidget {
  const HitsPost({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        return Container(
          width: maxSize.width,
          height: maxSize.height,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.7),
            borderRadius: BorderRadius.circular(maxSize.width * 0.1),
          ),
        );
      },
    );
  }
}
