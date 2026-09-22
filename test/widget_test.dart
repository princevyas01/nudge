import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nudge/presentation/components/empty_state_widget.dart';
import 'package:nudge/presentation/components/nudge_card.dart';

void main() {
  testWidgets('NudgeCard renders child and handles taps', (WidgetTester tester) async {
    bool tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NudgeCard(
            onTap: () => tapped = true,
            child: const Text('Hello Nudge 2.0'),
          ),
        ),
      ),
    );

    expect(find.text('Hello Nudge 2.0'), findsOneWidget);
    await tester.tap(find.text('Hello Nudge 2.0'));
    expect(tapped, isTrue);
  });

  testWidgets('EmptyStateWidget renders title and description', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: EmptyStateWidget(
            icon: Icons.alarm,
            title: 'No Reminders',
            description: 'Create your first reminder',
          ),
        ),
      ),
    );

    expect(find.text('No Reminders'), findsOneWidget);
    expect(find.text('Create your first reminder'), findsOneWidget);
    expect(find.byIcon(Icons.alarm), findsOneWidget);
  });
}
