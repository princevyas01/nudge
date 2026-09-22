import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';

import '../../application/controllers/reminder_controller.dart';
import '../../application/controllers/folder_controller.dart';
import '../../application/controllers/todo_controller.dart';
import '../../application/controllers/record_controller.dart';
import '../../data/backup/backup_manager.dart';
import '../../presentation/components/nudge_card.dart';
import '../../presentation/components/nudge_button.dart';

class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});

  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  bool _isExporting = false;
  bool _isImporting = false;

  Future<String?> _showSetPasswordDialog() async {
    final passwordCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();
    bool obscurePassword = true;
    bool obscureConfirm = true;
    String? errorText;

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Row(
              children: [
                Icon(Icons.lock_outline, color: Colors.blueAccent),
                SizedBox(width: 8),
                Text('Set Backup Password'),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Set a password to encrypt your backup. You will need this exact password to restore your data on any device.',
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordCtrl,
                    obscureText: obscurePassword,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter backup password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      suffixIcon: IconButton(
                        icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setDialogState(() => obscurePassword = !obscurePassword),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: confirmCtrl,
                    obscureText: obscureConfirm,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Re-enter backup password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      suffixIcon: IconButton(
                        icon: Icon(obscureConfirm ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setDialogState(() => obscureConfirm = !obscureConfirm),
                      ),
                    ),
                  ),
                  if (errorText != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      errorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, null),
                child: const Text('Cancel'),
              ),
              FilledButton.icon(
                icon: const Icon(Icons.lock),
                label: const Text('Encrypt & Export'),
                onPressed: () {
                  final p1 = passwordCtrl.text.trim();
                  final p2 = confirmCtrl.text.trim();
                  if (p1.isEmpty) {
                    setDialogState(() => errorText = 'Password cannot be empty.');
                    return;
                  }
                  if (p1.length < 4) {
                    setDialogState(() => errorText = 'Password must be at least 4 characters.');
                    return;
                  }
                  if (p1 != p2) {
                    setDialogState(() => errorText = 'Passwords do not match.');
                    return;
                  }
                  Navigator.pop(ctx, p1);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Future<String?> _showEnterPasswordDialog() async {
    final passwordCtrl = TextEditingController();
    bool obscurePassword = true;
    String? errorText;

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Row(
              children: [
                Icon(Icons.lock_open_outlined, color: Colors.indigoAccent),
                SizedBox(width: 8),
                Text('Encrypted Backup'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'This backup file is encrypted. Enter the password that was set when exporting to decrypt and view contents:',
                  style: TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordCtrl,
                  obscureText: obscurePassword,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter backup password',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    suffixIcon: IconButton(
                      icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setDialogState(() => obscurePassword = !obscurePassword),
                    ),
                  ),
                ),
                if (errorText != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    errorText!,
                    style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, null),
                child: const Text('Cancel'),
              ),
              FilledButton.icon(
                icon: const Icon(Icons.key),
                label: const Text('Unlock & Inspect'),
                onPressed: () {
                  final pwd = passwordCtrl.text.trim();
                  if (pwd.isEmpty) {
                    setDialogState(() => errorText = 'Please enter the password.');
                    return;
                  }
                  Navigator.pop(ctx, pwd);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _handleExport() async {
    final password = await _showSetPasswordDialog();
    if (password == null) return; // User cancelled

    setState(() => _isExporting = true);
    try {
      final file = await BackupManager.exportBackup(password: password);
      if (!mounted) return;

      final filename = file.path.split(Platform.pathSeparator).last;
      final sizeKb = (file.lengthSync() / 1024).toStringAsFixed(1);

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text('Backup Created'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Encrypted JSON backup generated successfully using authenticated AES-256 (PBKDF2-HMAC-SHA256). You can restore this file on any device using your password.'),
              const SizedBox(height: 12),
              Text(
                'File: $filename',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              Text(
                'Size: $sizeKb KB',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Close'),
            ),
            FilledButton.icon(
              icon: const Icon(Icons.share),
              label: const Text('Share / Save File'),
              onPressed: () {
                Navigator.pop(ctx);
                Share.shareXFiles([XFile(file.path)], text: 'Nudge 2.0 Encrypted Backup');
              },
            ),
          ],
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Export failed: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  Future<void> _handlePickAndInspect() async {
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result == null || result.files.single.path == null) return;

      final filePath = result.files.single.path!;
      final isProtected = await BackupManager.isPasswordProtected(filePath);

      String? password;
      if (isProtected) {
        password = await _showEnterPasswordDialog();
        if (password == null) return; // User cancelled password dialog
      }

      setState(() => _isImporting = true);

      final preview = await BackupManager.inspectBackupFile(filePath, password: password);
      if (!mounted) return;

      _showImportPreviewDialog(preview);
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Row(
              children: [
                Icon(Icons.error_outline, color: Colors.red),
                SizedBox(width: 8),
                Text('Cannot Read Backup'),
              ],
            ),
            content: Text(
              e is FormatException
                  ? e.message
                  : 'Verification or decryption failed: $e',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Dismiss'),
              ),
            ],
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isImporting = false);
    }
  }

  void _showImportPreviewDialog(BackupPreview preview) {
    BackupConflictPolicy selectedPolicy = BackupConflictPolicy.skip;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text('Backup Preview'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Decrypted and verified with HMAC-SHA256. Select conflict policy before committing:'),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<BackupConflictPolicy>(
                    value: selectedPolicy,
                    decoration: InputDecoration(
                      labelText: 'Conflict Policy',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: BackupConflictPolicy.skip,
                        child: Text('Skip Existing (Recommended)'),
                      ),
                      DropdownMenuItem(
                        value: BackupConflictPolicy.replace,
                        child: Text('Replace Existing Records'),
                      ),
                      DropdownMenuItem(
                        value: BackupConflictPolicy.keep,
                        child: Text('Keep Existing Records'),
                      ),
                      DropdownMenuItem(
                        value: BackupConflictPolicy.importAsCopy,
                        child: Text('Import Conflicts as Copies'),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setModalState(() => selectedPolicy = val);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildMetricRow('Reminders in Backup', '${preview.validReminders.length}', Colors.blue),
                  _buildMetricRow('Tasks & Todos', '${preview.validTodos.length}', Colors.orange),
                  _buildMetricRow('Notes & Records', '${preview.validRecords.length}', Colors.teal),
                  _buildMetricRow('Tags Included', '${preview.validTags.length}', Colors.purple),
                  _buildMetricRow('Occurrences', '${preview.validOccurrences.length}', Colors.indigo),
                  _buildMetricRow('Media / Photos', '${preview.mediaFiles.length}', Colors.cyan),
                  _buildMetricRow('Duplicate IDs', '${preview.duplicateCount}', Colors.amber),
                  _buildMetricRow('Folders Included', '${preview.validFolders.length}', Colors.green),
                  _buildMetricRow('History Logs', '${preview.validHistory.length}', Colors.grey),
                  if (preview.companionProfile != null)
                    _buildMetricRow('Companion Profile', 'Included', Colors.pink),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () async {
                  Navigator.pop(ctx);
                  await _commitImport(preview, selectedPolicy);
                },
                child: const Text('Confirm Import'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _commitImport(BackupPreview preview, BackupConflictPolicy policy) async {
    setState(() => _isImporting = true);
    final reminderCtrl = context.read<ReminderController>();
    final folderCtrl = context.read<FolderController>();
    final todoCtrl = context.read<TodoController>();
    final recordCtrl = context.read<RecordController>();

    try {
      await BackupManager.commitImport(preview, policy: policy);

      await reminderCtrl.loadReminders();
      await folderCtrl.loadFolders();
      todoCtrl.loadTodos();
      recordCtrl.loadRecords();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully imported ${preview.validReminders.length} reminders, ${preview.validTodos.length} tasks, and ${preview.validRecords.length} records!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Import error: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isImporting = false);
    }
  }

  Widget _buildMetricRow(String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 14)),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: color),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Backup & Restore'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Security Badge Card
            NudgeCard(
              color: theme.colorScheme.primaryContainer.withOpacity(0.4),
              child: Row(
                children: [
                  Icon(Icons.shield_outlined, size: 36, color: theme.colorScheme.primary),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Portable Encrypted JSON Backup',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Backups are encrypted using AES-256-CBC with PBKDF2-HMAC-SHA256 password derivation. You can safely restore your reminders, tasks, notes, and media on any device using your password.',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Export Section
            Text(
              'Export Data',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            NudgeCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create Encrypted JSON Backup',
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Exports active reminders, tasks, notes, tags, occurrences, photos, custom folders, checklists, history, and companion milestones into a password-encrypted .json file.',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                  ),
                  const SizedBox(height: 16),
                  NudgeButton(
                    label: _isExporting ? 'Packaging & Encrypting...' : 'Export Encrypted Backup',
                    icon: Icons.upload_file,
                    onPressed: _isExporting || _isImporting ? null : _handleExport,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Import Section
            Text(
              'Restore Data',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            NudgeCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Restore from Backup File',
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Inspect, decrypt with your password, choose conflict policy, and restore data from any Nudge backup file (.json or .nudgebackup).',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    icon: const Icon(Icons.download),
                    label: Text(_isImporting ? 'Inspecting Backup...' : 'Select Backup File to Restore'),
                    onPressed: _isExporting || _isImporting ? null : _handlePickAndInspect,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
