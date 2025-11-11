import 'package:dio/dio.dart';
import 'api_client.dart';
import '../dto/review/user_review_create_dto.dart';
import '../dto/review/user_review_dto.dart';

class ReviewService {
  final Dio _dio = ApiClient().dio;

  Future<void> createReview(UserReviewCreateDto dto) async {
    await _dio.post('/Reviews', data: dto.toJson());
  }

  Future<List<UserReviewDto>> getUserReviews(int userId) async {
    final response = await _dio.get('/Reviews/user/$userId');
    return (response.data as List)
        .map((e) => UserReviewDto.fromJson(e))
        .toList();
  }
}
