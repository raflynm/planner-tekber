class ToDo {
  final String title;
  final String description;
  final String priority;
  DateTime? date;  // Nullable DateTime field
  bool isCompleted;

  ToDo({
    required this.title,
    required this.description,
    required this.priority,
    this.date,
    this.isCompleted = false,
  });
}
