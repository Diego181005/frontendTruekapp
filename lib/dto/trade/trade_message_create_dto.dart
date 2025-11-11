// lib/dto/trade/trade_message_create_dto.dart
class TradeMessageCreateDto {
  final String message;

  TradeMessageCreateDto({required this.message});

  factory TradeMessageCreateDto.fromJson(Map<String, dynamic> json) {
    return TradeMessageCreateDto(message: json['message']);
  }

  Map<String, dynamic> toJson() => {'message': message};
}
