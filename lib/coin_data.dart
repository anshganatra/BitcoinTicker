import 'dart:convert';
//import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

List<double> btchistory = [
  6640, 6846, 6843, 7807, 7797, 7679, 7570, 7550, 7434, 7121, 6879, 6880, 7187, 7261, 7092, 7117, 9007, 8913, 8896, 8984, 8869, 8673, 8798, 8610, 8756, 9591, 9841, 9936, 9262,
];

List<double> ltchistory = [
  41.74,
42.36,
47.26,
47.84,
47.31,
46.02,
46.77,
47.45,
48.24,
49.46,
47.77,
46.71,
49.15,
46.09,
44.74,
44.68,
44.72,
44.82,
42.99,
41.88,
40.99,
40.81,
42.67,
44.35,
42.75,
42.68,
39.64,
41.08,
41.22,
42.5,
];

List<double> ethhistory =[
  185.88,
188.63,
211.55,
213.14,
212.2,
203.91,
206.48,
208.01,
210.89,
215.35,
214.23,
207.9,
216.91,
198.47,
197.27,
197.48,
195.41,
189.21,
185.22,
182.62,
172.67,
172.02,
181.48,
186.86,
171.62,
172.28,
153.2,
157.57,
156.36,
160.72,
172.67,
172.02,
181.48,
186.86,
188.63,
211.55,
213.14,
212.2,
203.91,
206.48,
208.01,
210.89,
215.35,
];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

const coinAPIURL = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/';
const apiKey = 'OTUxMTk1Njk3NWI5NDgzYzhkNDFiYjM5MDgxMWE0YmM';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    Map<String, String> cryptoWeeklyAveragePrices = {};
    Map<String, String> cryptoWeeklyPercentChange = {};
    //print(bitcoinhistory);
    for (String crypto in cryptoList) {
      String requestURL = '$coinAPIURL$crypto$selectedCurrency';
      print(requestURL);
      http.Response response = await http.get(
        requestURL,
        headers: {'x-ba-key': '$apiKey'},
      );
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);

        print(decodedData);

        double price = decodedData['last'];
        double weeklyAverage = decodedData['averages']['week'];
        double percentWeeklyChange = decodedData['changes']['percent']['week'];

        cryptoPrices[crypto] = price.toStringAsFixed(0);
        cryptoPrices[crypto + '_AVERAGE'] = weeklyAverage.toStringAsFixed(0);
        cryptoPrices[crypto + '_CHANGE'] =
            percentWeeklyChange.toStringAsFixed(1);

        // print(weeklyAverage);
        // print(percentWeeklyChange);

      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    // print(cryptoPrices);
    // print(cryptoWeeklyAveragePrices);
    // print(cryptoWeeklyPercentChange);

    return cryptoPrices;
  }
}
