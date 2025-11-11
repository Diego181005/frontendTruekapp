// lib/providers/auth_provider.dart
import 'package:flutter/material.dart';
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
      user = await _service.getMe();
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
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
    notifyListeners();
  }
}
