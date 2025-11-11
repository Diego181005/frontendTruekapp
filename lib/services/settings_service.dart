import 'package:dio/dio.dart';
import 'api_client.dart';
import '../dto/settings/setting_dto.dart';

class SettingsService {
  final Dio _dio = ApiClient().dio;

  Future<List<SettingDto>> getAllSettings() async {
    final response = await _dio.get('/Settings');
    return (response.data as List).map((e) => SettingDto.fromJson(e)).toList();
  }

  Future<void> createOrUpdateSetting(SettingDto dto) async {
    await _dio.post('/Settings', data: dto.toJson());
  }

  Future<SettingDto> getSetting(String key) async {
    final response = await _dio.get('/Settings/$key');
    return SettingDto.fromJson(response.data);
  }

  Future<void> deleteSetting(String key) async {
    await _dio.delete('/Settings/$key');
  }
}
