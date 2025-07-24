class Note {
  const Note({required this.title, required this.description, this.id});
  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json['id'] as int?,
        title: json['title'] as String,
        description: json['description'] as String,
      );
  final int? id;
  final String title;
  final String description;

  Map<String, dynamic> toJson() =>
      {'id': id, 'title': title, 'description': description};
}
