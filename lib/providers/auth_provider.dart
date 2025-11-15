// lib/providers/auth_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dto/auth/user_info_dto.dart';
import '../dto/auth/user_login_dto.dart';
import '../dto/auth/user_register_dto.dart';
import '../services/auth_service.dart';
import '../services/api_client.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service = AuthService();

  UserInfoDto? user;
  bool isLoading = false;
  bool get isLoggedIn => user != null;

  // Login
  Future<void> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      final tokenDto = await _service.login(
        UserLoginDto(email: email, password: password),
      );

      // ✅ Null-safety: verificar que token no sea null
      if (tokenDto.token == null) {
        throw Exception("Token no recibido desde el backend");
      }

      ApiClient().setToken(tokenDto.token!); // ! seguro porque ya verificamos

      // Persistir token localmente
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', tokenDto.token!);
      } catch (_) {
        // No crítico: si falla el guardado, continuamos sin bloquear login
      }

      // Obtener información del usuario
      user = await _service.getMe();
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Intenta cargar token almacenado y obtener info del usuario.
  /// Devuelve true si logró restaurar sesión.
  Future<bool> tryAutoLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) return false;

      ApiClient().setToken(token);
      user = await _service.getMe();
      notifyListeners();
      return true;
    } catch (_) {
      // Si algo falla, limpiar token local
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('auth_token');
      } catch (_) {}
      return false;
    }
  }

  // Register
  Future<void> register(UserRegisterDto dto) async {
    isLoading = true;
    notifyListeners();

    try {
      await _service.register(dto);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Logout
  void logout() {
    ApiClient().clearToken();
    user = null;
    // Limpiar token persistente
    SharedPreferences.getInstance().then((prefs) => prefs.remove('auth_token'));
    notifyListeners();
  }
}
