import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'access_info.dart';
import 'sale_info.dart';
import 'search_info.dart';
import 'volume_info.dart';

class BookModel extends Book {
  String? kind;
  String? id;
  String? etag;
  String? selfLink;
  VolumeInfo? volumeInfo;
  SaleInfo? saleInfo;
  AccessInfo? accessInfo;
  SearchInfo? searchInfo;

  BookModel({
    this.kind,
    this.id,
    this.etag,
    this.selfLink,
    this.volumeInfo,
    this.saleInfo,
    this.accessInfo,
    this.searchInfo,
  }) : super(
         bookId: id ?? 'No ID',
         title: volumeInfo?.title ?? 'No Title',
         authors: volumeInfo?.authors ?? ['Unknown Author'],
         publishedDate: volumeInfo?.publishedDate ?? 'No Date',
         description: volumeInfo?.description ?? 'No Description',
         pageCount: volumeInfo?.pageCount ?? 0,
         price: saleInfo?.retailPrice?.amount ?? 0,
         averageRating: volumeInfo?.averageRating ?? 0,
         ratingsCount: volumeInfo?.ratingsCount ?? 0,
         thumbnail:
             volumeInfo?.imageLinks?.thumbnail ??
             'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQ1bPYruAQo94dq6zxMcfN2q3maqaQYT0qMoE9Umc_k5AFT1VnY2h26OAP6WB5AXphc2dJ-OSFR4C9LcetqWSEGEw',
         categories: volumeInfo?.categories ?? ['Uncategorized'],
         previewLink: volumeInfo?.previewLink,
       );

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
    kind: json['kind'] as String?,
    id: json['id'] as String?,
    etag: json['etag'] as String?,
    selfLink: json['selfLink'] as String?,
    volumeInfo:
        json['volumeInfo'] == null
            ? null
            : VolumeInfo.fromJson(json['volumeInfo'] as Map<String, dynamic>),
    saleInfo:
        json['saleInfo'] == null
            ? null
            : SaleInfo.fromJson(json['saleInfo'] as Map<String, dynamic>),
    accessInfo:
        json['accessInfo'] == null
            ? null
            : AccessInfo.fromJson(json['accessInfo'] as Map<String, dynamic>),
    searchInfo:
        json['searchInfo'] == null
            ? null
            : SearchInfo.fromJson(json['searchInfo'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'kind': kind,
    'id': id,
    'etag': etag,
    'selfLink': selfLink,
    'volumeInfo': volumeInfo?.toJson(),
    'saleInfo': saleInfo?.toJson(),
    'accessInfo': accessInfo?.toJson(),
    'searchInfo': searchInfo?.toJson(),
  };
}
