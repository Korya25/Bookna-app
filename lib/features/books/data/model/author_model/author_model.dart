import 'package:bookna_app/features/books/domain/entities/author.dart';

class AuthorModel extends Author {
  AuthorModel({
    required String id,
    required String name,
    required List<String>? alternateNames,
    required String? birthDate,
    required String? deathDate,
    required List<String> topSubjects,
    required String topWork,
    required String type,
    required int workCount,
    required double ratingsAverage,
    required double ratingsSortable,
    required int ratingsCount,
    required Map<int, int> ratingsDistribution,
    required int wantToReadCount,
    required int alreadyReadCount,
    required int currentlyReadingCount,
    required int readingLogCount,
    required String version,
  }) : super(
         key: id,
         name: name,
         alternateNames: alternateNames,
         birthDate: birthDate,
         deathDate: deathDate,
         topSubjects: topSubjects,
         topWork: topWork,
         type: type,
         workCount: workCount,
         ratingsAverage: ratingsAverage,
         ratingsSortable: ratingsSortable,
         ratingsCount: ratingsCount,
         ratingsCount1: ratingsDistribution[1],
         ratingsCount2: ratingsDistribution[2],
         ratingsCount3: ratingsDistribution[3],
         ratingsCount4: ratingsDistribution[4],
         ratingsCount5: ratingsDistribution[5],
         wantToReadCount: wantToReadCount,
         alreadyReadCount: alreadyReadCount,
         currentlyReadingCount: currentlyReadingCount,
         readingLogCount: readingLogCount,
         version: version,
       );

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['key'] as String,
      name: json['name'] as String,
      alternateNames:
          json['alternate_names'] != null
              ? List<String>.from(json['alternate_names'])
              : null,
      birthDate: json['birth_date'] as String?,
      deathDate: json['death_date'] as String?,
      topSubjects:
          json['top_subjects'] != null
              ? List<String>.from(json['top_subjects'])
              : [],
      topWork: json['top_work'] as String? ?? 'Unknown',
      type: json['type'] as String,
      workCount: json['work_count'] as int,
      ratingsAverage: (json['ratings_average'] as num?)?.toDouble() ?? 0.0,
      ratingsSortable: (json['ratings_sortable'] as num?)?.toDouble() ?? 0.0,
      ratingsCount: json['ratings_count'] as int? ?? 0,
      ratingsDistribution: {
        1: json['ratings_count_1'] as int? ?? 0,
        2: json['ratings_count_2'] as int? ?? 0,
        3: json['ratings_count_3'] as int? ?? 0,
        4: json['ratings_count_4'] as int? ?? 0,
        5: json['ratings_count_5'] as int? ?? 0,
      },
      wantToReadCount: json['want_to_read_count'] as int? ?? 0,
      alreadyReadCount: json['already_read_count'] as int? ?? 0,
      currentlyReadingCount: json['currently_reading_count'] as int? ?? 0,
      readingLogCount: json['readinglog_count'] as int? ?? 0,
      version: json['_version_'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'name': name,
      'alternate_names': alternateNames,
      'birth_date': birthDate,
      'death_date': deathDate,
      'top_subjects': topSubjects,
      'top_work': topWork,
      'type': type,
      'work_count': workCount,
      'ratings_average': ratingsAverage,
      'ratings_sortable': ratingsSortable,
      'ratings_count': ratingsCount,
      'ratings_count_1': ratingsCount1,
      'ratings_count_2': ratingsCount2,
      'ratings_count_3': ratingsCount3,
      'ratings_count_4': ratingsCount4,
      'ratings_count_5': ratingsCount5,
      'want_to_read_count': wantToReadCount,
      'already_read_count': alreadyReadCount,
      'currently_reading_count': currentlyReadingCount,
      'readinglog_count': readingLogCount,
      '_version_': version,
    };
  }
}
