import 'app_role.dart';

class UserInfoDto {
  final int id;
  final String? email;
  final AppRole role;
  final int? companyId;
  final double trueCoinBalance;

  UserInfoDto({
    required this.id,
    this.email,
    required this.role,
    this.companyId,
    required this.trueCoinBalance,
  });

  factory UserInfoDto.fromJson(Map<String, dynamic> json) {
    return UserInfoDto(
      id: json['id'],
      email: json['email'],
      role: AppRole.values[json['role']],
      companyId: json['companyId'],
      trueCoinBalance: (json['trueCoinBalance'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'role': role.index,
    'companyId': companyId,
    'trueCoinBalance': trueCoinBalance,
  };
}
