import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/domain/enums/enums.dart';
import 'package:nudge/domain/services/nlp_parser.dart';

void main() {
  group('NLPParser Unit Tests', () {
    test('Empty input returns empty cleanedMessage and false flag', () {
      final result = NLPParser.parse('');
      expect(result.cleanedMessage, isEmpty);
      expect(result.hasParsedScheduling, isFalse);
      expect(result.fullScheduledDateTime, isNull);
    });

    test('Priority parsing recognizes urgent, asap, important, and p1', () {
      final r1 = NLPParser.parse('Call client ASAP');
      expect(r1.priority, equals(PriorityLevel.high));
      expect(r1.cleanedMessage, equals('Call client'));

      final r2 = NLPParser.parse('urgent Fix production bug');
      expect(r2.priority, equals(PriorityLevel.high));
      expect(r2.cleanedMessage, equals('Fix production bug'));

      final r3 = NLPParser.parse('Important Review budget');
      expect(r3.priority, equals(PriorityLevel.high));
      expect(r3.cleanedMessage, equals('Review budget'));
    });

    test('Relative time parsing: in 15 minutes', () {
      final result = NLPParser.parse('Take pizza out of oven in 15 mins');

      expect(result.cleanedMessage, equals('Take pizza out of oven'));
      expect(result.hasParsedScheduling, isTrue);
      expect(result.scheduledDate, isNotNull);
      expect(result.scheduledHour, isNotNull);
      expect(result.scheduledMinute, isNotNull);

      final scheduled = result.fullScheduledDateTime!;
      final expectedTarget = DateTime.now().add(const Duration(minutes: 15));
      expect(scheduled.hour, equals(expectedTarget.hour));
      expect(scheduled.minute, equals(expectedTarget.minute));
    });

    test('Relative time parsing: in 2 hours', () {
      final result = NLPParser.parse('Call mom in 2 hours');
      expect(result.cleanedMessage, equals('Call mom'));
      expect(result.hasParsedScheduling, isTrue);
    });

    test('Recurrence parsing: every day, weekly, monthly, weekdays, weekends', () {
      final r1 = NLPParser.parse('Take vitamins every day');
      expect(r1.repeatRule, equals(RepeatRule.daily));
      expect(r1.cleanedMessage, equals('Take vitamins'));

      final r2 = NLPParser.parse('Weekly team sync');
      expect(r2.repeatRule, equals(RepeatRule.weekly));
      expect(r2.cleanedMessage, equals('team sync'));

      final r3 = NLPParser.parse('Pay rent monthly');
      expect(r3.repeatRule, equals(RepeatRule.monthly));
      expect(r3.cleanedMessage, equals('Pay rent'));

      final r4 = NLPParser.parse('Check emails weekdays');
      expect(r4.repeatRule, equals(RepeatRule.weekdays));
      expect(r4.cleanedMessage, equals('Check emails'));

      final r5 = NLPParser.parse('Go hiking weekends');
      expect(r5.repeatRule, equals(RepeatRule.weekends));
      expect(r5.cleanedMessage, equals('Go hiking'));
    });

    test('Date parsing: tomorrow at 3pm', () {
      final now = DateTime.now();
      final result = NLPParser.parse('Dentist appointment tomorrow at 3pm');
      expect(result.cleanedMessage, equals('Dentist appointment'));
      expect(result.hasParsedScheduling, isTrue);

      final scheduled = result.fullScheduledDateTime!;
      final tomorrow = now.add(const Duration(days: 1));
      expect(scheduled.year, equals(tomorrow.year));
      expect(scheduled.month, equals(tomorrow.month));
      expect(scheduled.day, equals(tomorrow.day));
      expect(scheduled.hour, equals(15));
      expect(scheduled.minute, equals(0));
    });

    test('Date parsing: tonight defaults to 8:00 PM', () {
      final result = NLPParser.parse('Watch movie tonight');
      expect(result.cleanedMessage, equals('Watch movie'));
      expect(result.scheduledHour, equals(20));
      expect(result.scheduledMinute, equals(0));
    });

    test('Day of week parsing: next Friday at 10:30 am', () {
      final result = NLPParser.parse('Team retro next Friday at 10:30 am');
      expect(result.cleanedMessage, equals('Team retro'));
      expect(result.scheduledHour, equals(10));
      expect(result.scheduledMinute, equals(30));
      expect(result.scheduledDate, isNotNull);
      expect(result.scheduledDate!.weekday, equals(DateTime.friday));
    });

    test('Explicit 24h format: at 17:45', () {
      final result = NLPParser.parse('Submit report at 17:45');
      expect(result.cleanedMessage, equals('Submit report'));
      expect(result.scheduledHour, equals(17));
      expect(result.scheduledMinute, equals(45));
    });

    test('Preview summary returns formatted preview', () {
      final result = NLPParser.parse('Submit report tomorrow at 5pm urgent');
      expect(result.previewSummary, contains('Tomorrow'));
      expect(result.previewSummary, contains('5:00 PM'));
      expect(result.previewSummary, contains('HIGH PRIORITY'));
    });
  });
}
