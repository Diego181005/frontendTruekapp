// lib/dto/review/user_review_dto.dart
class UserReviewDto {
  final int id;
  final int fromUserId;
  final int toUserId;
  final int rating;
  final String? comment;
  final DateTime createdAt;

  UserReviewDto({
    required this.id,
    required this.fromUserId,
    required this.toUserId,
    required this.rating,
    this.comment,
    required this.createdAt,
  });

  factory UserReviewDto.fromJson(Map<String, dynamic> json) {
    return UserReviewDto(
      id: json['id'],
      fromUserId: json['fromUserId'],
      toUserId: json['toUserId'],
      rating: json['rating'],
      comment: json['comment'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'fromUserId': fromUserId,
    'toUserId': toUserId,
    'rating': rating,
    'comment': comment,
    'createdAt': createdAt.toIso8601String(),
  };
}
