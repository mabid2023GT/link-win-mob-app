import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/service_providers/service_providers_search_model.dart';
import 'package:link_win_mob_app/features/home/service_providers/widgets/service_provider_search_query_box.dart';
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
        Size queriesBoxSize = Size(maxSize.width, maxSize.height);
        Size querySize = Size(maxSize.width, maxSize.height * 0.15);

        return ValueListenableBuilder(
          valueListenable: _isActionsWidgetVisibleNotifier,
          builder: (context, isActionsWidgetVisible, child) {
            return SizedBox(
              width: queriesBoxSize.width,
              height: queriesBoxSize.height,
              child: ServiceProviderSearchQueryBox(
                queries: searchQuery.queryCriteriaMap,
                queryWidgetSize: querySize,
              ),
            );
          },
        );
      },
    );
  }
}
