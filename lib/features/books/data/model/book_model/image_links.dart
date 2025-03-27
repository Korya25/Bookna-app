import 'package:bookna_app/core/data/network/api_constants.dart';

class ImageLinks {
  final String? smallThumbnail;
  final String? thumbnail;
  final String? mediumQuality;
  final String? highQuality;

  ImageLinks({
    this.smallThumbnail,
    this.thumbnail,
    this.mediumQuality,
    this.highQuality,
  });

  factory ImageLinks.fromJson(Map<String, dynamic> json) {
    final rawThumbnail = json['thumbnail'] as String?;
    final rawSmallThumbnail = json['smallThumbnail'] as String?;

    return ImageLinks(
      smallThumbnail: _processImageUrl(
        rawSmallThumbnail,
        quality: ImageQuality.small,
      ),
      thumbnail: _processImageUrl(rawThumbnail, quality: ImageQuality.medium),
      mediumQuality: _processImageUrl(
        rawThumbnail,
        quality: ImageQuality.medium,
      ),
      highQuality: _processImageUrl(rawThumbnail, quality: ImageQuality.large),
    );
  }

  Map<String, dynamic> toJson() => {
    'smallThumbnail': smallThumbnail,
    'thumbnail': thumbnail,
    'mediumQuality': mediumQuality,
    'highQuality': highQuality,
  };

  static String? _processImageUrl(
    String? url, {
    required ImageQuality quality,
  }) {
    if (url == null) return null;

    // If URL is already complete, just optimize it
    if (url.startsWith('http')) {
      return _optimizeImageUrl(url, quality: quality);
    }

    // Build URL from base path
    return '${ApiConstants.baseThumbnailUrl}/${url.replaceAll('/', '')}'
        '?printsec=frontcover'
        '&img=1'
        '&zoom=${_getZoomLevel(quality)}'
        '&w=${_getWidth(quality)}';
  }

  static String _optimizeImageUrl(String url, {required ImageQuality quality}) {
    return url
        .replaceAll('http://', 'https://')
        .replaceAll('&edge=curl', '')
        .replaceFirst('?', '?printsec=frontcover&')
        .replaceAll('zoom=1', 'zoom=${_getZoomLevel(quality)}')
        .replaceAll('w=500', 'w=${_getWidth(quality)}');
  }

  static int _getZoomLevel(ImageQuality quality) {
    switch (quality) {
      case ImageQuality.small:
        return 1;
      case ImageQuality.medium:
        return 2;
      case ImageQuality.large:
        return 3;
    }
  }

  static int _getWidth(ImageQuality quality) {
    switch (quality) {
      case ImageQuality.small:
        return 200;
      case ImageQuality.medium:
        return 500;
      case ImageQuality.large:
        return 1280;
    }
  }
}

enum ImageQuality { small, medium, large }
