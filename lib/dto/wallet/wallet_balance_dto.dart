// lib/dto/wallet/wallet_balance_dto.dart
import 'wallet_entry_dto.dart';

class WalletBalanceDto {
  final double balance;
  final List<WalletEntryDto>? entries;

  WalletBalanceDto({required this.balance, this.entries});

  factory WalletBalanceDto.fromJson(Map<String, dynamic> json) {
    return WalletBalanceDto(
      balance: (json['balance'] as num).toDouble(),
      entries: json['entries'] != null
          ? List<WalletEntryDto>.from(
              json['entries'].map((e) => WalletEntryDto.fromJson(e)),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'balance': balance,
    'entries': entries?.map((e) => e.toJson()).toList(),
  };
}
