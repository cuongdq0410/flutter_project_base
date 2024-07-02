import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCacheImageNetwork extends StatelessWidget {
  const CustomCacheImageNetwork({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.boxFit,
    this.radius,
  }) : super(key: key);

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final double? radius;

  String? get baseUrl {
    if (imageUrl == '') return null;
    try {
      final uri = Uri.tryParse(imageUrl);
      if (uri == null) return null;
      return uri.origin + uri.path;
      //ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: CachedNetworkImage(
        cacheKey: baseUrl,
        imageUrl: imageUrl,
        height: height ?? double.infinity,
        width: width ?? double.infinity,
        fit: boxFit ?? BoxFit.fill,
        placeholder: (_, __) => Container(
          color: Colors.black12,
          height: height ?? double.infinity,
          width: width ?? double.infinity,
          child: const Center(
            child: Icon(
              Icons.image_rounded,
              size: 80,
              color: Colors.black26,
            ),
          ),
        ),
        errorWidget: (
          BuildContext context,
          String url,
          dynamic error,
        ) =>
            Container(
          decoration: const BoxDecoration(color: Colors.black12),
          height: double.infinity,
          width: double.infinity,
          child: const Center(
            child: Icon(Icons.error, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
