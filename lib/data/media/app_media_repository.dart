import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../../core/logging/app_logger.dart';

class AppMediaRepository {
  static const String _subsystem = 'AppMediaRepository';
  static const String mediaSubdir = 'app_media';

  /// Returns the app-owned directory for storing reminder media.
  static Future<Directory> getMediaDirectory() async {
    final appDocs = await getApplicationDocumentsDirectory();
    final mediaDir = Directory(p.join(appDocs.path, mediaSubdir));
    if (!await mediaDir.exists()) {
      await mediaDir.create(recursive: true);
    }
    return mediaDir;
  }

  /// Copies an image from [sourcePath] into the application sandbox.
  /// Returns a stable relative filename (e.g. "media_abc123.jpg").
  static Future<String> importMedia(String sourcePath) async {
    final sourceFile = File(sourcePath);
    if (!await sourceFile.exists()) {
      throw FileSystemException('Source image does not exist', sourcePath);
    }

    final ext = p.extension(sourcePath).toLowerCase();
    final safeExt = ext.isNotEmpty ? ext : '.jpg';
    final filename = 'media_${const Uuid().v4()}$safeExt';

    final mediaDir = await getMediaDirectory();
    final targetPath = p.join(mediaDir.path, filename);

    await sourceFile.copy(targetPath);
    AppLogger.info(_subsystem, 'Imported media: $filename ($targetPath)');
    return filename;
  }

  /// Resolves a relative filename to a local [File], or null if missing.
  static Future<File?> resolveMediaFile(String? relativeFilename) async {
    if (relativeFilename == null || relativeFilename.trim().isEmpty) return null;

    try {
      final mediaDir = await getMediaDirectory();
      final file = File(p.join(mediaDir.path, relativeFilename));
      if (await file.exists()) {
        return file;
      }
    } catch (e) {
      AppLogger.warning(_subsystem, 'Error resolving media file $relativeFilename: $e');
    }
    return null;
  }

  /// Deletes a sandboxed media file by its relative filename.
  static Future<bool> deleteMedia(String? relativeFilename) async {
    if (relativeFilename == null || relativeFilename.trim().isEmpty) return false;

    try {
      final mediaDir = await getMediaDirectory();
      final file = File(p.join(mediaDir.path, relativeFilename));
      if (await file.exists()) {
        await file.delete();
        AppLogger.info(_subsystem, 'Deleted media file: $relativeFilename');
        return true;
      }
    } catch (e) {
      AppLogger.warning(_subsystem, 'Failed to delete media file $relativeFilename: $e');
    }
    return false;
  }

  /// Scans the sandbox media directory and removes any files not in [activeFilenames].
  static Future<int> cleanOrphanedMedia(Set<String> activeFilenames) async {
    int removedCount = 0;
    try {
      final mediaDir = await getMediaDirectory();
      final entities = mediaDir.listSync();

      for (final entity in entities) {
        if (entity is File) {
          final name = p.basename(entity.path);
          if (!activeFilenames.contains(name)) {
            await entity.delete();
            removedCount++;
          }
        }
      }
      if (removedCount > 0) {
        AppLogger.info(_subsystem, 'Cleaned $removedCount orphaned media files');
      }
    } catch (e) {
      AppLogger.warning(_subsystem, 'Error cleaning orphaned media: $e');
    }
    return removedCount;
  }

  /// Exports all sandboxed media as a map of `{ filename: base64Data }` for backups.
  static Future<Map<String, String>> exportAllMediaBase64() async {
    final result = <String, String>{};
    try {
      final mediaDir = await getMediaDirectory();
      final entities = mediaDir.listSync();

      for (final entity in entities) {
        if (entity is File) {
          final name = p.basename(entity.path);
          final bytes = await entity.readAsBytes();
          result[name] = base64Encode(bytes);
        }
      }
    } catch (e) {
      AppLogger.error(_subsystem, 'Failed to export media for backup', error: e);
    }
    return result;
  }

  /// Restores a base64 encoded media file into the sandboxed directory.
  static Future<void> importMediaBase64(String relativeFilename, String base64Data) async {
    try {
      final mediaDir = await getMediaDirectory();
      final file = File(p.join(mediaDir.path, relativeFilename));
      final bytes = base64Decode(base64Data);
      await file.writeAsBytes(bytes);
      AppLogger.info(_subsystem, 'Restored media file: $relativeFilename');
    } catch (e) {
      AppLogger.warning(_subsystem, 'Failed to restore media file $relativeFilename: $e');
    }
  }
}
