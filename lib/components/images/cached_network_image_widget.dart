import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

final cacheManager = DefaultCacheManager();

class OptimizedCacheManager {
  static final OptimizedCacheManager _instance =
      OptimizedCacheManager._internal();

  factory OptimizedCacheManager() => _instance;

  OptimizedCacheManager._internal();

  // Configurable cache manager with custom settings
  CacheManager getCacheManager({
    int maxCacheObjects = 1000,
    int maxAgeCacheObject = 7,
  }) {
    return CacheManager(
      Config(
        'optimized_image_cache',
        maxNrOfCacheObjects: maxCacheObjects,
        stalePeriod: Duration(days: maxAgeCacheObject),
        // Optional: add file system storage strategy
        fileService: HttpFileService(),
      ),
    );
  }
}

class CachedNetworkImageWidget extends StatelessWidget {
  final double? width;
  final double height;
  final String imageUrl;
  final BoxFit boxFit;
  final String? errorAssetImage;
  const CachedNetworkImageWidget({
    super.key,
    this.width,
    this.boxFit = BoxFit.cover,
    this.errorAssetImage,
    required this.height,
    required this.imageUrl,
  });
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      cacheManager: OptimizedCacheManager().getCacheManager(),
      width: width ?? double.maxFinite,
      imageUrl: imageUrl,
      fit: boxFit,
      placeholder: (context, url) {
        return Image.asset(
          errorAssetImage ?? 'assets/images/default.jpg',
          fit: BoxFit.cover,
          height: height,
          width: width ?? double.maxFinite,
        );
      },
      errorWidget: (context, url, error) {
        log('[CACHE-NETWORK-IMAGE-ERROR] :: $url');

        return Image.asset(
          errorAssetImage ?? 'assets/images/default.jpg',
          height: height,
          width: width ?? double.maxFinite,
          fit: BoxFit.cover,
        );
      },
    );
  }
}
