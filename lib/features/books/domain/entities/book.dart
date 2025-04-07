class Book {
  final String? bookId;
  final String? title;
  final List<String>? authors;
  final String? publishedDate;
  final String? description;
  final num? pageCount;
  final num? price;
  final num? averageRating;
  final num? ratingsCount;
  final String thumbnail;
  final List<String>? categories;
  final String? previewLink;

  Book({
    required this.bookId,
    required this.title,
    required this.authors,
    required this.publishedDate,
    required this.description,
    required this.pageCount,
    required this.price,
    required this.averageRating,
    required this.ratingsCount,
    required this.thumbnail,
    required this.categories,
    required this.previewLink,
  });
}
