import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../application/controllers/settings_controller.dart';
import '../../core/logging/app_logger.dart';
import '../../platform/alarms/alarm_platform_service.dart';
import '../../presentation/components/nudge_button.dart';
import '../../presentation/components/nudge_card.dart';

class CustomAlarmSoundScreen extends StatefulWidget {
  const CustomAlarmSoundScreen({super.key});

  @override
  State<CustomAlarmSoundScreen> createState() => _CustomAlarmSoundScreenState();
}

class _CustomAlarmSoundScreenState extends State<CustomAlarmSoundScreen>
    with SingleTickerProviderStateMixin {
  static const String _subsystem = 'CustomAlarmSoundScreen';

  String? _selectedFilePath;
  String _selectedTitle = '';
  int _totalDurationMs = 0;
  int _startMs = 0;
  int _clipDurationMs = 30000; // 30s default like Instagram
  bool _isPlayingPreview = false;
  bool _isLoadingFile = false;

  Timer? _previewProgressTimer;
  double _playbackProgress = 0.0; // 0.0 to 1.0 within segment

  // Deterministic visual waveform heights (80 bars)
  late List<double> _waveformBars;

  @override
  void initState() {
    super.initState();
    _generateWaveform();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadExistingSound();
    });
  }

  void _generateWaveform([String seed = 'nudge_sound']) {
    final random = Random(seed.hashCode);
    _waveformBars = List.generate(80, (index) {
      final envelope = sin((index / 80) * pi);
      final raw = (0.2 + 0.8 * random.nextDouble()) * (0.4 + 0.6 * envelope);
      return raw.clamp(0.15, 1.0);
    });
  }

  Future<void> _loadExistingSound() async {
    final settings = context.read<SettingsController>();
    await settings.refreshCustomSound();

    if (settings.hasCustomSound && settings.customSoundPath != null) {
      final file = File(settings.customSoundPath!);
      if (await file.exists()) {
        final durationInfo = await AlarmPlatformService.getAudioDuration(file.path);
        if (mounted) {
          setState(() {
            _selectedFilePath = file.path;
            _selectedTitle = settings.customSoundTitle ?? p.basenameWithoutExtension(file.path);
            _totalDurationMs = (durationInfo?['durationMs'] as num?)?.toInt() ?? 60000;
            _startMs = settings.customSoundStartMs;
            final endMs = settings.customSoundEndMs;
            if (endMs > _startMs) {
              _clipDurationMs = endMs - _startMs;
            } else {
              _clipDurationMs = 30000.clamp(1000, _totalDurationMs);
            }
            _generateWaveform(file.path);
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _stopPreview();
    super.dispose();
  }

  Future<void> _pickAudioFile() async {
    try {
      setState(() => _isLoadingFile = true);
      _stopPreview();

      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['mp3', 'm4a', 'wav', 'aac', 'ogg', 'flac'],
      );

      if (result != null && result.files.single.path != null) {
        final pickedPath = result.files.single.path!;
        final originalFile = File(pickedPath);

        // Copy to app documents storage to prevent deletion or permission expiration
        final docsDir = await getApplicationDocumentsDirectory();
        final ext = p.extension(pickedPath);
        final targetPath = p.join(docsDir.path, 'custom_alarm_sound$ext');
        final savedFile = await originalFile.copy(targetPath);

        final durationInfo = await AlarmPlatformService.getAudioDuration(savedFile.path);
        final durationMs = (durationInfo?['durationMs'] as num?)?.toInt() ?? 60000;
        final title = durationInfo?['title'] as String? ?? p.basenameWithoutExtension(pickedPath);

        setState(() {
          _selectedFilePath = savedFile.path;
          _selectedTitle = title;
          _totalDurationMs = durationMs;
          _startMs = 0;
          _clipDurationMs = min(30000, _totalDurationMs);
          _generateWaveform(savedFile.path);
        });

        AppLogger.info(_subsystem, 'Picked audio: $title, duration: ${durationMs}ms');
      }
    } catch (e, stack) {
      AppLogger.error(_subsystem, 'Failed picking audio file', error: e, stackTrace: stack);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open audio file: $e'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoadingFile = false);
      }
    }
  }

  int get _effectiveEndMs {
    if (_totalDurationMs <= 0) return _startMs + _clipDurationMs;
    return min(_startMs + _clipDurationMs, _totalDurationMs);
  }

  void _onWaveformScrub(double ratio) {
    if (_totalDurationMs <= 0) return;
    final targetStart = (ratio * _totalDurationMs).toInt();
    final maxStart = max(0, _totalDurationMs - _clipDurationMs);
    final clampedStart = targetStart.clamp(0, maxStart);

    setState(() {
      _startMs = clampedStart;
      _playbackProgress = 0.0;
    });

    if (_isPlayingPreview) {
      _startPreview();
    }
  }

  void _nudgeStart(int deltaMs) {
    if (_totalDurationMs <= 0) return;
    final maxStart = max(0, _totalDurationMs - _clipDurationMs);
    final next = (_startMs + deltaMs).clamp(0, maxStart);
    setState(() {
      _startMs = next;
      _playbackProgress = 0.0;
    });

    if (_isPlayingPreview) {
      _startPreview();
    }
  }

  void _setClipDuration(int durationMs) {
    if (_totalDurationMs <= 0) {
      setState(() => _clipDurationMs = durationMs);
      return;
    }

    final targetDuration = durationMs == -1 ? _totalDurationMs : durationMs;
    final maxStart = max(0, _totalDurationMs - targetDuration);

    setState(() {
      _clipDurationMs = targetDuration;
      _startMs = _startMs.clamp(0, maxStart);
      _playbackProgress = 0.0;
    });

    if (_isPlayingPreview) {
      _startPreview();
    }
  }

  Future<void> _startPreview() async {
    if (_selectedFilePath == null) return;
    _stopPreview();

    final endMs = _effectiveEndMs;
    await AlarmPlatformService.playAudioPreview(_selectedFilePath!, _startMs, endMs);

    setState(() {
      _isPlayingPreview = true;
      _playbackProgress = 0.0;
    });

    final duration = endMs - _startMs;
    if (duration > 0) {
      const interval = Duration(milliseconds: 50);
      int elapsedMs = 0;
      _previewProgressTimer = Timer.periodic(interval, (timer) {
        elapsedMs += 50;
        if (elapsedMs >= duration) {
          elapsedMs = 0;
        }
        if (mounted) {
          setState(() {
            _playbackProgress = elapsedMs / duration;
          });
        }
      });
    }
  }

  void _stopPreview() {
    _previewProgressTimer?.cancel();
    _previewProgressTimer = null;
    AlarmPlatformService.stopAudioPreview();
    if (mounted) {
      setState(() {
        _isPlayingPreview = false;
        _playbackProgress = 0.0;
      });
    }
  }

  Future<void> _saveAsAlarmSound() async {
    if (_selectedFilePath == null) return;
    _stopPreview();

    final settings = context.read<SettingsController>();
    final endMs = _effectiveEndMs;

    await settings.setCustomSound(
      filePath: _selectedFilePath!,
      startMs: _startMs,
      endMs: endMs,
      title: _selectedTitle,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Custom alarm set: $_selectedTitle (${_formatTime(_startMs)} - ${_formatTime(endMs)})',
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green[700],
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _resetToDefault() async {
    _stopPreview();
    final settings = context.read<SettingsController>();
    await settings.resetCustomSound();

    setState(() {
      _selectedFilePath = null;
      _selectedTitle = '';
      _totalDurationMs = 0;
      _startMs = 0;
      _clipDurationMs = 30000;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Reverted to system default alarm sound.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  String _formatTime(int ms) {
    final totalSeconds = (ms / 1000).floor();
    final minutes = (totalSeconds / 60).floor();
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settings = context.watch<SettingsController>();
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Alarm Sound'),
        actions: [
          if (settings.hasCustomSound)
            IconButton(
              icon: const Icon(Icons.restore),
              tooltip: 'Reset to System Default',
              onPressed: _resetToDefault,
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          NudgeCard(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: settings.hasCustomSound
                        ? theme.colorScheme.primaryContainer
                        : theme.colorScheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    settings.hasCustomSound ? Icons.music_note : Icons.alarm,
                    color: settings.hasCustomSound
                        ? theme.colorScheme.primary
                        : theme.colorScheme.outline,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Active Alarm Sound',
                        style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.outline),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        settings.hasCustomSound
                            ? (settings.customSoundTitle ?? 'Custom Song')
                            : 'System Default Alarm Ringtone',
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (settings.hasCustomSound) ...[
                        const SizedBox(height: 2),
                        Text(
                          'Clip: ${_formatTime(settings.customSoundStartMs)} - ${_formatTime(settings.customSoundEndMs)}',
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary),
                        ),
                      ],
                    ],
                  ),
                ),
                if (settings.hasCustomSound)
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      visualDensity: VisualDensity.compact,
                    ),
                    onPressed: _resetToDefault,
                    child: const Text('Default'),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(54),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              side: BorderSide(color: theme.colorScheme.primary, width: 1.5),
            ),
            icon: _isLoadingFile
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.audio_file_rounded),
            label: Text(
              _selectedFilePath == null ? 'Select Audio File from Device' : 'Change Audio File',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            onPressed: _isLoadingFile ? null : _pickAudioFile,
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Supports MP3, M4A, WAV, AAC, OGG files on your phone',
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
            ),
          ),
          const SizedBox(height: 24),
          if (_selectedFilePath != null) ...[
            Text(
              'Select Alarm Audio Segment',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Slide the selection window to choose the exact part you want to wake up to, like in Instagram.',
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
            ),
            const SizedBox(height: 16),
            NudgeCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.graphic_eq, color: theme.colorScheme.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _selectedTitle,
                          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        _formatTime(_totalDurationMs),
                        style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildInstagramWaveform(theme, isDark),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Start: ${_formatTime(_startMs)}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                      Text(
                        '${(_clipDurationMs / 1000).round()}s clip',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                          fontSize: 13,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'End: ${_formatTime(_effectiveEndMs)}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('Duration:', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Wrap(
                          spacing: 8,
                          children: [
                            _buildDurationChip(15000, '15s'),
                            _buildDurationChip(30000, '30s'),
                            _buildDurationChip(45000, '45s'),
                            _buildDurationChip(60000, '60s'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton.filledTonal(
                        icon: const Icon(Icons.fast_rewind_rounded),
                        tooltip: 'Nudge back 1s',
                        onPressed: () => _nudgeStart(-1000),
                      ),
                      const SizedBox(width: 16),
                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        ),
                        icon: Icon(_isPlayingPreview ? Icons.stop_rounded : Icons.play_arrow_rounded),
                        label: Text(_isPlayingPreview ? 'Stop Preview' : 'Play Segment'),
                        onPressed: _isPlayingPreview ? _stopPreview : _startPreview,
                      ),
                      const SizedBox(width: 16),
                      IconButton.filledTonal(
                        icon: const Icon(Icons.fast_forward_rounded),
                        tooltip: 'Nudge forward 1s',
                        onPressed: () => _nudgeStart(1000),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            NudgeButton(
              label: 'Set as Alarm Sound',
              icon: Icons.check_circle_outline,
              isExpanded: true,
              onPressed: _saveAsAlarmSound,
            ),
            const SizedBox(height: 32),
          ],
        ],
      ),
    );
  }

  Widget _buildDurationChip(int durationMs, String label) {
    final isSelected = _clipDurationMs == durationMs;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      visualDensity: VisualDensity.compact,
      onSelected: (_) => _setClipDuration(durationMs),
    );
  }

  Widget _buildInstagramWaveform(ThemeData theme, bool isDark) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        const height = 90.0;

        final totalMs = max(1, _totalDurationMs);
        final startRatio = (_startMs / totalMs).clamp(0.0, 1.0);
        final endRatio = (_effectiveEndMs / totalMs).clamp(0.0, 1.0);

        final windowLeft = startRatio * width;
        final windowWidth = max(24.0, (endRatio - startRatio) * width);
        final playheadX = windowLeft + (_playbackProgress * windowWidth);

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onHorizontalDragUpdate: (details) {
            final localX = details.localPosition.dx.clamp(0.0, width);
            final ratio = localX / width;
            _onWaveformScrub(ratio);
          },
          onTapDown: (details) {
            final localX = details.localPosition.dx.clamp(0.0, width);
            final ratio = localX / width;
            _onWaveformScrub(ratio);
          },
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[900] : Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: _waveformBars.map((h) {
                        return Container(
                          width: 2.2,
                          height: (height - 24) * h,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.outline.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Positioned(
                  left: windowLeft,
                  top: 0,
                  bottom: 0,
                  width: windowWidth,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.22),
                      border: Border.symmetric(
                        horizontal: BorderSide(color: theme.colorScheme.primary, width: 2),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 6,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: const BorderRadius.horizontal(left: Radius.circular(4)),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 6,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: const BorderRadius.horizontal(right: Radius.circular(4)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_isPlayingPreview)
                  Positioned(
                    left: playheadX.clamp(0.0, width - 2.5),
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 2.5,
                      color: theme.colorScheme.error,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
