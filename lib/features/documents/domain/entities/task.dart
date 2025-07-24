class Task {
  const Task({
    required this.title,
    required this.description,
    this.id,
    this.isChecked = false,
  });

  factory Task.fromMap(Map<String, dynamic> map) => Task(
        id: map['id'] as int?,
        title: map['title'] as String,
        description: map['description'] as String,
        isChecked: map['isChecked'] == 1,
      );
  final int? id;
  final String title;
  final String description;
  final bool isChecked;

  Task copyWith({
    int? id,
    String? title,
    String? description,
    bool? isChecked,
  }) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        isChecked: isChecked ?? this.isChecked,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'isChecked': isChecked ? 1 : 0,
      };
}
