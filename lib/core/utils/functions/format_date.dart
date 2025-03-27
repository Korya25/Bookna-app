import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(String? inputDate, {String fallback = ''}) {
  if (inputDate == null || inputDate.isEmpty || inputDate.trim().isEmpty) {
    return fallback;
  }

  const supportedFormats = [
    'yyyy-MM-dd', // ISO 8601 (الأكثر شيوعاً في APIs)
    'MMM d, yyyy', // مثل "Feb 15, 2019"
    'MM/dd/yyyy', // تنسيق أمريكي
    'dd/MM/yyyy', // تنسيق أوروبي
    'yyyyMMdd', // تنسيق مضغوط
    'EEE, dd MMM yyyy', // مثل "Fri, 15 Feb 2019"
    'yyyy-MM-ddTHH:mm:ssZ', // تنسيق ISO مع الوقت
  ];

  DateTime? parsedDate;

  for (final format in supportedFormats) {
    parsedDate = _tryParseStrict(inputDate, format);
    if (parsedDate != null) break;
  }

  parsedDate ??= _tryParseTimestamp(inputDate);

  parsedDate ??= _tryParseLoose(inputDate);

  if (parsedDate == null) {
    debugPrint('Failed to parse date: "$inputDate"');
    return fallback;
  }

  if (!_isDateReasonable(parsedDate)) {
    debugPrint('Unreasonable date parsed: $parsedDate from "$inputDate"');
    return fallback;
  }

  return DateFormat('MMM d, yyyy').format(parsedDate);
}

bool _isDateReasonable(DateTime date) {
  final now = DateTime.now();
  final earliestReasonable = DateTime(1900);
  final latestReasonable = now.add(const Duration(days: 365 * 10)); // +10 سنوات

  return date.isAfter(earliestReasonable) && date.isBefore(latestReasonable);
}

DateTime? _tryParseStrict(String input, String format) {
  try {
    final date = DateFormat(format).parseStrict(input);
    return _isDateReasonable(date) ? date : null;
  } catch (_) {
    return null;
  }
}

DateTime? _tryParseLoose(String input) {
  try {
    final date = DateTime.tryParse(input);
    return date != null && _isDateReasonable(date) ? date : null;
  } catch (_) {
    return null;
  }
}

DateTime? _tryParseTimestamp(String input) {
  final timestamp = int.tryParse(input);
  if (timestamp == null) return null;

  final maxSecondsTimestamp = 2000000000;
  final maxMillisecondsTimestamp = 2000000000000;

  if (timestamp > 0) {
    if (timestamp < maxSecondsTimestamp) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    } else if (timestamp < maxMillisecondsTimestamp) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
  }
  return null;
}
