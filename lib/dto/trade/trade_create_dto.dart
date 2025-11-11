// lib/dto/trade/trade_create_dto.dart
class TradeCreateDto {
  final int targetListingId;
  final int? offeredListingId;
  final String? message;
  final double? offeredTrueCoins;
  final double? requestedTrueCoins;

  TradeCreateDto({
    required this.targetListingId,
    this.offeredListingId,
    this.message,
    this.offeredTrueCoins,
    this.requestedTrueCoins,
  });

  factory TradeCreateDto.fromJson(Map<String, dynamic> json) {
    return TradeCreateDto(
      targetListingId: json['targetListingId'],
      offeredListingId: json['offeredListingId'],
      message: json['message'],
      offeredTrueCoins: json['offeredTrueCoins'] != null
          ? (json['offeredTrueCoins'] as num).toDouble()
          : null,
      requestedTrueCoins: json['requestedTrueCoins'] != null
          ? (json['requestedTrueCoins'] as num).toDouble()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'targetListingId': targetListingId,
    'offeredListingId': offeredListingId,
    'message': message,
    'offeredTrueCoins': offeredTrueCoins,
    'requestedTrueCoins': requestedTrueCoins,
  };
}
