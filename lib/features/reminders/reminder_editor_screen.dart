import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/reminder_controller.dart';
import '../../core/utils/date_utils.dart';
import '../../data/repositories/template_repository_impl.dart';
import '../../domain/entities/checklist_item.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/entities/reminder_template.dart';
import '../../domain/enums/enums.dart';
import '../../domain/services/conflict_detector.dart';
import '../../domain/services/nlp_parser.dart';
import '../../presentation/components/checklist_widget.dart';
import '../../presentation/components/nudge_button.dart';
import '../../presentation/components/nudge_text_field.dart';
import '../../presentation/components/voice_input_button.dart';
import '../../presentation/theme/nudge_theme.dart';

class ReminderEditorScreen extends StatefulWidget {
  final Reminder? initialReminder;

  const ReminderEditorScreen({super.key, this.initialReminder});

  @override
  State<ReminderEditorScreen> createState() => _ReminderEditorScreenState();
}

class _ReminderEditorScreenState extends State<ReminderEditorScreen> {
  int _currentStep = 1;
  bool _isSaving = false;

  late TextEditingController _messageController;
  late DateTime _scheduledDate;
  late TimeOfDay _scheduledTime;
  late RepeatRule _repeatRule;
  late PriorityLevel _priority;
  late AlertStyle _alertStyle;
  late String _soundId;
  late bool _vibrationEnabled;
  late bool _calendarSync;
  String? _folderId;
  List<ChecklistItem> _checklist = [];
  String? _photoPath;
  int? _repeatEndOccurrences;
  DateTime? _repeatEndDate;

  NLPParseResult? _nlpPreview;
  ConflictDetectionResult _conflictResult = ConflictDetectionResult.noConflict;
  List<ReminderTemplate> _templates = [];

  bool get _isEditing => widget.initialReminder != null;

  @override
  void initState() {
    super.initState();
    final init = widget.initialReminder;
    _messageController = TextEditingController(text: init?.message ?? '');
    _scheduledDate = init?.scheduledAt ?? DateTime.now().add(const Duration(hours: 1));
    _scheduledTime = TimeOfDay(hour: _scheduledDate.hour, minute: _scheduledDate.minute);
    _repeatRule = init?.repeatRule ?? RepeatRule.none;
    _priority = init?.priority ?? PriorityLevel.normal;
    _alertStyle = init?.alertStyle ?? AlertStyle.alarm;
    _soundId = init?.soundId ?? 'alarm';
    _vibrationEnabled = init?.vibrationEnabled ?? true;
    _calendarSync = init?.calendarEventId != null;
    _folderId = init?.folderId;
    _checklist = init != null ? List<ChecklistItem>.from(init.checklist) : [];
    _photoPath = init?.photoPath;
    _repeatEndOccurrences = init?.repeatEndOccurrences;
    _repeatEndDate = init?.repeatEndDate;

    _messageController.addListener(_onMessageChanged);
    _loadTemplates();
  }

  Future<void> _loadTemplates() async {
    final templates = await TemplateRepositoryImpl().getAllTemplates();
    if (mounted) setState(() => _templates = templates);
  }

  void _onMessageChanged() {
    final text = _messageController.text;
    if (!_isEditing && text.isNotEmpty) {
      final parsed = NLPParser.parse(text);
      setState(() {
        _nlpPreview = parsed.hasParsedScheduling ? parsed : null;
      });
    }
    _runConflictCheck();
  }

  void _runConflictCheck() {
    final candidateTime = DateTime(
      _scheduledDate.year,
      _scheduledDate.month,
      _scheduledDate.day,
      _scheduledTime.hour,
      _scheduledTime.minute,
    );

    final candidate = Reminder(
      id: widget.initialReminder?.id,
      message: _messageController.text,
      scheduledAt: candidateTime,
      folderId: _folderId,
    );

    final existing = context.read<ReminderController>().reminders;
    final conflict = ConflictDetector.checkConflicts(
      candidate: candidate,
      existingReminders: existing,
      currentEditingId: widget.initialReminder?.id,
    );

    setState(() => _conflictResult = conflict);
  }

