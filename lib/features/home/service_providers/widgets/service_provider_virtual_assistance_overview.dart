import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/service_providers/service_providers_model.dart';
import 'package:link_win_mob_app/core/models/service_providers/service_providers_virtual_assistance_query.dart';
import 'package:link_win_mob_app/features/home/service_providers/widgets/top_rated_service_providers_by_category.dart';
import 'package:link_win_mob_app/providers/service_providers/service_providers_virtual_assistance_results.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/link_win_icon.dart';

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
        Size querySize = Size(size.width, size.height * 0.3);
        Size resultsSize = Size(querySize.width, size.height * 0.4);
        Size titleSize = Size(size.width, size.height * 0.125);
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
                  SizedBox(
                    width: titleSize.width,
                    height: titleSize.height,
                    child: _title(),
                  ),
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
          child: _queryBodyWidget(resultsSize, query.queryResult),
        ),
        SizedBox(height: querySize.height * 0.15),
      ],
    );
  }

  _queryHeaderWidget(
      Size querySize, ServiceProvidersVirtualAssistanceQuery query) {
    Size rowSize = Size(querySize.width * 0.4, querySize.height * 0.2);
    Size stopButtonSize = Size(querySize.width * 0.12, querySize.width * 0.12);

    return Stack(
      children: [
        Container(
          width: querySize.width,
          height: querySize.height,
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(querySize.width * 0.05),
            border: Border.all(width: 1, color: kBlack),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
        ),
        Visibility(
          visible: query.isQueryActive,
          child: Positioned(
            top: 0,
            right: 0,
            child: SizedBox(
              width: stopButtonSize.width,
              height: stopButtonSize.height,
              child: LinkWinIcon(
                iconSize: stopButtonSize,
                splashColor: kHeaderColor,
                iconColor: kRed,
                iconData: FontAwesomeIcons.circleStop,
                iconSizeRatio: 0.7,
                onTap: () async {
                  // Call stopQuery from the provider and pass the queryId
                  await ref
                      .read(serviceProvidersVirtualAssistanceResultsProvider
                          .notifier)
                      .stopQuery(query.queryId);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<List<List<dynamic>>> _queryCardDetails(
      ServiceProvidersVirtualAssistanceQuery query) {
    return [
      [
        [
          query.category,
          Icons.category,
          Colors.purple,
        ],
      ],
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
          query.showRatingsAndReviews ? 'With Rating' : 'Unrated',
          Icons.star,
          kAmber,
        ],
      ],
      [
        [
          '${query.queryResult.length} Results',
          query.queryResult.isNotEmpty
              ? FontAwesomeIcons.circleCheck
              : FontAwesomeIcons.circleXmark,
          query.queryResult.isNotEmpty ? kSelectedTabColor : kRed,
        ],
        [
          query.isQueryActive ? 'Active' : 'Finished',
          query.isQueryActive
              ? FontAwesomeIcons.circlePlay
              : FontAwesomeIcons.circleCheck,
          query.isQueryActive ? Colors.green : Colors.orange,
        ],
      ]
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

  _title() {
    return LayoutChildBuilder(
      child: (minSize, maxSize) {
        Size size = Size(maxSize.width, maxSize.height * 0.75);
        return SizedBox(
          width: maxSize.width,
          height: maxSize.height,
          child: Column(
            children: [
              Container(
                width: size.width,
                height: size.height,
                alignment: AlignmentDirectional.center,
                child: Text(
                  'Virtual Assistance',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
              SizedBox(
                height: maxSize.height - size.height,
              ),
            ],
          ),
        );
      },
    );
  }

  _queryBodyWidget(
    Size resultsSize,
    List<ServiceProvidersModel> queryResult,
  ) {
    Size boxSize = Size(resultsSize.width * 0.8, resultsSize.height * 0.9);
    return SizedBox(
      width: resultsSize.width,
      height: resultsSize.height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: queryResult.length,
        separatorBuilder: (context, index) => SizedBox(
          width: boxSize.width * 0.1,
        ),
        itemBuilder: (context, index) =>
            _serviceProviderBox(index, queryResult[index], boxSize),
      ),
    );
  }

  _serviceProviderBox(int index, ServiceProvidersModel provider, Size boxSize) {
    BorderRadius borderRadius = BorderRadius.circular(boxSize.width * 0.2);
    double topBottomPad = boxSize.height * 0.1;
    double sidePad = boxSize.width * 0.1;
    return SizedBox(
      width: boxSize.width,
      height: boxSize.height,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        child: Stack(
          children: [
            _providerCardCoverImage(borderRadius, provider, boxSize),
            _providerCardBlur(boxSize, borderRadius),
            _providerCardContent(topBottomPad, sidePad, provider),
          ],
        ),
      ),
    );
  }

  Positioned _providerCardContent(
      double topBottomPad, double sidePad, ServiceProvidersModel provider) {
    return Positioned(
      top: topBottomPad,
      bottom: topBottomPad,
      left: sidePad,
      right: sidePad,
      child: LayoutChildBuilder(
        child: (minSize, maxSize) {
          Size buttonIconSize = Size(maxSize.width * 0.2, maxSize.height * 0.3);

          return SizedBox(
            width: maxSize.width,
            height: maxSize.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _providerCardTextBox('Name: ${provider.displayName}'),
                _providerCardTextBox('Rating: ${provider.rating}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    LinkWinIcon(
                      iconSize: buttonIconSize,
                      splashColor: kHeaderColor,
                      iconColor: kSelectedTabColor,
                      iconData: FontAwesomeIcons.paperPlane,
                      iconSizeRatio: 0.55,
                      onTap: () {},
                    ),
                    Text(
                      'Message',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Lato',
                        color: kBlack,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Positioned _providerCardBlur(Size boxSize, BorderRadius borderRadius) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        width: boxSize.width,
        height: boxSize.height,
        decoration: BoxDecoration(
          color: kWhite.withOpacity(0.55), // Semi-transparent overlay
          borderRadius: borderRadius,
        ),
      ),
    );
  }

  Positioned _providerCardCoverImage(
      BorderRadius borderRadius, ServiceProvidersModel provider, Size boxSize) {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Image.network(
          provider.coverPhotoPath,
          fit: BoxFit.cover,
          height: boxSize.height,
          width: double.infinity,
          // Use the errorBuilder to handle cases where the image cannot be loaded
          errorBuilder: (context, error, stackTrace) => Container(
            color: kWhite,
            height: boxSize.height,
            width: boxSize.width,
          ),
        ),
      ),
    );
  }

  _providerCardTextBox(String value) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        fontFamily: 'Lato',
        color: kBlack,
      ),
    );
  }
}
