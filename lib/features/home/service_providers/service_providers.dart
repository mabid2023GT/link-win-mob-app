import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/features/home/service_providers/widgets/service_provider_appointment_overview.dart';
import 'package:link_win_mob_app/features/home/service_providers/widgets/service_provider_search_engine.dart';
import 'package:link_win_mob_app/providers/auth/auth_provider.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/auto_responsive_percentage_layout.dart';
import 'package:link_win_mob_app/features/auth/widget/not_authenticated_widget.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/link_win_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServiceProviders extends ConsumerStatefulWidget {
  const ServiceProviders({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ServiceProvidersState();
}

class _ServiceProvidersState extends ConsumerState<ServiceProviders> {
  final ValueNotifier<int> _tappedIconNotifier = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    // Listen for changes in the auth provider.
    // If the user signs out, the NotAuthenticatedWidget will be displayed
    // immediately; otherwise, the profile screen will be shown.
    final user = ref.watch(authProvider).user;
    // Check if the user is signed in
    if (user == null) {
      return NotAuthenticatedWidget();
    } else {
      ScreenUtil screenUtil = ScreenUtil(context);
      return _serviceProvider(screenUtil);
    }
  }

  _serviceProvider(ScreenUtil screenUtil) {
    return AutoResponsivePercentageLayout(
      screenUtil: screenUtil,
      isRow: false,
      percentages: const [30, 70],
      children: [
        _header(),
        _body(),
      ],
    );
  }

  _header() {
    return LayoutChildBuilder(
      child: (minSize, maxSize) {
        Size topWidgetSize = Size(maxSize.width, maxSize.height * 0.95);
        Size bottomWidgetSize =
            Size(maxSize.width, maxSize.height - topWidgetSize.height);

        return Stack(
          children: [
            _headerBackground(topWidgetSize, bottomWidgetSize),
            ..._headerChildren(
              topWidgetSize,
            )
          ],
        );
      },
    );
  }

  _headerBackground(Size topWidgetSize, Size bottomWidgetSize) {
    return Column(
      children: [
        Container(
          width: topWidgetSize.width,
          height: topWidgetSize.height,
          decoration: BoxDecoration(
            color: kHeaderColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(topWidgetSize.width),
              bottomLeft: Radius.circular(topWidgetSize.width),
            ),
          ),
        ),
        Container(
          width: bottomWidgetSize.width,
          height: bottomWidgetSize.height,
          color: kWhite,
        )
      ],
    );
  }

  List<Widget> _headerChildren(
    Size size,
  ) {
    double circleSize = size.shortestSide * 0.4;
    double firstRowTopPosition = size.height * 0.35;
    double firstRowSidePosition = size.width * 0.025;
    double secondRowTopPosition = size.height * 0.7;
    double secondRowSidePosition = size.width * 0.225;
    Size titleSize =
        Size(size.width - 2 * secondRowSidePosition, size.height * 0.4);
    return [
      Positioned(
          top: size.height * 0.25,
          left: secondRowSidePosition,
          child: _headerTitle(titleSize)),
      _positionHeaderChild(
          firstRowTopPosition,
          firstRowSidePosition,
          _headerIcon(circleSize, FontAwesomeIcons.arrowsDownToPeople, 0),
          true),
      _positionHeaderChild(secondRowTopPosition, secondRowSidePosition,
          _headerIcon(circleSize, FontAwesomeIcons.calendarCheck, 1), true),
      _positionHeaderChild(secondRowTopPosition, secondRowSidePosition,
          _headerIcon(circleSize, FontAwesomeIcons.searchengin, 2), false),
      _positionHeaderChild(firstRowTopPosition, firstRowSidePosition,
          _headerIcon(circleSize, FontAwesomeIcons.user, 3), false),
    ];
  }

  _positionHeaderChild(double top, double side, Widget child, bool isLeftSide) {
    return Positioned(
      top: top,
      left: isLeftSide ? side : null,
      right: !isLeftSide ? side : null,
      child: child,
    );
  }

  _headerIcon(double circleSize, IconData iconData, int index) {
    double padding = circleSize * 0.1;
    Size size = Size(circleSize - 2 * padding, circleSize - 2 * padding);
    return Container(
      width: circleSize,
      height: circleSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: kWhite,
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: LinkWinIcon(
            iconSize: size,
            iconColor: kHeaderColor,
            iconData: iconData,
            iconSizeRatio: 0.7,
            splashColor: kHeaderColor.withOpacity(0.25),
            onTap: () => _tappedIconNotifier.value = index,
          ),
        ),
      ),
    );
  }

  _headerTitle(Size size) {
    TextStyle style = TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      fontFamily: 'Lato',
    );
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: ['Service', 'Providers']
            .map(
              (val) => Text(
                val,
                style: style,
              ),
            )
            .toList(),
      ),
    );
  }

  _body() {
    return LayoutChildBuilder(
      child: (minSize, maxSize) {
        return ValueListenableBuilder(
          valueListenable: _tappedIconNotifier,
          builder: (context, value, child) {
            switch (value) {
              case 0:
                return _aW();
              case 1:
                return _widgetWrapper(ServiceProviderAppointmentOverview());
              case 2:
                return _widgetWrapper(ServiceProviderSearchEngine());
              case 3:
                return _dW();
              default:
                return _aW();
            }
          },
        );
      },
    );
  }

  _aW() {
    return Container(
      width: 500,
      height: 300,
      color: Colors.yellow,
    );
  }

  _widgetWrapper(Widget child) {
    return LayoutChildBuilder(
      child: (minSize, maxSize) {
        double sidePad = maxSize.width * 0.05;
        return Padding(
          padding: EdgeInsets.only(left: sidePad, right: sidePad),
          child: child,
        );
      },
    );
  }

  _dW() {
    return Container(
      width: 500,
      height: 300,
      color: kRed,
    );
  }
}
