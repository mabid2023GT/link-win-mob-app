import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:rive/rive.dart';

class ServiceProviderSearchQueryBox extends StatefulWidget {
  final Map<String, List<String>> queries;
  final Size size;
  const ServiceProviderSearchQueryBox({
    super.key,
    required this.queries,
    required this.size,
  });

  @override
  State<ServiceProviderSearchQueryBox> createState() =>
      _ServiceProviderSearchQueryBoxState();
}

class _ServiceProviderSearchQueryBoxState
    extends State<ServiceProviderSearchQueryBox> {
  //
  final AudioPlayer _typingSoundEffectPlayer = AudioPlayer();
  //
  bool _isOptionsWidgetVisible = false;
  bool _isChatbotTyping = false;
  // queries data
  List<String> _queries = [];
  final List<Widget> _queriesWidgets = [];
  int _currentQueryIndex = 0;
  // declare size attributs
  late Size _queryWidgetSize;
  late Size _optionsWidgetSize;
  // scroll controller
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // initialize size attributes
    _queryWidgetSize = Size(widget.size.width, widget.size.height * 0.15);
    _optionsWidgetSize = Size(widget.size.width, widget.size.height * 0.3);
    // store the queries as list to fetch it by index
    _queries = widget.queries.keys.toList();
    // Add the first question initially
    _addNextQuery();
    // You can call the scrollToBottom method initially or after a delay if needed.
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void didUpdateWidget(ServiceProviderSearchQueryBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Scroll to the bottom after every update.
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _addNextQuery() {
    if (_currentQueryIndex < _queries.length) {
      String query = _queries[_currentQueryIndex];
      // add new query widget to the list
      _queriesWidgets.add(
        _queryWidget(
          query,
          true,
        ),
      );
      _queriesWidgets.add(
        SizedBox(
          height: widget.size.height * 0.05,
        ),
      );
      // Trigger a UI rebuild with the new question added
      setState(() {
        // hide the typing widget
        _isChatbotTyping = false;
        // Make the options widget visible
        _isOptionsWidgetVisible = true;
        // Scroll to the bottom after every update.
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      });
    }
  }

  _addSelectedOption(String selectedOption) async {
    if (_currentQueryIndex < _queries.length) {
      _queriesWidgets.add(
        _queryWidget(
          selectedOption,
          false,
        ),
      );
      _queriesWidgets.add(
        SizedBox(
          height: widget.size.height * 0.1,
        ),
      );
      // Trigger a UI rebuild with the new question added
      setState(() {
        // hide the options widget
        _isOptionsWidgetVisible = false;
        // Increment to show the next question
        _currentQueryIndex++;
        // display the typing widget
        _isChatbotTyping = true;
        // Scroll to the bottom after every update.
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      });
      if (_currentQueryIndex < _queries.length) {
        // Play typing sound
        await _typingSoundEffectPlayer.setVolume(1.0);
        await _typingSoundEffectPlayer
            .play(AssetSource('sounds/typing_sound_effect.mp3'));
        // Add a delay of 2 to 3 seconds before calling _addNextQuery
        Future.delayed(const Duration(seconds: 2), () async {
          await _typingSoundEffectPlayer.stop();
          // add next query
          _addNextQuery();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          child: SizedBox(
            width: widget.size.width,
            height: widget.size.height,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  ..._queriesWidgets, // Add space at the bottom when the options widget is visible to ensure the last query is clearly displayed
                  _chatbotTypingWidget(),
                  _bottomspaceWidget(),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: _isOptionsWidgetVisible,
          child: _optionsWidget(),
        ),
        Visibility(
          visible: _currentQueryIndex >= _queries.length,
          child: _searchWidget(),
        ),
      ],
    );
  }

  _bottomspaceWidget() {
    return Visibility(
      visible:
          _isOptionsWidgetVisible || (_currentQueryIndex >= _queries.length),
      child: SizedBox(
        height: _optionsWidgetSize.height *
            ((_currentQueryIndex >= _queries.length) ? 0.5 : 1),
      ),
    );
  }

  _chatbotTypingWidget() {
    return Visibility(
      visible: _isChatbotTyping && (_currentQueryIndex < _queries.length),
      child: Container(
        width: _queryWidgetSize.width,
        height: _queryWidgetSize.height,
        color: transparent,
        alignment: AlignmentDirectional.centerStart,
        child: SizedBox(
          width: _queryWidgetSize.width * 0.3,
          height: _queryWidgetSize.height,
          child: RiveAnimation.asset(
            'assets/riv/typing_effect.riv',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  _queryWidget(String value, bool isQuery) {
    Size iconSize =
        Size(_queryWidgetSize.width * 0.15, _queryWidgetSize.height);
    double prefixSpaceSize = isQuery ? 0 : _queryWidgetSize.width * 0.15;
    double spaceSize = _queryWidgetSize.width * 0.05;
    Size labelSize = Size(
        _queryWidgetSize.width - iconSize.width - spaceSize - prefixSpaceSize,
        _queryWidgetSize.height);
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

  _searchWidget() {
    Size size =
        Size(_optionsWidgetSize.width * 0.6, _optionsWidgetSize.height * 0.6);
    double sidePos = (_optionsWidgetSize.width - size.width) * 0.5;
    return Positioned(
      bottom: 0,
      left: sidePos,
      right: sidePos,
      child: Material(
        color: transparent,
        child: InkWell(
          onTap: () {},
          splashColor: kWhite,
          child: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              color: kSelectedTabColor,
              borderRadius: BorderRadius.circular(size.width * 0.1),
              border: Border.all(color: kBlack, width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.2,
                  height: size.height,
                  child: Icon(
                    FontAwesomeIcons.searchengin,
                    size: size.height * 0.5,
                  ),
                ),
                Container(
                  width: size.width * 0.5,
                  height: size.height,
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    'Search',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _optionsWidget() {
    if (_currentQueryIndex >= _queries.length) {
      return SizedBox();
    }
    // Fetch options
    String currentQuery = _queries[_currentQueryIndex];
    List<String> optionsList = widget.queries[currentQuery] ?? [];
    // Declare sizes and dimensions
    double sidePad = _optionsWidgetSize.width * 0.05;
    double topBottomPad = _optionsWidgetSize.height * 0.05;
    Size childSize = Size(_optionsWidgetSize.width - 2 * sidePad,
        _optionsWidgetSize.height - 2 * topBottomPad);

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        width: _optionsWidgetSize.width,
        height: _optionsWidgetSize.height,
        padding: EdgeInsets.only(
          left: sidePad,
          right: sidePad,
          top: topBottomPad,
          bottom: topBottomPad,
        ),
        decoration: BoxDecoration(
            color: kWhite.withOpacity(0.4),
            borderRadius:
                BorderRadius.circular(_optionsWidgetSize.width * 0.1)),
        child: optionsList.length <= 2
            ? _twoOrFewerOptionsWidget(optionsList, childSize)
            : _optionsAsListView(optionsList, childSize),
      ),
    );
  }

  _optionsAsListView(List<String> optionsList, Size size) {
    return ListView.separated(
      itemCount: optionsList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        String option = optionsList[index];
        return _optionBox(
          option,
          size,
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          width: size.width * 0.05,
        );
      },
    );
  }

  _twoOrFewerOptionsWidget(List<String> optionsList, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: optionsList
          .map(
            (option) => _optionBox(
              option,
              size,
            ),
          )
          .toList(),
    );
  }

  Widget _optionBox(String option, Size size) {
    return InkWell(
      onTap: () => _addSelectedOption(option),
      child: Container(
        width: size.width * 0.4,
        height: size.height * 0.8,
        decoration: BoxDecoration(
          color: kHeaderColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(size.width * 0.1),
        ),
        alignment: AlignmentDirectional.center,
        child: Text(
          option,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
      ),
    );
  }
}
