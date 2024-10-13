import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/service_providers/service_providers_search_model.dart';
import 'package:link_win_mob_app/providers/service_providers/service_providers_search_query_notifier.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class ServiceProviderSearchEngine extends ConsumerWidget {
  ServiceProviderSearchEngine({super.key});
  final ValueNotifier<bool> _isActionsWidgetVisibleNotifier =
      ValueNotifier(false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(serviceProvidersSearchQueryProvider);

    return LayoutChildBuilder(
      child: (minSize, maxSize) {
        double bottomPad = maxSize.height * 0.08;
        double borderRadius = maxSize.shortestSide * 0.1;
        double topBottomPad = maxSize.height * 0.05;
        double sidePad = maxSize.width * 0.025;

        return Padding(
          padding: EdgeInsets.only(bottom: bottomPad),
          child: Container(
            width: maxSize.width,
            height: maxSize.height,
            padding: EdgeInsets.only(
              left: sidePad,
              right: sidePad,
              top: topBottomPad,
              bottom: topBottomPad,
            ),
            decoration: BoxDecoration(
              color: kHeaderColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: _searchLayout(searchQuery),
          ),
        );
      },
    );
  }

  _searchLayout(ServiceProvidersSearchQuery searchQuery) {
    return LayoutChildBuilder(
      child: (minSize, maxSize) {
        Size itemSize = Size(maxSize.width * 0.9, maxSize.height * 0.15);
        Size actionsWidgetSize =
            Size(maxSize.width * 0.95, maxSize.height * 0.25);
        double sidePosOfActionsWidget =
            (maxSize.width - actionsWidgetSize.width) * 0.5;
        return ValueListenableBuilder(
          valueListenable: _isActionsWidgetVisibleNotifier,
          builder: (context, isActionsWidgetVisible, child) {
            return Stack(
              children: [
                _searchListView(maxSize, itemSize, isActionsWidgetVisible,
                    actionsWidgetSize.height, searchQuery),
                Visibility(
                  visible: isActionsWidgetVisible,
                  child: Positioned(
                    bottom: 0,
                    left: sidePosOfActionsWidget,
                    right: sidePosOfActionsWidget,
                    child: _actionsWidget(actionsWidgetSize),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Container _actionsWidget(Size actionWidgetSize) {
    return Container(
      width: actionWidgetSize.width,
      height: actionWidgetSize.height,
      color: k1Gray.withOpacity(0.3),
    );
  }

  _searchListView(Size maxSize, Size itemSize, bool isActionsWidgetVisible,
      double bootomSpace, ServiceProvidersSearchQuery searchQuery) {
    int length = searchQuery.length;
    final List<MapEntry<String, List<String>>> dataList =
        searchQuery.queryCriteriaMapAsList();
    return ListView.separated(
      itemCount: length + 1,
      separatorBuilder: (context, index) => SizedBox(
        height: maxSize.height * 0.05,
      ),
      itemBuilder: (context, index) {
        if (index == length && isActionsWidgetVisible) {
          return SizedBox(
            height: bootomSpace,
          );
        } else if (index < length) {
          MapEntry<String, List<String>> entry = dataList[index];
          return Container(
            width: itemSize.width,
            height: itemSize.height,
            alignment: AlignmentDirectional.centerStart,
            child: Text(entry.key),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
