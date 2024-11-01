import '../models/earnings.dart';
import 'api_client.dart';
import 'dart:convert';

class EarningsApi {
  static Future<List<Earnings>> fetchEarnings(String ticker) async {
    final response = await ApiClient.get('earningscalendar?ticker=$ticker');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((e) => Earnings.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load earnings data');
    }
  }

  static Future<String> fetchTranscript(String ticker, int year, int quarter) async {
    final response = await ApiClient.get('earningstranscript?ticker=$ticker&year=$year&quarter=$quarter');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['transcript'] as String;
    } else {
      throw Exception('Failed to load transcript');
    }
  }
}
