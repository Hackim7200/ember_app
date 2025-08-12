// Model class
class Task {
  String title;
  bool isCompleted;

  Task({required this.title, required this.isCompleted});

  // Override equality for better state management
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          isCompleted == other.isCompleted;

  @override
  int get hashCode => title.hashCode ^ isCompleted.hashCode;
}
