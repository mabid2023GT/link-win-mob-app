import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/utils/enums/full_screen_media_type.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenMedia extends StatelessWidget {
  final FullScreenMediaType fullScreenMediaType;
  final List<String> urls;
  const FullScreenMedia({
    super.key,
    required this.fullScreenMediaType,
    required this.urls,
  });

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: NetworkImage(
        urls[0],
      ),
    );
  }
}
