// lib/providers/trade_provider.dart
import 'package:flutter/material.dart';
import '../dto/trade/trade_dto.dart';
import '../dto/trade/trade_create_dto.dart';
// ignore: unused_import
import '../dto/trade/trade_update_dto.dart';
import '../dto/trade/trade_update_status_dto.dart';
import '../dto/trade/trade_message_create_dto.dart';
import '../services/trade_service.dart';

class TradeProvider extends ChangeNotifier {
  final TradeService _service = TradeService();

  List<TradeDto> myTrades = [];
  bool isLoading = false;

  Future<void> fetchMyTrades() async {
    isLoading = true;
    notifyListeners();

    try {
      myTrades = await _service.getMyTrades();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createTrade(TradeCreateDto dto) async {
    await _service.createTrade(dto);
    await fetchMyTrades();
  }

  Future<void> acceptTrade(int id) async {
    await _service.acceptTrade(id);
    await fetchMyTrades();
  }

  Future<void> updateTradeStatus(int id, TradeUpdateStatusDto dto) async {
    await _service.updateTradeStatus(id, dto);
    await fetchMyTrades();
  }

  Future<void> sendMessage(int tradeId, TradeMessageCreateDto dto) async {
    await _service.sendMessage(tradeId, dto);
  }
}
