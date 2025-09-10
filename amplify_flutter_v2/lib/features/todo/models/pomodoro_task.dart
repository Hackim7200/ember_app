class PomodoroTask {
  final String id;
  final String title;
  final bool isActive;
  final int timeElapsed; // in seconds
  final bool isCompleted;

  const PomodoroTask({
    required this.id,
    required this.title,
    this.isActive = false,
    this.timeElapsed = 0,
    this.isCompleted = false,
  });

  PomodoroTask copyWith({
    String? id,
    String? title,
    bool? isActive,
    int? timeElapsed,
    bool? isCompleted,
  }) {
    return PomodoroTask(
      id: id ?? this.id,
      title: title ?? this.title,
      isActive: isActive ?? this.isActive,
      timeElapsed: timeElapsed ?? this.timeElapsed,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PomodoroTask && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
