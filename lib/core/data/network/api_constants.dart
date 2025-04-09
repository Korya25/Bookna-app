class ApiConstants {
  static const apiKey = 'AIzaSyAfIzk39Fr568ZYm_B4fR0TjLAhlxI4L8c';
  static const baseUrl = 'https://www.googleapis.com/books/v1';
  static const itemsPerPage = 10;

  static const String baseThumbnailUrl =
      'https://books.google.com/books/publisher/content';

  static const String placeholder =
      'https://davidkoepp.com/wp-content/themes/blankslate/images/Movie%20Placeholder.jpg';
  static const String authorPlaceholder =
      'https://palmbayprep.org/wp-content/uploads/2015/09/user-icon-placeholder.png';
  static const String collectionPlaceholder =
      'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png';

  // Books Path
  static const String getNewestBooksPath =
      '$baseUrl/volumes?q=subject:fiction&orderBy=newest&startIndex=0&maxResults=$itemsPerPage&key=$apiKey';

  static String getPopularBooksPath([int page = 1]) {
    final startIndex = (page - 1) * itemsPerPage;
    return '$baseUrl/volumes?q=subject:fiction+intitle:bestseller&orderBy=relevance&startIndex=$startIndex&maxResults=$itemsPerPage&key=$apiKey';
  }

  static String getTopRatedBooksPath([int page = 1]) {
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

  // Author Path

  static String getAuthorWithNamePath(String name) {
    return 'https://openlibrary.org/search/authors.json?q=$name';
  }
}
