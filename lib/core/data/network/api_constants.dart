import 'package:bookna_app/features/books/data/model/book_model/image_links.dart';

class ApiConstants {
  static const apiKey = 'AIzaSyCPTXVvcxDWR4et-IQ1lOwe-HMKMyARJiw';
  static const baseUrl = 'https://www.googleapis.com/books/v1';
  static const itemsPerPage = 10;

  static const String baseThumbnailUrl =
      'https://books.google.com/books/publisher/content';

  static const String placeholder =
      'https://books.google.com/googlebooks/images/no_cover_thumb.gif';
  static const String authorPlaceholder =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
  static const String collectionPlaceholder =
      'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png';

  static String getPlaceholder({
    required bool isAuthor,
    required ImageQuality quality,
  }) {
    if (isAuthor) return authorPlaceholder;

    return quality == ImageQuality.small
        ? placeholder
        : 'https://via.placeholder.com/${_getPlaceholderSize(quality)}?text=No+Cover';
  }

  static String _getPlaceholderSize(ImageQuality quality) {
    switch (quality) {
      case ImageQuality.small:
        return '200x300';
      case ImageQuality.medium:
        return '500x750';
      case ImageQuality.large:
        return '1280x1920';
    }
  }

  // Books Path
  static const String getNewestBooksPath =
      '$baseUrl/volumes?q=subject:fiction&orderBy=newest&startIndex=0&maxResults=$itemsPerPage&key=$apiKey';

  static String getPopularBooksPath(int page) {
    final startIndex = (page - 1) * itemsPerPage;

    return '$baseUrl/volumes?q=subject:fiction+intitle:bestseller&orderBy=relevance&startIndex=$startIndex&maxResults=$itemsPerPage&key=$apiKey';
  }

  static String getTopRatedBooksPath(int page) {
    final startIndex = (page - 1) * itemsPerPage;
    return '$baseUrl/volumes?q=subject:fiction+intitle:award&orderBy=relevance&startIndex=$startIndex&maxResults=$itemsPerPage&key=$apiKey';
  }

  static String getBooksByCategoryPath(String category, {int page = 1}) {
    final startIndex = (page - 1) * itemsPerPage;
    return '$baseUrl/volumes?q=subject:$category&startIndex=$startIndex&maxResults=$itemsPerPage&key=$apiKey';
  }

  static String getBookDetailsPath(String bookId) {
    return '$baseUrl/volumes/$bookId?key=$apiKey';
  }
}
