import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class ServiceProviderSearchQueryBox extends StatefulWidget {
  final Map<String, List<String>> queries;
  final Size queryWidgetSize;
  const ServiceProviderSearchQueryBox({
    super.key,
    required this.queries,
    required this.queryWidgetSize,
  });

  @override
  State<ServiceProviderSearchQueryBox> createState() =>
      _ServiceProviderSearchQueryBoxState();
}

class _ServiceProviderSearchQueryBoxState
    extends State<ServiceProviderSearchQueryBox> {
  bool _isOptionsWidgetVisible = true;
  List<String> _queries = [];
  final List<Widget> _queriesWidgets = [];
  int _currentQueryIndex = 0;

  @override
  void initState() {
    super.initState();
    // store the queries as list to fetch it by index
    _queries = widget.queries.keys.toList();
    // Add the first question initially
    _addNextQuery();
  }

  _addNextQuery() {
    if (_currentQueryIndex < widget.queries.length) {
      String query = _queries[_currentQueryIndex];
      // add new query widget to the list
      _queriesWidgets.add(
        _queryWidget(
          widget.queryWidgetSize,
          query,
          true,
        ),
      );
      _queriesWidgets.add(
        SizedBox(
          height: widget.queryWidgetSize.height * 0.1,
        ),
      );
      _queriesWidgets.add(
        _queryWidget(
          widget.queryWidgetSize,
          'Im fine thanks',
          false,
        ),
      );
      _queriesWidgets.add(
        SizedBox(
          height: widget.queryWidgetSize.height * 0.4,
        ),
      );
      // Trigger a UI rebuild with the new question added
      setState(() {});
    }
  }

  void _handleOptionSelected() {
    // Increment to show the next question
    _currentQueryIndex++;
    // Add the next question (if any)
    _addNextQuery();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutChildBuilder(
      child: (minSize, maxSize) {
        return Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: SizedBox(
                width: maxSize.width,
                height: maxSize.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: _queriesWidgets,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _isOptionsWidgetVisible,
              child: _optionsWidget(maxSize),
            ),
          ],
        );
      },
    );
  }

  _queryWidget(Size size, String value, bool isQuery) {
    Size iconSize = Size(size.width * 0.15, size.height);
    double prefixSpaceSize = isQuery ? 0 : size.width * 0.15;
    double spaceSize = size.width * 0.05;
    Size labelSize = Size(
        size.width - iconSize.width - spaceSize - prefixSpaceSize, size.height);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible: !isQuery,
          child: SizedBox(
            width: spaceSize,
          ),
        ),
        Container(
          width: iconSize.width,
          height: iconSize.height,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kSelectedTabColor,
              border: Border.all(width: 2, color: kBlack)),
          child: Icon(isQuery ? FontAwesomeIcons.robot : FontAwesomeIcons.user),
        ),
        Container(
          width: labelSize.width,
          height: labelSize.height,
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato',
            ),
          ),
        ),
      ],
    );
  }

  _optionsWidget(Size size) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: InkWell(
        onTap: _handleOptionSelected,
        child: Container(
          width: size.width * 0.9,
          height: size.height * 0.3,
          color: k1Gray.withOpacity(0.4),
          child: Text('Next'),
        ),
      ),
    );
  }
}
