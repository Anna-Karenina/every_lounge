import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

const String imageBaseUrl = "https://image.tmdb.org/t/p/w500/";

class AppCacheImage extends StatelessWidget {
  final String path;
  const AppCacheImage({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: path != "",
      replacement: const Icon(Icons.error),
      child: CachedNetworkImage(
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(value: downloadProgress.progress)),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        errorListener: _onError,
        imageUrl: '$imageBaseUrl/$path',
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  void _onError(Object value) {
    print(value);
  }
}
