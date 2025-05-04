class DeskEntity {
  final String id;
  final String name;

  DeskEntity({required this.id, required this.name});

  factory DeskEntity.fromJson(Map<String, dynamic> json) =>
      DeskEntity(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  DeskEntity copyWith({String? id, String? name, bool? status}) =>
      DeskEntity(id: id ?? this.id, name: name ?? this.name);
}
