import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../platform/permissions/permission_manager.dart';
import '../theme/nudge_theme.dart';

class VoiceInputButton extends StatefulWidget {
  final ValueChanged<String> onTranscript;

  const VoiceInputButton({super.key, required this.onTranscript});

  @override
  State<VoiceInputButton> createState() => _VoiceInputButtonState();
}

class _VoiceInputButtonState extends State<VoiceInputButton> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  bool _isAvailable = false;

  Future<void> _toggleListening() async {
    if (_isListening) {
      await _speech.stop();
      setState(() => _isListening = false);
      return;
    }

    final status = await PermissionManager.requestMicrophonePermission();
    if (!status) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Microphone permission is required for voice input.'),
            action: SnackBarAction(
              label: 'SETTINGS',
              onPressed: () => PermissionManager.openAppSettings(),
            ),
          ),
        );
      }
      return;
    }

    _isAvailable = await _speech.initialize(
      onError: (val) => setState(() => _isListening = false),
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          setState(() => _isListening = false);
        }
      },
    );

    if (_isAvailable) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (result) {
          if (result.recognizedWords.isNotEmpty) {
            widget.onTranscript(result.recognizedWords);
          }
        },
      );
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Speech recognition not available on this device')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      style: IconButton.styleFrom(
        backgroundColor: _isListening ? NudgeTheme.error : null,
      ),
      icon: Icon(
        _isListening ? Icons.mic : Icons.mic_none,
        color: _isListening ? Colors.white : null,
      ),
      tooltip: _isListening ? 'Stop voice listening' : 'Start voice input',
      onPressed: _toggleListening,
    );
  }
}
