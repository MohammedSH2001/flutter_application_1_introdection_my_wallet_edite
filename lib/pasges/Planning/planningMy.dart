import 'dart:convert';
import 'package:http/http.dart' as http;

class MarketDataService {
  final String apiKey;

  MarketDataService(this.apiKey);

  Future<Map<String, dynamic>> fetchExchangeRate(String fromCurrency, String toCurrency) async {
    final url =
        'https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=$fromCurrency&to_currency=$toCurrency&apikey=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load exchange rate');
    }
  }
}