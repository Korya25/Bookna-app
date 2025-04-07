/// Represents an author entity with relevant details.
class Author {
  final String? key;
  final String? name;
  final List<String>? alternateNames;
  final String? birthDate;
  final String? deathDate;
  final List<String>? topSubjects;
  final String? topWork;
  final String? type;
  final int? workCount;
  final double? ratingsAverage;
  final double? ratingsSortable;
  final int? ratingsCount;
  final int? ratingsCount1;
  final int? ratingsCount2;
  final int? ratingsCount3;
  final int? ratingsCount4;
  final int? ratingsCount5;
  final int? wantToReadCount;
  final int? alreadyReadCount;
  final int? currentlyReadingCount;
  final int? readingLogCount;
  final String? version;

  Author({
    required this.key,
    required this.name,
    required this.alternateNames,
    required this.birthDate,
    required this.deathDate,
    required this.topSubjects,
    required this.topWork,
    required this.type,
    required this.workCount,
    required this.ratingsAverage,
    required this.ratingsSortable,
    required this.ratingsCount,
    required this.ratingsCount1,
    required this.ratingsCount2,
    required this.ratingsCount3,
    required this.ratingsCount4,
    required this.ratingsCount5,
    required this.wantToReadCount,
    required this.alreadyReadCount,
    required this.currentlyReadingCount,
    required this.readingLogCount,
    required this.version,
  });
}
