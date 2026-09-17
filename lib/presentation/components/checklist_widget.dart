import 'package:flutter/material.dart';
import '../../domain/entities/checklist_item.dart';
import '../theme/nudge_theme.dart';

class ChecklistWidget extends StatefulWidget {
  final List<ChecklistItem> items;
  final ValueChanged<List<ChecklistItem>> onChanged;

  const ChecklistWidget({
    super.key,
    required this.items,
    required this.onChanged,
  });

  @override
  State<ChecklistWidget> createState() => _ChecklistWidgetState();
}

class _ChecklistWidgetState extends State<ChecklistWidget> {
  final TextEditingController _itemController = TextEditingController();

  void _addItem() {
    final text = _itemController.text.trim();
    if (text.isEmpty) return;

    final updated = List<ChecklistItem>.from(widget.items)..add(ChecklistItem.create(text: text));
    widget.onChanged(updated);
    _itemController.clear();
  }

  void _toggleItem(int index) {
    final updated = List<ChecklistItem>.from(widget.items);
    updated[index] = updated[index].copyWith(isDone: !updated[index].isDone);
    widget.onChanged(updated);
  }

  void _removeItem(int index) {
    final updated = List<ChecklistItem>.from(widget.items)..removeAt(index);
    widget.onChanged(updated);
  }

  @override
  void dispose() {
    _itemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Checklist (${widget.items.length})',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? NudgeTheme.onPrimaryContainer : NudgeTheme.secondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Item list
        ...widget.items.asMap().entries.map((entry) {
          final idx = entry.key;
          final item = entry.value;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: [
                Checkbox(
                  value: item.isDone,
                  onChanged: (_) => _toggleItem(idx),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                Expanded(
                  child: Text(
                    item.text,
                    style: TextStyle(
                      fontSize: 14,
                      decoration: item.isDone ? TextDecoration.lineThrough : null,
                      color: item.isDone ? Colors.grey : (isDark ? NudgeTheme.onBgDark : NudgeTheme.onBgLight),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  onPressed: () => _removeItem(idx),
                  tooltip: 'Remove item',
                ),
              ],
            ),
          );
        }),
        // Add new item input
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _itemController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Add checklist step...',
                  hintStyle: const TextStyle(fontSize: 13),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(NudgeTheme.radiusS),
                  ),
                ),
                onSubmitted: (_) => _addItem(),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filledTonal(
              icon: const Icon(Icons.add),
              onPressed: _addItem,
              tooltip: 'Add item',
            ),
          ],
        ),
      ],
    );
  }
}