  void _applyNlpPreview() {
    if (_nlpPreview == null) return;
    setState(() {
      _messageController.text = _nlpPreview!.cleanedMessage;
      if (_nlpPreview!.scheduledDate != null) {
        _scheduledDate = _nlpPreview!.scheduledDate!;
      }
      if (_nlpPreview!.scheduledHour != null && _nlpPreview!.scheduledMinute != null) {
        _scheduledTime = TimeOfDay(
          hour: _nlpPreview!.scheduledHour!,
          minute: _nlpPreview!.scheduledMinute!,
        );
      }
      if (_nlpPreview!.repeatRule != null) {
        _repeatRule = _nlpPreview!.repeatRule!;
      }
      if (_nlpPreview!.priority != null) {
        _priority = _nlpPreview!.priority!;
      }
      _nlpPreview = null;
    });
    _runConflictCheck();
  }

  void _applyTemplate(ReminderTemplate t) {
    setState(() {
      _messageController.text = t.message;
      _priority = t.priority;
      _alertStyle = t.alertStyle;
      _repeatRule = t.repeatRule;
      _checklist = List<ChecklistItem>.from(t.checklist);
    });
    _runConflictCheck();
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery, maxWidth: 1024);
    if (image != null) {
      setState(() => _photoPath = image.path);
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _scheduledDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null) {
      setState(() => _scheduledDate = picked);
      _runConflictCheck();
    }
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _scheduledTime,
    );
    if (picked != null) {
      setState(() => _scheduledTime = picked);
      _runConflictCheck();
    }
  }

  Future<void> _saveReminder() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a reminder title')),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final scheduledDateTime = DateTime(
        _scheduledDate.year,
        _scheduledDate.month,
        _scheduledDate.day,
        _scheduledTime.hour,
        _scheduledTime.minute,
      );

      final controller = context.read<ReminderController>();

      final reminder = Reminder(
        id: widget.initialReminder?.id,
        message: message,
        folderId: _folderId,
        scheduledAt: scheduledDateTime,
        repeatRule: _repeatRule,
        soundId: _soundId,
        vibrationEnabled: _vibrationEnabled,
        isDone: widget.initialReminder?.isDone ?? false,
        createdAt: widget.initialReminder?.createdAt,
        checklist: _checklist,
        photoPath: _photoPath,
        priority: _priority,
        repeatEndOccurrences: _repeatEndOccurrences,
        repeatEndDate: _repeatEndDate,
        alertStyle: _alertStyle,
        snoozeCount: widget.initialReminder?.snoozeCount ?? 0,
        calendarEventId: widget.initialReminder?.calendarEventId,
        isPinned: widget.initialReminder?.isPinned ?? false,
        isArchived: widget.initialReminder?.isArchived ?? false,
      );

      if (_isEditing) {
        await controller.updateReminder(reminder, syncCalendar: _calendarSync);
      } else {
        await controller.createReminder(reminder, syncCalendar: _calendarSync);
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_isEditing ? 'Reminder updated' : 'Reminder created')),
        );
      }
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Save Error'),
            content: Text('Failed to save reminder: $e'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK')),
            ],
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<bool> _onWillPop() async {
    if (_currentStep == 2) {
      setState(() => _currentStep = 1);
      return false;
    }
    if (_messageController.text.trim().isNotEmpty) {
      final discard = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Discard Changes?'),
          content: const Text('You have unsaved changes. Are you sure you want to exit?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Keep Editing')),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: NudgeTheme.error),
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Discard'),
            ),
          ],
        ),
      );
      return discard ?? false;
    }
    return true;
  }

  @override
  void dispose() {
    _messageController.removeListener(_onMessageChanged);
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final folderController = context.watch<FolderController>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isEditing ? 'Edit Reminder' : 'New Reminder'),
          leading: IconButton(
            icon: Icon(_currentStep == 2 ? Icons.arrow_back : Icons.close),
            onPressed: () async {
              if (_currentStep == 2) {
                setState(() => _currentStep = 1);
              } else {
                final shouldPop = await _onWillPop();
                if (shouldPop && context.mounted) Navigator.pop(context);
              }
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: _currentStep == 1
                ? _buildStep1(isDark)
                : _buildStep2(isDark, folderController),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: isDark ? NudgeTheme.surfaceDark : NudgeTheme.surfaceLight,
            border: Border(
              top: BorderSide(
                color: isDark ? NudgeTheme.cardBorderDark : NudgeTheme.cardBorderLight,
              ),
            ),
          ),
          child: _currentStep == 1
              ? NudgeButton(
                  label: 'Next: Alert Settings',
                  icon: Icons.arrow_forward,
                  onPressed: () {
                    if (_messageController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a reminder message')),
                      );
                      return;
                    }
                    setState(() => _currentStep = 2);
                  },
                )
              : Row(
                  children: [
                    Expanded(
                      child: NudgeButton(
                        label: 'Back',
                        variant: ButtonVariant.outline,
                        onPressed: () => setState(() => _currentStep = 1),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: NudgeButton(
                        label: _isEditing ? 'Update Reminder' : 'Save Reminder',
                        icon: Icons.check,
                        isLoading: _isSaving,
                        onPressed: _saveReminder,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildStep1(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Quick Templates
        if (_templates.isNotEmpty && !_isEditing) ...[
          Text(
            'Quick Templates',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark ? NudgeTheme.onPrimaryContainer : NudgeTheme.secondary,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _templates.map((t) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ActionChip(
                    avatar: const Icon(Icons.flash_on, size: 14),
                    label: Text(t.title),
                    onPressed: () => _applyTemplate(t),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Message Input & Voice
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: NudgeTextField(
                controller: _messageController,
                label: 'What would you like to be reminded of?',
                hint: 'e.g. Call dentist tomorrow at 3pm urgent',
                maxLines: 2,
                autofocus: !_isEditing,
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: VoiceInputButton(
                onTranscript: (transcript) {
                  _messageController.text = transcript;
                },
              ),
            ),
          ],
        ),

        // Live NLP Preview Banner
        if (_nlpPreview != null) ...[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isDark ? NudgeTheme.primaryContainer : NudgeTheme.secondaryContainer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(NudgeTheme.radiusM),
              border: Border.all(color: NudgeTheme.secondary.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.auto_awesome, size: 18, color: NudgeTheme.secondary),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Detected Schedule',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: NudgeTheme.secondary),
                      ),
                      Text(
                        _nlpPreview!.previewSummary,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: _applyNlpPreview,
                  child: const Text('Apply'),
                ),
              ],
            ),
          ),
        ],

        // Conflict Detection Warning Banner
        if (_conflictResult.hasConflict) ...[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.15),
              borderRadius: BorderRadius.circular(NudgeTheme.radiusM),
              border: Border.all(color: Colors.amber, width: 1.0),
            ),
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded, size: 20, color: Colors.amber),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _conflictResult.warningMessage ?? 'Scheduling conflict detected',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ],

        const SizedBox(height: 20),

        // Date and Time selectors
        Row(
          children: [
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(NudgeTheme.radiusM),
                onTap: _selectDate,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: isDark ? NudgeTheme.surfaceContainerDark : NudgeTheme.surfaceContainerLight,
                    borderRadius: BorderRadius.circular(NudgeTheme.radiusM),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 18, color: NudgeTheme.secondary),
                      const SizedBox(width: 10),
                      Text(
                        NudgeDateUtils.formatDate(_scheduledDate),
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(NudgeTheme.radiusM),
                onTap: _selectTime,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: isDark ? NudgeTheme.surfaceContainerDark : NudgeTheme.surfaceContainerLight,
                    borderRadius: BorderRadius.circular(NudgeTheme.radiusM),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.access_time, size: 18, color: NudgeTheme.secondary),
                      const SizedBox(width: 10),
                      Text(
                        _scheduledTime.format(context),
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Recurrence Selector
        Text(
          'Repeat',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDark ? NudgeTheme.onPrimaryContainer : NudgeTheme.secondary,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: RepeatRule.values.map((rule) {
            final isSelected = _repeatRule == rule;
            return ChoiceChip(
              label: Text(rule.name),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) setState(() => _repeatRule = rule);
              },
            );
          }).toList(),
        ),

        const SizedBox(height: 20),

        // Checklist builder
        ChecklistWidget(
          items: _checklist,
          onChanged: (updated) => setState(() => _checklist = updated),
        ),

        const SizedBox(height: 20),

        // Photo Attachment
        Text(
          'Photo Attachment',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDark ? NudgeTheme.onPrimaryContainer : NudgeTheme.secondary,
          ),
        ),
        const SizedBox(height: 8),
        if (_photoPath != null && _photoPath!.isNotEmpty) ...[
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(NudgeTheme.radiusM),
                child: Image.file(
                  File(_photoPath!),
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 120,
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    child: const Text('Image file unavailable'),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton.filled(
                  style: IconButton.styleFrom(backgroundColor: Colors.black54),
                  icon: const Icon(Icons.close, color: Colors.white, size: 18),
                  onPressed: () => setState(() => _photoPath = null),
                ),
              ),
            ],
          ),
        ] else ...[
          OutlinedButton.icon(
            icon: const Icon(Icons.add_a_photo_outlined),
            label: const Text('Attach photo'),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(NudgeTheme.radiusM)),
            ),
            onPressed: _pickPhoto,
          ),
        ],
      ],
    );
  }

  Widget _buildStep2(bool isDark, FolderController folderController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Folder Selector
        Text(
          'Folder',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDark ? NudgeTheme.onPrimaryContainer : NudgeTheme.secondary,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: folderController.folders.map((f) {
            final isSelected = _folderId == f.id;
            return ChoiceChip(
              avatar: Icon(NudgeTheme.getFolderIcon(f), size: 16),
              label: Text(f.name),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => _folderId = selected ? f.id : null);
              },
            );
          }).toList(),
        ),

        const SizedBox(height: 20),

        // Priority Level
        Text(
          'Priority',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDark ? NudgeTheme.onPrimaryContainer : NudgeTheme.secondary,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: PriorityLevel.values.map((p) {
            final isSelected = _priority == p;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ChoiceChip(
                  label: Center(child: Text(p.name.toUpperCase())),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) setState(() => _priority = p);
                  },
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 24),

        // Alert Style (Alarm vs Gentle Notification)
        Text(
          'Alert Mode',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDark ? NudgeTheme.onPrimaryContainer : NudgeTheme.secondary,
          ),
        ),
        const SizedBox(height: 8),
        RadioListTile<AlertStyle>(
          title: const Text('Full-Screen Alarm', style: TextStyle(fontWeight: FontWeight.w600)),
          subtitle: const Text('Intrusive wake-up alarm with looping audio & vibration'),
          value: AlertStyle.alarm,
          groupValue: _alertStyle,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(NudgeTheme.radiusM)),
          onChanged: (val) => setState(() => _alertStyle = val!),
        ),
        RadioListTile<AlertStyle>(
          title: const Text('Gentle Notification', style: TextStyle(fontWeight: FontWeight.w600)),
          subtitle: const Text('Subtle notification banner with action buttons'),
          value: AlertStyle.gentle,
          groupValue: _alertStyle,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(NudgeTheme.radiusM)),
          onChanged: (val) => setState(() => _alertStyle = val!),
        ),

        const SizedBox(height: 16),

        // Vibration Switch
        SwitchListTile(
          title: const Text('Vibration'),
          subtitle: const Text('Vibrate phone when alarm or notification triggers'),
          value: _vibrationEnabled,
          onChanged: (val) => setState(() => _vibrationEnabled = val),
        ),

        // Calendar Sync Switch
        SwitchListTile(
          title: const Text('Sync to Device Calendar'),
          subtitle: const Text('Add an event into your local device calendar'),
          value: _calendarSync,
          onChanged: (val) => setState(() => _calendarSync = val),
        ),
      ],
    );
  }
}
