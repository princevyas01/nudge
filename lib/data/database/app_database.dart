import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../core/constants/app_constants.dart';
import '../../core/logging/app_logger.dart';

class AppDatabase {
  static const String _subsystem = 'AppDatabase';
  static const String _dbName = 'nudge_v2.db';
  static const int _dbVersion = 3;

  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    if (kIsWeb) {
      throw UnsupportedError('Web SQLite is not supported in offline mode');
    }

    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    String path;
    if (Platform.isWindows || Platform.isLinux) {
      final appDocDir = await getApplicationDocumentsDirectory();
      path = join(appDocDir.path, 'Nudge', _dbName);
      final dir = Directory(dirname(path));
      if (!dir.existsSync()) {
        dir.createSync(recursive: true);
      }
    } else {
      final databasesPath = await getDatabasesPath();
      path = join(databasesPath, _dbName);
    }

    AppLogger.info(_subsystem, 'Opening SQLite database at path: $path');
    return await openDatabase(
      path,
      version: _dbVersion,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await _createTables(db);
        await _seedInitialData(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        AppLogger.info(_subsystem, 'Upgrading database from $oldVersion to $newVersion');
        if (oldVersion < 2) {
          try {
            await db.execute('ALTER TABLE reminders ADD COLUMN isAlarmSynced INTEGER NOT NULL DEFAULT 1');
          } catch (_) {}

          await db.execute('''
            CREATE TABLE IF NOT EXISTS reminder_occurrences (
              id TEXT PRIMARY KEY,
              reminderId TEXT NOT NULL,
              scheduledAt TEXT NOT NULL,
              completedAt TEXT,
              status TEXT NOT NULL,
              snoozeCount INTEGER NOT NULL DEFAULT 0,
              actionMetadata TEXT,
              FOREIGN KEY (reminderId) REFERENCES reminders(id) ON DELETE CASCADE
            )
          ''');

          await db.execute(
            'CREATE INDEX IF NOT EXISTS idx_occurrences_reminder ON reminder_occurrences(reminderId)',
          );
          await db.execute(
            'CREATE INDEX IF NOT EXISTS idx_occurrences_scheduled ON reminder_occurrences(scheduledAt)',
          );
        }

        if (oldVersion < 3) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS todos (
              id TEXT PRIMARY KEY,
              title TEXT NOT NULL,
              description TEXT,
              status TEXT NOT NULL,
              priority TEXT NOT NULL,
              folderId TEXT,
              createdAt TEXT NOT NULL,
              updatedAt TEXT NOT NULL,
              completedAt TEXT,
              dueAt TEXT,
              isPinned INTEGER NOT NULL DEFAULT 0,
              isArchived INTEGER NOT NULL DEFAULT 0,
              isDeleted INTEGER NOT NULL DEFAULT 0,
              parentTodoId TEXT,
              sortOrder INTEGER NOT NULL DEFAULT 0,
              tagsJson TEXT,
              recurrenceRule TEXT,
              reminderEnabled INTEGER NOT NULL DEFAULT 0,
              reminderAt TEXT,
              colorTag TEXT,
              sourceRecordId TEXT,
              metadataJson TEXT,
              FOREIGN KEY (folderId) REFERENCES folders(id) ON DELETE SET NULL
            )
          ''');

          await db.execute('''
            CREATE TABLE IF NOT EXISTS todo_subtasks (
              id TEXT PRIMARY KEY,
              todoId TEXT NOT NULL,
              text TEXT NOT NULL,
              isDone INTEGER NOT NULL DEFAULT 0,
              sortOrder INTEGER NOT NULL DEFAULT 0,
              createdAt TEXT NOT NULL,
              completedAt TEXT,
              FOREIGN KEY (todoId) REFERENCES todos(id) ON DELETE CASCADE
            )
          ''');

          await db.execute('''
            CREATE TABLE IF NOT EXISTS records (
              id TEXT PRIMARY KEY,
              title TEXT NOT NULL,
              content TEXT NOT NULL,
              recordType TEXT NOT NULL,
              createdAt TEXT NOT NULL,
              updatedAt TEXT NOT NULL,
              occurredAt TEXT,
              isPinned INTEGER NOT NULL DEFAULT 0,
              isArchived INTEGER NOT NULL DEFAULT 0,
              isDeleted INTEGER NOT NULL DEFAULT 0,
              folderId TEXT,
              colorTag TEXT,
              source TEXT,
              linkedReminderId TEXT,
              linkedTodoId TEXT,
              attachmentPath TEXT,
              metadataJson TEXT,
              FOREIGN KEY (folderId) REFERENCES folders(id) ON DELETE SET NULL
            )
          ''');

          await db.execute('''
            CREATE TABLE IF NOT EXISTS tags (
              id TEXT PRIMARY KEY,
              name TEXT NOT NULL UNIQUE,
              colorTag TEXT NOT NULL,
              createdAt TEXT NOT NULL
            )
          ''');

          await db.execute('''
            CREATE TABLE IF NOT EXISTS entity_tags (
              id TEXT PRIMARY KEY,
              tagId TEXT NOT NULL,
              entityType TEXT NOT NULL,
              entityId TEXT NOT NULL,
              FOREIGN KEY (tagId) REFERENCES tags(id) ON DELETE CASCADE
            )
          ''');

          await db.execute('CREATE INDEX IF NOT EXISTS idx_todos_status ON todos(status)');
          await db.execute('CREATE INDEX IF NOT EXISTS idx_todos_dueAt ON todos(dueAt)');
          await db.execute('CREATE INDEX IF NOT EXISTS idx_todos_folder ON todos(folderId)');
          await db.execute('CREATE INDEX IF NOT EXISTS idx_subtasks_todo ON todo_subtasks(todoId)');
          await db.execute('CREATE INDEX IF NOT EXISTS idx_records_type ON records(recordType)');
          await db.execute('CREATE INDEX IF NOT EXISTS idx_records_folder ON records(folderId)');
          await db.execute('CREATE INDEX IF NOT EXISTS idx_entity_tags_lookup ON entity_tags(entityType, entityId)');
        }
      },
    );
  }

  static Future<void> _createTables(Database db) async {
    AppLogger.info(_subsystem, 'Creating database tables');

    await db.execute('''
      CREATE TABLE folders (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        iconId TEXT NOT NULL,
        colorTag TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE reminders (
        id TEXT PRIMARY KEY,
        message TEXT NOT NULL,
        folderId TEXT,
        scheduledAt TEXT NOT NULL,
        repeatRule TEXT NOT NULL,
        soundId TEXT,
        vibrationEnabled INTEGER NOT NULL DEFAULT 1,
        isDone INTEGER NOT NULL DEFAULT 0,
        createdAt TEXT NOT NULL,
        photoPath TEXT,
        priority TEXT NOT NULL,
        repeatEndOccurrences INTEGER,
        repeatEndDate TEXT,
        alertStyle TEXT NOT NULL,
        snoozeCount INTEGER NOT NULL DEFAULT 0,
        calendarEventId TEXT,
        isPinned INTEGER NOT NULL DEFAULT 0,
        isArchived INTEGER NOT NULL DEFAULT 0,
        isAlarmSynced INTEGER NOT NULL DEFAULT 1,
        customRepeatInterval INTEGER,
        customRepeatDays TEXT,
        customRepeatType TEXT,
        FOREIGN KEY (folderId) REFERENCES folders(id) ON DELETE SET NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE reminder_occurrences (
        id TEXT PRIMARY KEY,
        reminderId TEXT NOT NULL,
        scheduledAt TEXT NOT NULL,
        completedAt TEXT,
        status TEXT NOT NULL,
        snoozeCount INTEGER NOT NULL DEFAULT 0,
        actionMetadata TEXT,
        FOREIGN KEY (reminderId) REFERENCES reminders(id) ON DELETE CASCADE
      )
    ''');

    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_occurrences_reminder ON reminder_occurrences(reminderId)',
    );
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_occurrences_scheduled ON reminder_occurrences(scheduledAt)',
    );

    await db.execute('''
      CREATE TABLE checklist_items (
        id TEXT PRIMARY KEY,
        reminderId TEXT NOT NULL,
        text TEXT NOT NULL,
        isDone INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (reminderId) REFERENCES reminders(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE reminder_history (
        id TEXT PRIMARY KEY,
        reminderId TEXT NOT NULL,
        action TEXT NOT NULL,
        timestamp TEXT NOT NULL,
        details TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE reminder_templates (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        message TEXT NOT NULL,
        priority TEXT NOT NULL,
        alertStyle TEXT NOT NULL,
        repeatRule TEXT NOT NULL,
        checklistJson TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE companion_profile (
        id INTEGER PRIMARY KEY CHECK (id = 1),
        name TEXT NOT NULL,
        lifetimeCompletions INTEGER NOT NULL DEFAULT 0,
        currentStreak INTEGER NOT NULL DEFAULT 0,
        streakFreezes INTEGER NOT NULL DEFAULT 2,
        equippedCosmetic TEXT,
        unlockedCosmeticsJson TEXT NOT NULL DEFAULT '[]',
        lastActiveDate TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE pending_actions (
        id TEXT PRIMARY KEY,
        action TEXT NOT NULL,
        reminderId TEXT NOT NULL,
        occurrenceTimestamp TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE todos (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        status TEXT NOT NULL,
        priority TEXT NOT NULL,
        folderId TEXT,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL,
        completedAt TEXT,
        dueAt TEXT,
        isPinned INTEGER NOT NULL DEFAULT 0,
        isArchived INTEGER NOT NULL DEFAULT 0,
        isDeleted INTEGER NOT NULL DEFAULT 0,
        parentTodoId TEXT,
        sortOrder INTEGER NOT NULL DEFAULT 0,
        tagsJson TEXT,
        recurrenceRule TEXT,
        reminderEnabled INTEGER NOT NULL DEFAULT 0,
        reminderAt TEXT,
        colorTag TEXT,
        sourceRecordId TEXT,
        metadataJson TEXT,
        FOREIGN KEY (folderId) REFERENCES folders(id) ON DELETE SET NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE todo_subtasks (
        id TEXT PRIMARY KEY,
        todoId TEXT NOT NULL,
        text TEXT NOT NULL,
        isDone INTEGER NOT NULL DEFAULT 0,
        sortOrder INTEGER NOT NULL DEFAULT 0,
        createdAt TEXT NOT NULL,
        completedAt TEXT,
        FOREIGN KEY (todoId) REFERENCES todos(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE records (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        recordType TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL,
        occurredAt TEXT,
        isPinned INTEGER NOT NULL DEFAULT 0,
        isArchived INTEGER NOT NULL DEFAULT 0,
        isDeleted INTEGER NOT NULL DEFAULT 0,
        folderId TEXT,
        colorTag TEXT,
        source TEXT,
        linkedReminderId TEXT,
        linkedTodoId TEXT,
        attachmentPath TEXT,
        metadataJson TEXT,
        FOREIGN KEY (folderId) REFERENCES folders(id) ON DELETE SET NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE tags (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL UNIQUE,
        colorTag TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE entity_tags (
        id TEXT PRIMARY KEY,
        tagId TEXT NOT NULL,
        entityType TEXT NOT NULL,
        entityId TEXT NOT NULL,
        FOREIGN KEY (tagId) REFERENCES tags(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('CREATE INDEX IF NOT EXISTS idx_todos_status ON todos(status)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_todos_dueAt ON todos(dueAt)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_todos_folder ON todos(folderId)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_subtasks_todo ON todo_subtasks(todoId)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_records_type ON records(recordType)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_records_folder ON records(folderId)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_entity_tags_lookup ON entity_tags(entityType, entityId)');
  }

  static Future<void> _seedInitialData(Database db) async {
    AppLogger.info(_subsystem, 'Seeding initial folders and templates');

    // Default folders
    for (final folder in AppConstants.defaultFolders) {
      await db.insert('folders', {
        'id': folder['id'],
        'name': folder['name'],
        'iconId': folder['iconId'],
        'colorTag': folder['colorTag'],
        'createdAt': DateTime.now().toIso8601String(),
      });
    }

    // Default companion profile
    await db.insert('companion_profile', {
      'id': 1,
      'name': 'Nudge',
      'lifetimeCompletions': 0,
      'currentStreak': 0,
      'streakFreezes': 2,
      'equippedCosmetic': null,
      'unlockedCosmeticsJson': '[]',
      'lastActiveDate': null,
    });

    // Default templates
    final defaultTemplates = [
      {
        'id': 'template_study',
        'title': 'Study Session',
        'message': 'Study deep work session',
        'priority': 'high',
        'alertStyle': 'alarm',
        'repeatRule': 'none',
        'checklistJson': '[{"id":"1","text":"Review notes","isDone":0},{"id":"2","text":"Solve practice problems","isDone":0},{"id":"3","text":"Summarize key concepts","isDone":0}]',
      },
      {
        'id': 'template_assignment',
        'title': 'Assignment Deadline',
        'message': 'Submit course assignment',
        'priority': 'high',
        'alertStyle': 'alarm',
        'repeatRule': 'none',
        'checklistJson': '[{"id":"1","text":"Proofread final draft","isDone":0},{"id":"2","text":"Export PDF","isDone":0},{"id":"3","text":"Submit to portal","isDone":0}]',
      },
      {
        'id': 'template_bills',
        'title': 'Bill Payment',
        'message': 'Pay monthly utility & internet bill',
        'priority': 'normal',
        'alertStyle': 'gentle',
        'repeatRule': 'monthly',
        'checklistJson': '[{"id":"1","text":"Check bill statement","isDone":0},{"id":"2","text":"Complete payment","isDone":0},{"id":"3","text":"Save receipt","isDone":0}]',
      },
      {
        'id': 'template_cleanup',
        'title': 'Weekly Cleanup',
        'message': 'Weekly home & desk organization',
        'priority': 'low',
        'alertStyle': 'gentle',
        'repeatRule': 'weekly',
        'checklistJson': '[{"id":"1","text":"Clear physical desk","isDone":0},{"id":"2","text":"Clean room","isDone":0},{"id":"3","text":"Empty trash","isDone":0}]',
      },
    ];

    for (final template in defaultTemplates) {
      await db.insert('reminder_templates', template);
    }
  }

  /// Reset all data destructively
  static Future<void> resetDatabase() async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('entity_tags');
      await txn.delete('tags');
      await txn.delete('records');
      await txn.delete('todo_subtasks');
      await txn.delete('todos');
      await txn.delete('checklist_items');
      await txn.delete('reminder_occurrences');
      await txn.delete('reminders');
      await txn.delete('folders');
      await txn.delete('reminder_history');
      await txn.delete('reminder_templates');
      await txn.delete('pending_actions');
      await txn.delete('companion_profile');
      await _seedInitialData(txn as Database);
    });
    AppLogger.info(_subsystem, 'Database reset complete and reseeded');
  }
}
