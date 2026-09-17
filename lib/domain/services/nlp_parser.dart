import '../enums/enums.dart';

class NLPParseResult {
  final String cleanedMessage;
  final DateTime? scheduledDate;
  final int? scheduledHour;
  final int? scheduledMinute;
  final RepeatRule? repeatRule;
  final PriorityLevel? priority;
  final bool hasParsedScheduling;

  const NLPParseResult({
    required this.cleanedMessage,
    this.scheduledDate,
    this.scheduledHour,
    this.scheduledMinute,
    this.repeatRule,
    this.priority,
    this.hasParsedScheduling = false,
  });

  DateTime? get fullScheduledDateTime {
    if (scheduledDate == null) return null;
    final hour = scheduledHour ?? 9;
    final minute = scheduledMinute ?? 0;
    return DateTime(
      scheduledDate!.year,
      scheduledDate!.month,
      scheduledDate!.day,
      hour,
      minute,
    );
  }

  String get previewSummary {
    final parts = <String>[];
    if (scheduledDate != null) {
      final now = DateTime.now();
      if (scheduledDate!.year == now.year && scheduledDate!.month == now.month && scheduledDate!.day == now.day) {
        parts.add('Today');
      } else if (scheduledDate!.year == now.year && scheduledDate!.month == now.month && scheduledDate!.day == now.day + 1) {
        parts.add('Tomorrow');
      } else {
        parts.add('${scheduledDate!.month}/${scheduledDate!.day}');
      }
    }
    if (scheduledHour != null && scheduledMinute != null) {
      final period = scheduledHour! >= 12 ? 'PM' : 'AM';
      final h = scheduledHour! == 0 ? 12 : (scheduledHour! > 12 ? scheduledHour! - 12 : scheduledHour!);
      final m = scheduledMinute!.toString().padLeft(2, '0');
      parts.add('$h:$m $period');
    }
    if (repeatRule != null && repeatRule != RepeatRule.none) {
      parts.add(repeatRule!.name.toUpperCase());
    }
    if (priority != null && priority != PriorityLevel.normal) {
      parts.add('${priority!.name.toUpperCase()} PRIORITY');
    }
    return parts.join(' • ');
  }
}

