import 'user.dart';

class Poll {
  Poll({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
  });
  int id;
  String name;
  String description;
  DateTime date;
  Poll.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as int,
          name: json['name'] as String,
          description: json['description'] as String,
          date: json['date'] as DateTime,
        );
}
