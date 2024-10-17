import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/features/home/service_providers/widgets/top_rated_service_providers_by_category.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class ServiceProviderVirtualAssistanceOverview extends ConsumerStatefulWidget {
  const ServiceProviderVirtualAssistanceOverview({super.key});

  @override
  ConsumerState<ServiceProviderVirtualAssistanceOverview> createState() =>
      _ServiceProviderVirtualAssistanceOverviewState();
}

class _ServiceProviderVirtualAssistanceOverviewState
    extends ConsumerState<ServiceProviderVirtualAssistanceOverview> {
  @override
  Widget build(BuildContext context) {
    // return LayoutChildBuilder(
    //   child: (minSize, maxSize) {
    //     Size titleSize = Size(maxSize.width * 0.9, maxSize.height * 0.1);

    //     return SizedBox(
    //       width: titleSize.width,
    //       height: titleSize.height,
    //       child: Text('Virtual Assistance'),
    //     );
    //   },
    // );
    return TopRatedServiceProvidersByCategory();
  }
}
