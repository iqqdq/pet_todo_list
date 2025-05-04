class TaskEntity {
  final String id;
  final String name;
  bool status;

  TaskEntity({required this.id, required this.name, this.status = false});

  factory TaskEntity.fromJson(Map<String, dynamic> json) =>
      TaskEntity(id: json['id'], name: json['name'], status: json['status']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'status': status};

  TaskEntity copyWith({String? id, String? name, bool? status}) => TaskEntity(
    id: id ?? this.id,
    name: name ?? this.name,
    status: status ?? this.status,
  );
}
