import 'package:intl/intl.dart';

String formatDate(String rawDate) {
  final dateTime = DateTime.parse(rawDate);

  final formatted = DateFormat("MMMM d, y h:mma").format(dateTime);

  // Add suffix (st, nd, rd, th)
  String day = DateFormat('d').format(dateTime);
  String suffix = getDaySuffix(int.parse(day));

  return formatted.replaceFirstMapped(RegExp(r'(\d+),'), (match) {
    return '${match[1]}$suffix,';
  }).toLowerCase(); // to match "12:50am" style
}

String getDaySuffix(int day) {
  if (day >= 11 && day <= 13) return "th";
  switch (day % 10) {
    case 1:
      return "st";
    case 2:
      return "nd";
    case 3:
      return "rd";
    default:
      return "th";
  }
}

String formatDateTime(String dateTimeString) {
  try {
    final dateTime = DateTime.parse(dateTimeString);
    final formattedDate = DateFormat('MMM d, yyyy h:mma').format(dateTime);
    return formattedDate.toLowerCase().replaceAll('m', 'm');
  } catch (e) {
    return dateTimeString; // fallback if parsing fails
  }
}

/// Format Apr 9th, 2025 23:30:40
String formatDateAndTime(String input) {
  try {
    final dateTime = DateTime.parse(input);

    // Get month abbreviation
    final month = DateFormat('MMM').format(dateTime); // e.g. Apr
    final day = dateTime.day;

    // Add ordinal suffix (st, nd, rd, th)
    String suffix;
    if (day >= 11 && day <= 13) {
      suffix = 'th';
    } else {
      switch (day % 10) {
        case 1:
          suffix = 'st';
          break;
        case 2:
          suffix = 'nd';
          break;
        case 3:
          suffix = 'rd';
          break;
        default:
          suffix = 'th';
      }
    }

    // Format time (12-hour with AM/PM)
    final time = DateFormat('hh:mm:ss').format(dateTime);

    return '$month $day$suffix, ${dateTime.year} $time';
  } catch (e) {
    return input; // fallback if parsing fails
  }
}
