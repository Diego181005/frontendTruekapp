// lib/dto/trade/trade_update_status_dto.dart
import 'trade_status.dart';

class TradeUpdateStatusDto {
  final TradeStatus status;

  TradeUpdateStatusDto({required this.status});

  factory TradeUpdateStatusDto.fromJson(Map<String, dynamic> json) {
    return TradeUpdateStatusDto(status: TradeStatus.values[json['status']]);
  }

  Map<String, dynamic> toJson() => {'status': status.index};
}
