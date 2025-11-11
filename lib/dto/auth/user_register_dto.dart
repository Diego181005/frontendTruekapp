import 'app_role.dart';

class UserRegisterDto {
  final String? email;
  final String? password;
  final String? phone;
  final AppRole role;
  final int? companyId;

  UserRegisterDto({
    this.email,
    this.password,
    this.phone,
    required this.role,
    this.companyId,
  });

  factory UserRegisterDto.fromJson(Map<String, dynamic> json) {
    return UserRegisterDto(
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      role: AppRole.values[json['role']],
      companyId: json['companyId'],
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'phone': phone,
    'role': role.index,
    'companyId': companyId,
  };
}
