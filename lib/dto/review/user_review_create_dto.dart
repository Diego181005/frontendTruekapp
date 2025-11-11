// lib/dto/review/user_review_create_dto.dart
class UserReviewCreateDto {
  final int toUserId;
  final int tradeId;
  final int? rating; // 1-5
  final String? comment;

  UserReviewCreateDto({
    required this.toUserId,
    required this.tradeId,
    this.rating,
    this.comment,
  });

  factory UserReviewCreateDto.fromJson(Map<String, dynamic> json) {
    return UserReviewCreateDto(
      toUserId: json['toUserId'],
      tradeId: json['tradeId'],
      rating: json['rating'],
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() => {
    'toUserId': toUserId,
    'tradeId': tradeId,
    'rating': rating,
    'comment': comment,
  };
}
