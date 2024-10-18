import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/service_providers/service_providers_virtual_assistance_query.dart';
import 'package:link_win_mob_app/features/home/service_providers/widgets/top_rated_service_providers_by_category.dart';
import 'package:link_win_mob_app/providers/service_providers/service_providers_virtual_assistance_results.dart';
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
    Map<String, ServiceProvidersVirtualAssistanceQuery> queries =
        ref.watch(serviceProvidersVirtualAssistanceResultsProvider);
    if (queries.isEmpty) {
      return TopRatedServiceProvidersByCategory();
    }
    return _virtualAssistanceResultOverview(queries);
  }

  _virtualAssistanceResultOverview(
      Map<String, ServiceProvidersVirtualAssistanceQuery> queries) {
    return LayoutChildBuilder(
      child: (minSize, maxSize) {
        double sidePad = maxSize.width * 0.025;
        double topBottomPad = maxSize.height * 0.025;
        Size size = Size(
            maxSize.width - 2 * sidePad, maxSize.height - 2 * topBottomPad);
        Size querySize = Size(size.width, size.height * 0.2);
        Size resultsSize = Size(querySize.width, size.height * 0.5);
        return Padding(
          padding: EdgeInsets.only(
            left: sidePad,
            right: sidePad,
            top: topBottomPad,
            bottom: topBottomPad,
          ),
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...queries.entries.map(
                    (entry) => _queryWidget(querySize, resultsSize, entry),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _queryWidget(
    Size querySize,
    Size resultsSize,
    MapEntry<String, ServiceProvidersVirtualAssistanceQuery> entry,
  ) {
    // The key of the map entry
    // final queryId = entry.key;
    // The value of the map entry
    final query = entry.value;
    //
    final bool isResultsAvailable = query.queryResult.isNotEmpty;
    return Column(
      children: [
        _queryHeaderWidget(querySize, query),
        Visibility(
          visible: isResultsAvailable,
          child: SizedBox(height: querySize.height * 0.05),
        ),
        Visibility(
          visible: isResultsAvailable,
          child: _queryBodyWidget(resultsSize),
        ),
        SizedBox(height: querySize.height * 0.15),
      ],
    );
  }

  _queryHeaderWidget(
      Size querySize, ServiceProvidersVirtualAssistanceQuery query) {
    Size rowSize = Size(querySize.width * 0.4, querySize.height * 0.3);

    return Container(
      width: querySize.width,
      height: querySize.height,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(querySize.width * 0.05),
        border: Border.all(width: 1, color: kBlack),
      ),
      child: Column(
        children: [
          // Use a forEach loop to iterate through each row of data returned by _queryCardDetails
          ..._queryCardDetails(query).map(
            (rowData) {
              // Create a Row for each rowData
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _createQueryCardRow(
                  rowSize,
                  rowData,
                  rowData.length <= 1,
                ), // Directly add the widgets here
              );
            },
          ),
        ],
      ),
    );
  }

  List<List<List<dynamic>>> _queryCardDetails(
      ServiceProvidersVirtualAssistanceQuery query) {
    return [
      [
        [
          query.location,
          Icons.location_city,
          kAmber,
        ],
        [
          query.budget,
          Icons.money,
          Colors.green,
        ]
      ],
      [
        [
          query.isScheduled ? 'Scheduled' : 'Immediately',
          Icons.schedule_rounded,
          Colors.green,
        ],
        [
          query.showRatingsAndReviews ? 'With Rating' : 'Without Rating',
          Icons.star,
          kAmber,
        ],
      ],
      [
        [
          query.category,
          Icons.category,
          Colors.purple,
        ],
      ],
    ];
  }

  List<Widget> _createQueryCardRow(
    Size rowSize,
    List<List<dynamic>> rowData,
    bool isCategoryRow,
  ) {
    return rowData
        .map(
          (lst) => _queryDetailsTextBox(
            rowSize,
            lst[0] as String,
            lst[1] as IconData,
            lst[2] as Color,
            isCategoryRow,
          ),
        )
        .toList();
  }

  Widget _queryDetailsTextBox(
    Size rowSize,
    String value,
    IconData iconData,
    Color iconColor,
    bool isCategoryRow,
  ) {
    if (isCategoryRow) {
      rowSize = Size(rowSize.width * 2, rowSize.height);
    }

    return SizedBox(
      width: rowSize.width,
      height: rowSize.height,
      child: Row(
        mainAxisAlignment: isCategoryRow
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            iconData,
            color: iconColor,
            size: rowSize.height * 0.8,
          ),
          Visibility(
            visible: isCategoryRow,
            child: SizedBox(
              width: rowSize.width * 0.05,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Lato',
            ),
          ),
        ],
      ),
    );
  }

  _queryBodyWidget(Size resultsSize) {
    return Container(
      width: resultsSize.width,
      height: resultsSize.height,
      color: kAmber,
    );
  }
}
