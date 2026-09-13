enum RepeatRule {
  none,
  daily,
  weekly,
  monthly,
  weekdays,
  weekends,
  customInterval,
}

enum PriorityLevel {
  low,
  normal,
  high,
}

enum AlertStyle {
  alarm,
  gentle,
}

enum CustomRepeatType {
  days,
  weeks,
  months,
}

enum CompanionMood {
  sleepy,
  neutral,
  happy,
  celebratory,
}

enum ActionType {
  created,
  edited,
  completed,
  snoozed,
  archived,
  restored,
  deleted,
  skipped,
}

enum SortOption {
  time,
  priority,
  created,
}

enum FilterType {
  all,
  today,
  overdue,
  upcoming,
  pinned,
  completed,
  archived,
}

enum OccurrenceStatus {
  pending,
  completed,
  snoozed,
  skipped,
  missed,
}
