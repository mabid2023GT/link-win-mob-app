import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        Size queriesBoxSize = Size(maxSize.width, maxSize.height);
        return ValueListenableBuilder(
          valueListenable: _isActionsWidgetVisibleNotifier,
          builder: (context, isActionsWidgetVisible, child) {
            return ServiceProviderSearchQueryBox(
              queries: searchQuery.queryCriteriaMap,
              size: queriesBoxSize,
            );
          },
        );
      },
    );
  }
}
