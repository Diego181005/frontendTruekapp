import 'package:dio/dio.dart';
import 'api_client.dart';
import '../dto/auth/user_login_dto.dart';
import '../dto/auth/user_register_dto.dart';
import '../dto/auth/token_dto.dart';
import '../dto/auth/user_info_dto.dart';

class AuthService {
  final Dio _dio = ApiClient().dio;

  Future<TokenDto> login(UserLoginDto dto) async {
    final response = await _dio.post('/Auth/login', data: dto.toJson());
    return TokenDto.fromJson(response.data);
  }

  Future<void> register(UserRegisterDto dto) async {
    await _dio.post('/Auth/register', data: dto.toJson());
  }

  Future<UserInfoDto> getMe() async {
    final response = await _dio.get('/Auth/me');
    return UserInfoDto.fromJson(response.data);
  }
}
