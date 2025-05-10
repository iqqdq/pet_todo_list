class UserEntity {
  final String email;
  final String name;
  final String password;
  final String? token;

  UserEntity({
    required this.email,
    required this.name,
    required this.password,
    required this.token,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
    email: json['email'],
    name: json['name'],
    password: json['password'],
    token: json['token'],
  );

  Map<String, dynamic> toJson() => {
    'email': email,
    'name': name,
    'password': password,
    'token': token,
  };

  UserEntity copyWith({String? token}) => UserEntity(
    email: email,
    name: name,
    password: password,
    token: token ?? this.token,
  );
}
