import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/service_providers/service_providers_model.dart';
import 'package:link_win_mob_app/providers/service_providers/top_rated_service_providers_notifier.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/containers/cover_photo_container.dart';

class TopRatedServiceProvidersByCategory extends ConsumerWidget {
  const TopRatedServiceProvidersByCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, List<ServiceProvidersModel>> topRatedProviders =
        ref.watch(topRatedServiceProvidersProvider);
    return LayoutChildBuilder(
      child: (minSize, maxSize) {
        Size titleSize = Size(maxSize.width * 0.9, maxSize.height * 0.08);
        Size categoryBoxSize = Size(maxSize.width, maxSize.height * 0.1);
        Size providerBoxSize = Size(maxSize.width * 0.9, maxSize.height * 0.3);
        return SingleChildScrollView(
          child: Column(
            children: [
              _title(titleSize),
              ...topRatedProviders.entries.map(
                (entry) {
                  String category = entry.key;
                  List<ServiceProvidersModel> providers = entry.value;
                  return Column(
                    children: [
                      _categoryBox(categoryBoxSize, category),
                      SizedBox(
                        height: categoryBoxSize.height * 0.5,
                      ),
                      ...providers.map(
                        (provider) {
                          return Column(
                            children: [
                              _providerBox(providerBoxSize, provider),
                              SizedBox(
                                height: providerBoxSize.height * 0.1,
                              ),
                            ],
                          );
                        },
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _title(Size titleSize) {
    return Container(
      width: titleSize.width,
      height: titleSize.height,
      alignment: AlignmentDirectional.center,
      child: Text(
        'Top Rated Providers',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Lato',
        ),
      ),
    );
  }

  _categoryBox(Size size, String category) {
    return Container(
      width: size.width,
      height: size.height,
      alignment: AlignmentDirectional.centerStart,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width * 0.05,
            ),
            Icon(
              FontAwesomeIcons.layerGroup,
              size: size.height * 0.65,
            ),
            SizedBox(
              width: size.width * 0.05,
            ),
            Text(
              category,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Lato',
              ),
            ),
          ],
        ),
      ),
    );
  }

  _providerBox(Size size, ServiceProvidersModel provider) {
    Size boxSize = Size(size.width * 0.85, size.height);
    Size providerDetailsSize = Size(boxSize.width * 0.9, boxSize.height * 0.3);
    Size ratingSize = Size(providerDetailsSize.width, boxSize.height * 0.3);
    Size actionsSize = Size(providerDetailsSize.width, boxSize.height * 0.3);
    return Container(
      width: size.width,
      height: size.height,
      alignment: AlignmentDirectional.centerEnd,
      child: SizedBox(
        width: boxSize.width,
        height: boxSize.height,
        child: CoverPhotoContainer(
          coverPhotoPath: provider.coverPhotoPath,
          childBackgroundWrapper: kBlack.withOpacity(0.35),
          border: Border.all(width: 2, color: kBlack),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: providerDetailsSize.width,
                height: providerDetailsSize.height,
                child: _providerDetailsBox(provider.displayName),
              ),
              SizedBox(
                width: ratingSize.width,
                height: ratingSize.height,
                child: _providerRatingBox(provider.rating.toInt()),
              ),
              SizedBox(
                width: actionsSize.width,
                height: actionsSize.height,
                child: _providerActionsBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _providerDetailsBox(String providerName) {
    return LayoutChildBuilder(
      child: (minSize, maxSize) {
        return Container(
          width: maxSize.width,
          height: maxSize.height,
          alignment: AlignmentDirectional.center,
          child: Text(
            providerName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Lato',
              color: kWhite,
            ),
          ),
        );
      },
    );
  }

  _providerRatingBox(int rating) {
    if (rating < 0) {
      rating = 0;
    } else if (rating > 5) {
      rating = 5;
    }
    return LayoutChildBuilder(
      child: (minSize, maxSize) {
        return SizedBox(
          width: maxSize.width,
          height: maxSize.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: maxSize.width * 0.65,
                height: maxSize.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: index < rating ? kAmber : k1Gray,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _providerActionsBox() {
    return LayoutChildBuilder(
      child: (minSize, maxSize) {
        Size childSize = Size(maxSize.width * 0.6, maxSize.height);
        return Material(
          color: transparent,
          child: SizedBox(
            width: maxSize.width,
            height: maxSize.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  splashColor: kSelectedTabColor,
                  child: Container(
                    width: childSize.width,
                    height: childSize.height,
                    decoration: BoxDecoration(
                      color: kHeaderColor,
                      border: Border.all(width: 2, color: kBlack),
                      borderRadius:
                          BorderRadius.circular(childSize.width * 0.1),
                    ),
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      'Ask For Offer',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Lato',
                        color: kWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
