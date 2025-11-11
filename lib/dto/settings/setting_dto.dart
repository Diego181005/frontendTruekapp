// lib/dto/settings/setting_dto.dart
class SettingDto {
  final String? key;
  final String? value;

  SettingDto({this.key, this.value});

  factory SettingDto.fromJson(Map<String, dynamic> json) {
    return SettingDto(key: json['key'], value: json['value']);
  }

  Map<String, dynamic> toJson() => {'key': key, 'value': value};
}
