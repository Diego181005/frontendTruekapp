// lib/dto/wallet/wallet_entry_dto.dart
import 'wallet_entry_type.dart';

class WalletEntryDto {
  final int id;
  final double amount;
  final WalletEntryType type;
  final DateTime createdAt;

  WalletEntryDto({
    required this.id,
    required this.amount,
    required this.type,
    required this.createdAt,
  });

  factory WalletEntryDto.fromJson(Map<String, dynamic> json) {
    return WalletEntryDto(
      id: json['id'],
      amount: (json['amount'] as num).toDouble(),
      type: WalletEntryType.values[json['type']],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'amount': amount,
    'type': type.index,
    'createdAt': createdAt.toIso8601String(),
  };
}
