// lib/providers/settings_provider.dart
import 'package:flutter/material.dart';
import '../dto/settings/setting_dto.dart';
import '../services/settings_service.dart';

class SettingsProvider extends ChangeNotifier {
  final SettingsService _service = SettingsService();

  List<SettingDto> settings = [];
  bool isLoading = false;

  // Obtener todas las configuraciones
  Future<void> fetchAllSettings() async {
    isLoading = true;
    notifyListeners();

    try {
      settings = await _service.getAllSettings();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Obtener una configuración por key
  Future<SettingDto?> fetchSetting(String key) async {
    isLoading = true;
    notifyListeners();

    try {
      final setting = await _service.getSetting(key);
      return setting;
    } catch (e) {
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Crear o actualizar una configuración
  Future<void> createOrUpdateSetting(SettingDto dto) async {
    await _service.createOrUpdateSetting(dto);
    await fetchAllSettings(); // refrescar lista
  }

  // Eliminar una configuración
  Future<void> deleteSetting(String key) async {
    await _service.deleteSetting(key);
    await fetchAllSettings(); // refrescar lista
  }
}
