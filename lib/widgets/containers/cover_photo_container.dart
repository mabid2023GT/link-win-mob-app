import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';

class CoverPhotoContainer extends StatelessWidget {
  final String coverPhotoPath;
  final Widget child;
  final Color backgroundColor;
  final Color? childBackgroundWrapper;
  final double borderRadiusRatio;
  final Border border;
  const CoverPhotoContainer({
    super.key,
    required this.coverPhotoPath,
    required this.child,
    this.childBackgroundWrapper,
    this.backgroundColor = kWhite,
    this.borderRadiusRatio = 0.075,
    this.border = const Border.fromBorderSide(
      BorderSide(width: 1, color: kBlack),
    ),
  });

  @override
  Widget build(BuildContext context) {
    return LayoutChildBuilder(
      child: (minSize, maxSize) {
        return FutureBuilder(
          // Check if the image URL is valid
          future: _isValidImage(coverPhotoPath),
          builder: (context, snapshot) {
            bool isValidImage = snapshot.data == true;
            return Container(
              width: maxSize.width,
              height: maxSize.height,
              decoration: BoxDecoration(
                // White background if not a valid image
                color: isValidImage ? null : backgroundColor,
                borderRadius:
                    BorderRadius.circular(maxSize.width * borderRadiusRatio),
                border: border,
                image: isValidImage
                    ? DecorationImage(
                        image: NetworkImage(coverPhotoPath),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: childBackgroundWrapper == null
                  ? child
                  : Container(
                      decoration: BoxDecoration(
                        color: childBackgroundWrapper,
                        borderRadius: BorderRadius.circular(
                            maxSize.width * borderRadiusRatio),
                      ),
                      child: child),
            );
          },
        );
      },
    );
  }

  Future<bool> _isValidImage(String url) async {
    if (url.isEmpty) return false;
    try {
      final response = await NetworkAssetBundle(Uri.parse(url)).load(url);
      return response.lengthInBytes > 0;
    } catch (e) {
      return false;
    }
  }
}
