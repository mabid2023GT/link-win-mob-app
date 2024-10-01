import 'package:flutter/material.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class CenteredTitleHeader extends StatelessWidget {
  final String title;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  const CenteredTitleHeader({
    super.key,
    required this.title,
    this.fontFamily = 'Montserrat',
    this.fontSize = 22,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        Size topPartSize = Size(maxSize.width, maxSize.height * 0.4);
        Size bottomPartSize =
            Size(maxSize.width, maxSize.height - topPartSize.height);
        return _body(maxSize, topPartSize, bottomPartSize);
      },
    );
  }

  _body(Size maxSize, Size topPartSize, Size bottomPartSize) => SizedBox(
        width: maxSize.width,
        height: maxSize.height,
        child: Column(
          children: [
            _topSpace(topPartSize),
            Container(
              width: bottomPartSize.width,
              height: bottomPartSize.height,
              alignment: AlignmentDirectional.center,
              child: _title(),
            ),
          ],
        ),
      );

  _topSpace(Size topPartSize) => SizedBox(
        width: topPartSize.width,
        height: topPartSize.height,
      );

  _title() => Text(
        title,
        style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          fontFamily: fontFamily,
        ),
      );
}
