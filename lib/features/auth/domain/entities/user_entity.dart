class UserEntity {
  final String id;
  final String email;
  final String name;
  final String password;

  UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.password,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
    id: json['id'],
    email: json['email'],
    name: json['name'],
    password: json['password'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
    'password': password,
  };
}
