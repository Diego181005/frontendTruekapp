import 'package:dio/dio.dart';
import 'api_client.dart';
import '../dto/trade/trade_create_dto.dart';
import '../dto/trade/trade_dto.dart';
import '../dto/trade/trade_update_dto.dart';
import '../dto/trade/trade_update_status_dto.dart';
import '../dto/trade/trade_message_create_dto.dart';

class TradeService {
  final Dio _dio = ApiClient().dio;

  Future<void> createTrade(TradeCreateDto dto) async {
    await _dio.post('/Trades', data: dto.toJson());
  }

  Future<void> updateTrade(int id, TradeUpdateDto dto) async {
    await _dio.put('/Trades/$id', data: dto.toJson());
  }

  Future<void> updateTradeStatus(int id, TradeUpdateStatusDto dto) async {
    await _dio.patch('/Trades/$id/status', data: dto.toJson());
  }

  Future<void> acceptTrade(int id) async {
    await _dio.patch('/Trades/$id/accept');
  }

  Future<List<TradeDto>> getMyTrades() async {
    final response = await _dio.get('/Trades/my');
    return (response.data as List).map((e) => TradeDto.fromJson(e)).toList();
  }

  Future<void> sendMessage(int tradeId, TradeMessageCreateDto dto) async {
    await _dio.post('/Trades/$tradeId/messages', data: dto.toJson());
  }
}
