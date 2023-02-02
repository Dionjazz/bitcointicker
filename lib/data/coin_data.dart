import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'USD',
  'EUR',
  'RUB',
  'AUD',
  'BRL',
  'CAD',
  'GBP',
  'JPY',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

late String currency1;
const kApikey = 'A14B4DF9-48AE-4704-B70F-D85C76043BC9';
const kUrl = 'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=$kApikey';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    var knewURL =
        'https://rest.coinapi.io/v1/exchangerate/BTC/$selectedCurrency?apikey=$kApikey';
    var response = await http.get(Uri.parse(knewURL));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      currency1 = jsonResponse['asset_id_quote'];

      return jsonResponse['rate'];
    } else {
      return response.statusCode.toString();
    }
  }
}
