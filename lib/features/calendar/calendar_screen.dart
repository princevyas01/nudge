import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../application/controllers/reminder_controller.dart';
import '../../core/utils/date_utils.dart';
import '../../domain/entities/reminder.dart';
import '../../presentation/components/empty_state_widget.dart';
import '../home/reminder_card.dart';
import '../../presentation/theme/nudge_theme.dart';
import '../reminders/reminder_editor_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final reminderController = context.watch<ReminderController>();

    final activeReminders = reminderController.reminders.where((r) => !r.isArchived).toList();

    List<Reminder> getRemindersForDay(DateTime day) {
      return activeReminders.where((r) => NudgeDateUtils.isSameDay(r.scheduledAt, day)).toList();
    }

    final selectedDayReminders = getRemindersForDay(_selectedDay);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Column(
        children: [
          // TableCalendar
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(NudgeTheme.radiusL),
              side: BorderSide(color: isDark ? NudgeTheme.cardBorderDark : NudgeTheme.cardBorderLight),
            ),
            child: TableCalendar<Reminder>(
              firstDay: DateTime.now().subtract(const Duration(days: 365)),
              lastDay: DateTime.now().add(const Duration(days: 365 * 3)),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => NudgeDateUtils.isSameDay(_selectedDay, day),
              calendarFormat: CalendarFormat.month,
              eventLoader: getRemindersForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: isDark ? NudgeTheme.secondaryContainer : NudgeTheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: NudgeTheme.secondary.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                markerDecoration: const BoxDecoration(
                  color: NudgeTheme.secondary,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  NudgeDateUtils.formatDate(_selectedDay),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '${selectedDayReminders.length} reminders',
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Reminders for selected day
          Expanded(
            child: selectedDayReminders.isEmpty
                ? EmptyStateWidget(
                    icon: Icons.event_available,
                    title: 'No Reminders for this Day',
                    subtitle: 'Schedule a reminder for ${NudgeDateUtils.formatDate(_selectedDay)}',
                    actionLabel: 'Add Reminder',
                    onAction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ReminderEditorScreen(
                            initialReminder: Reminder(
                              message: '',
                              scheduledAt: _selectedDay.copyWith(hour: 10, minute: 0),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: selectedDayReminders.length,
                    itemBuilder: (context, index) {
                      return ReminderCard(reminder: selectedDayReminders[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ReminderEditorScreen(
                initialReminder: Reminder(
                  message: '',
                  scheduledAt: _selectedDay.copyWith(hour: 10, minute: 0),
                ),
              ),
            ),
          );
        },
        tooltip: 'Add reminder for this day',
        child: const Icon(Icons.add),
      ),
    );
  }
}