class NLPParser {
  static NLPParseResult parse(String input) {
    if (input.trim().isEmpty) {
      return const NLPParseResult(cleanedMessage: '');
    }

    String working = input;
    DateTime? date;
    int? hour;
    int? minute;
    RepeatRule? repeatRule;
    PriorityLevel? priority;

    final now = DateTime.now();

    // 1. Priority parsing
    final priorityRegex = RegExp(r'\b(urgent|asap|important|p1|high priority)\b', caseSensitive: false);
    if (priorityRegex.hasMatch(working)) {
      priority = PriorityLevel.high;
      working = working.replaceAll(priorityRegex, ' ');
    }

    // 2. Relative time: "in 5 minutes", "in 30 mins", "in 2 hours", "in 1 hr"
    final relativeRegex = RegExp(r'\bin\s+(\d+)\s*(minutes|mins|min|hours|hrs|hr)\b', caseSensitive: false);
    final relativeMatch = relativeRegex.firstMatch(working);
    if (relativeMatch != null) {
      final amount = int.parse(relativeMatch.group(1)!);
      final unit = relativeMatch.group(2)!.toLowerCase();
      final target = unit.startsWith('h')
          ? now.add(Duration(hours: amount))
          : now.add(Duration(minutes: amount));
      date = DateTime(target.year, target.month, target.day);
      hour = target.hour;
      minute = target.minute;
      working = working.replaceAll(relativeRegex, ' ');
    }

    // 3. Recurrence parsing
    final dailyRegex = RegExp(r'\b(every\s*day|daily)\b', caseSensitive: false);
    final weeklyRegex = RegExp(r'\b(every\s*week|weekly)\b', caseSensitive: false);
    final monthlyRegex = RegExp(r'\b(every\s*month|monthly)\b', caseSensitive: false);
    final weekdaysRegex = RegExp(r'\b(every\s*weekday|weekdays)\b', caseSensitive: false);
    final weekendsRegex = RegExp(r'\b(every\s*weekend|weekends)\b', caseSensitive: false);

    if (dailyRegex.hasMatch(working)) {
      repeatRule = RepeatRule.daily;
      working = working.replaceAll(dailyRegex, ' ');
    } else if (weeklyRegex.hasMatch(working)) {
      repeatRule = RepeatRule.weekly;
      working = working.replaceAll(weeklyRegex, ' ');
    } else if (monthlyRegex.hasMatch(working)) {
      repeatRule = RepeatRule.monthly;
      working = working.replaceAll(monthlyRegex, ' ');
    } else if (weekdaysRegex.hasMatch(working)) {
      repeatRule = RepeatRule.weekdays;
      working = working.replaceAll(weekdaysRegex, ' ');
    } else if (weekendsRegex.hasMatch(working)) {
      repeatRule = RepeatRule.weekends;
      working = working.replaceAll(weekendsRegex, ' ');
    }

    // 4. Date parsing: "day after tomorrow", "tomorrow", "today", "tonight"
    final dayAfterTomorrowRegex = RegExp(r'\bday after tomorrow\b', caseSensitive: false);
    final tomorrowRegex = RegExp(r'\btomorrow\b', caseSensitive: false);
    final todayRegex = RegExp(r'\btoday\b', caseSensitive: false);
    final tonightRegex = RegExp(r'\btonight\b', caseSensitive: false);

    if (dayAfterTomorrowRegex.hasMatch(working)) {
      final target = now.add(const Duration(days: 2));
      date = DateTime(target.year, target.month, target.day);
      working = working.replaceAll(dayAfterTomorrowRegex, ' ');
    } else if (tomorrowRegex.hasMatch(working)) {
      final target = now.add(const Duration(days: 1));
      date = DateTime(target.year, target.month, target.day);
      working = working.replaceAll(tomorrowRegex, ' ');
    } else if (tonightRegex.hasMatch(working)) {
      date = DateTime(now.year, now.month, now.day);
      hour = 20; // 8:00 PM
      minute = 0;
      working = working.replaceAll(tonightRegex, ' ');
    } else if (todayRegex.hasMatch(working)) {
      date = DateTime(now.year, now.month, now.day);
      working = working.replaceAll(todayRegex, ' ');
    }

    // 5. Day of week: "Monday", "next Friday", etc.
    final dayOfWeekRegex = RegExp(r'\b(next\s+)?(monday|tuesday|wednesday|thursday|friday|saturday|sunday)\b', caseSensitive: false);
    final dowMatch = dayOfWeekRegex.firstMatch(working);
    if (dowMatch != null && date == null) {
      final isNext = dowMatch.group(1) != null;
      final dowName = dowMatch.group(2)!.toLowerCase();
      final targetDow = _parseDayOfWeek(dowName);
      var daysAhead = targetDow - now.weekday;
      if (daysAhead <= 0 || isNext) {
        daysAhead += 7;
      }
      final target = now.add(Duration(days: daysAhead));
      date = DateTime(target.year, target.month, target.day);
      working = working.replaceAll(dayOfWeekRegex, ' ');
    }

    // 6. Time of day: "morning", "afternoon", "evening", "night"
    final morningRegex = RegExp(r'\bmorning\b', caseSensitive: false);
    final afternoonRegex = RegExp(r'\bafternoon\b', caseSensitive: false);
    final eveningRegex = RegExp(r'\bevening\b', caseSensitive: false);
    final nightRegex = RegExp(r'\bnight\b', caseSensitive: false);

    if (morningRegex.hasMatch(working)) {
      hour ??= 9;
      minute ??= 0;
      working = working.replaceAll(morningRegex, ' ');
    } else if (afternoonRegex.hasMatch(working)) {
      hour ??= 14;
      minute ??= 0;
      working = working.replaceAll(afternoonRegex, ' ');
    } else if (eveningRegex.hasMatch(working)) {
      hour ??= 18;
      minute ??= 0;
      working = working.replaceAll(eveningRegex, ' ');
    } else if (nightRegex.hasMatch(working)) {
      hour ??= 21;
      minute ??= 0;
      working = working.replaceAll(nightRegex, ' ');
    }

    // 7. Explicit times: "at 8pm", "8:30 am", "18:00", "at 6 pm"
    final time12Regex = RegExp(r'\b(?:at\s+)?(\d{1,2})(?::(\d{2}))?\s*(am|pm)\b', caseSensitive: false);
    final time12Match = time12Regex.firstMatch(working);
    if (time12Match != null) {
      var h = int.parse(time12Match.group(1)!);
      final m = time12Match.group(2) != null ? int.parse(time12Match.group(2)!) : 0;
      final ampm = time12Match.group(3)!.toLowerCase();

      if (ampm == 'pm' && h < 12) h += 12;
      if (ampm == 'am' && h == 12) h = 0;

      hour = h;
      minute = m;
      working = working.replaceAll(time12Regex, ' ');
    } else {
      final time24Regex = RegExp(r'\b(?:at\s+)?([01]?\d|2[0-3]):([0-5]\d)\b', caseSensitive: false);
      final time24Match = time24Regex.firstMatch(working);
      if (time24Match != null) {
        hour = int.parse(time24Match.group(1)!);
        minute = int.parse(time24Match.group(2)!);
        working = working.replaceAll(time24Regex, ' ');
      }
    }

    // Clean up excessive whitespace in message
    final cleaned = working.replaceAll(RegExp(r'\s+'), ' ').trim();

    final hasParsed = date != null || hour != null || repeatRule != null || priority != null;

    return NLPParseResult(
      cleanedMessage: cleaned.isEmpty ? input.trim() : cleaned,
      scheduledDate: date,
      scheduledHour: hour,
      scheduledMinute: minute,
      repeatRule: repeatRule,
      priority: priority,
      hasParsedScheduling: hasParsed,
    );
  }

  static int _parseDayOfWeek(String name) {
    switch (name) {
      case 'monday': return 1;
      case 'tuesday': return 2;
      case 'wednesday': return 3;
      case 'thursday': return 4;
      case 'friday': return 5;
      case 'saturday': return 6;
      case 'sunday': return 7;
      default: return 1;
    }
  }
}
