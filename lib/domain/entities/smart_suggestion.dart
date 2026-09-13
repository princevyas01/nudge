class SmartSuggestion {
  final String id;
  final String title;
  final String description;
  final String reminderId;
  final DateTime suggestedTime;
  final String actionType;

  const SmartSuggestion({
    required this.id,
    required this.title,
    required this.description,
    required this.reminderId,
    required this.suggestedTime,
    required this.actionType,
  });
}
