class Task {
  int? id;
  String title;
  String description;
  bool isChecked;

  Task({
    this.id,
    required this.title,
    required this.description,
    this.isChecked = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isChecked': isChecked ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isChecked: map['isChecked'] == 1,
    );
  }
}
