import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/features/home/service_providers/widgets/hits_post.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/link_win_icon.dart';

class HitsTabView extends StatefulWidget {
  const HitsTabView({super.key});

  @override
  State<HitsTabView> createState() => _HitsTabViewState();
}

class _HitsTabViewState extends State<HitsTabView> {
  bool _isHeaderExpanded = false;
  double _headerHeightRatio = 0.15;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilderChild(
      child: (minSize, maxSize) {
        int itemsLength = 10;
        Size headerSize =
            Size(maxSize.width, maxSize.height * _headerHeightRatio);
        Size bodySize = Size(maxSize.width, maxSize.height - headerSize.height);
        return SizedBox(
          width: maxSize.width,
          height: maxSize.height,
          child: Column(
            children: [
              _hitsHeader(
                size: headerSize,
              ),
              _hitsListView(
                itemsLength: itemsLength,
                size: bodySize,
              ),
            ],
          ),
        );
      },
    );
  }

  _hitsHeader({
    required Size size,
  }) {
    double sidePad = size.width * 0.03;
    Size childSize = Size(size.width - 2 * sidePad, size.height);
    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.only(
        left: sidePad,
        right: sidePad,
      ),
      decoration: BoxDecoration(
        color: kUnSelectedTabColor,
        border: Border.all(
          width: 2,
          color: kBlack,
        ),
        borderRadius: BorderRadius.circular(size.width * 0.05),
      ),
      child: _isHeaderExpanded
          ? _expandedHeader(childSize)
          : _collapseHeader(childSize),
    );
  }

  _collapseHeader(Size size) {
    return Row(
      children: [
        _expandIcon(size.height * 0.55),
      ],
    );
  }

// Attributes:
// Price Range, (minimum, maximum)
// Rating & Reviews
// Availability
// Service Type
// Service Provider Profile: (image, name, rating (0 - 5))
// offered_at (DateTime), requested_at (DateTime)
//

  _expandedHeader(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: size.width,
          height: size.height * 0.15,
          color: Colors.purple,
          alignment: AlignmentDirectional.centerEnd,
          child: LayoutBuilderChild(
            child: (minSize, maxSize) => _expandIcon(maxSize.height * 0.9),
          ),
        ),
        SizedBox(
          width: size.width,
          height: size.height * 0.2,
          child: LayoutBuilderChild(
            child: (minSize, maxSize) {
              Size labelSize = Size(maxSize.width * 0.4, maxSize.height);
              Size dropdownSize =
                  Size(maxSize.width - labelSize.width, maxSize.height);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: labelSize.width,
                    height: labelSize.height,
                    color: Colors.pink,
                    alignment: AlignmentDirectional.center,
                    child: const Text(
                      'Service Type',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.green,
                    width: dropdownSize.width,
                    height: dropdownSize.height,
                  )
                ],
              );
            },
          ),
        ),
        Container(
          width: size.width,
          height: size.height * 0.15,
          color: Colors.blue,
        ),
        Container(
          width: size.width,
          height: size.height * 0.3,
          color: Colors.red,
        ),
      ],
    );
  }

  _expandIcon(double iconSize) => _isHeaderExpanded
      ? _headerIcon(
          iconSize: iconSize,
          iconData: FontAwesomeIcons.circleXmark,
          onTap: () {
            setState(() {
              _isHeaderExpanded = !_isHeaderExpanded;
              _headerHeightRatio = 0.15;
            });
          },
        )
      : _headerIcon(
          iconSize: iconSize,
          iconData: FontAwesomeIcons.chevronDown,
          onTap: () {
            setState(() {
              _isHeaderExpanded = !_isHeaderExpanded;
              _headerHeightRatio = 0.5;
            });
          },
        );

  _headerIcon({
    required double iconSize,
    required IconData iconData,
    required VoidCallback onTap,
    double iconSizeRatio = 0.8,
  }) =>
      LinkWinIcon(
        iconSize: Size(iconSize, iconSize),
        iconColor: kBlack,
        splashColor: transparent,
        iconData: iconData,
        iconSizeRatio: iconSizeRatio,
        onTap: onTap,
      );

  _hitsListView({
    required int itemsLength,
    required Size size,
  }) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: ListView.separated(
        itemCount: itemsLength + 1,
        itemBuilder: (context, index) => index == itemsLength
            ? SizedBox(
                height: size.height * 0.05,
              )
            : SizedBox(
                width: size.width,
                height: size.height * 0.2,
                child: const HitsPost(),
              ),
        separatorBuilder: (context, index) => SizedBox(
          height: size.height * 0.025,
        ),
      ),
    );
  }
}
