import 'dart:convert';
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

List<PlotData> btcgraphy = [
  PlotData(DateTime.parse('2020-05-15'), 8817.45),
  PlotData(DateTime.parse('2020-05-14'), 8937.09),
  PlotData(DateTime.parse('2020-05-13'), 8406.00),
  PlotData(DateTime.parse('2020-05-12'), 8126.76),
  PlotData(DateTime.parse('2020-05-11'), 8080.93),
  PlotData(DateTime.parse('2020-05-10'), 8054.69),
  PlotData(DateTime.parse('2020-05-09'), 8932.89),
  PlotData(DateTime.parse('2020-05-08'), 9153.24),
  PlotData(DateTime.parse('2020-05-07'), 8898.07),
  PlotData(DateTime.parse('2020-05-06'), 8524.98),
  PlotData(DateTime.parse('2020-05-05'), 8239.45),
  PlotData(DateTime.parse('2020-05-04'), 8027.48),
  PlotData(DateTime.parse('2020-05-03'), 8168.97),
  PlotData(DateTime.parse('2020-05-02'), 8098.77),
  PlotData(DateTime.parse('2020-05-01'), 8046.38),
  PlotData(DateTime.parse('2020-04-30'), 8219.29),
  PlotData(DateTime.parse('2020-04-29'), 7734.57),
  PlotData(DateTime.parse('2020-04-28'), 7142.88),
  PlotData(DateTime.parse('2020-04-27'), 7126.31),
  PlotData(DateTime.parse('2020-04-26'), 7053.83),
  PlotData(DateTime.parse('2020-04-25'), 6996.20),
  PlotData(DateTime.parse('2020-04-24'), 6982.71),
  PlotData(DateTime.parse('2020-04-23'), 6816.64),
  PlotData(DateTime.parse('2020-04-22'), 6490.33),
  PlotData(DateTime.parse('2020-04-21'), 6339.39),
  PlotData(DateTime.parse('2020-04-20'), 6450.76),
  PlotData(DateTime.parse('2020-04-19'), 6592.64),
  PlotData(DateTime.parse('2020-04-18'), 6621.38),
  PlotData(DateTime.parse('2020-04-17'), 6523.37),
  PlotData(DateTime.parse('2020-04-16'), 6402.04),
  PlotData(DateTime.parse('2020-04-15'), 6216.98),
];

List<PlotData> ethgraphy = [
PlotData(DateTime.parse('2020-05-14'), 198.89),
PlotData(DateTime.parse('2020-05-13'), 189.37),
PlotData(DateTime.parse('2020-05-12'), 185.88),
PlotData(DateTime.parse('2020-05-11'), 188.63),
PlotData(DateTime.parse('2020-05-10'), 211.55),
PlotData(DateTime.parse('2020-05-09'), 213.14),
PlotData(DateTime.parse('2020-05-08'), 212.20),
PlotData(DateTime.parse('2020-05-07'), 203.91),
PlotData(DateTime.parse('2020-05-06'), 206.48),
PlotData(DateTime.parse('2020-05-05'), 208.01),
PlotData(DateTime.parse('2020-05-04'), 210.89),
PlotData(DateTime.parse('2020-05-03'), 215.35),
PlotData(DateTime.parse('2020-05-02'), 214.23),
PlotData(DateTime.parse('2020-05-01'), 207.90),
PlotData(DateTime.parse('2020-04-30'), 216.91),
PlotData(DateTime.parse('2020-04-29'), 198.47),
PlotData(DateTime.parse('2020-04-28'), 197.27),
PlotData(DateTime.parse('2020-04-27'), 197.48),
PlotData(DateTime.parse('2020-04-26'), 195.41),
PlotData(DateTime.parse('2020-04-25'), 189.21),
PlotData(DateTime.parse('2020-04-24'), 185.22),
PlotData(DateTime.parse('2020-04-23'), 182.62),
PlotData(DateTime.parse('2020-04-22'), 172.67),
PlotData(DateTime.parse('2020-04-21'), 172.02),
PlotData(DateTime.parse('2020-04-20'), 181.48),
PlotData(DateTime.parse('2020-04-19'), 186.86),
PlotData(DateTime.parse('2020-04-18'), 171.62),
PlotData(DateTime.parse('2020-04-17'), 172.28),
PlotData(DateTime.parse('2020-04-16'), 153.20),
PlotData(DateTime.parse('2020-04-15'), 157.57),
];

List<PlotData> ltcgraphy = [
PlotData(DateTime.parse('2020-05-14'), 41.74),
PlotData(DateTime.parse('2020-05-13'), 42.36),
PlotData(DateTime.parse('2020-05-12'), 47.26),
PlotData(DateTime.parse('2020-05-11'), 47.84),
PlotData(DateTime.parse('2020-05-10'), 47.31),
PlotData(DateTime.parse('2020-05-09'), 46.02),
PlotData(DateTime.parse('2020-05-08'), 46.77),
PlotData(DateTime.parse('2020-05-07'), 47.45),
PlotData(DateTime.parse('2020-05-06'), 48.24),
PlotData(DateTime.parse('2020-05-05'), 49.46),
PlotData(DateTime.parse('2020-05-04'), 47.77),
PlotData(DateTime.parse('2020-05-03'), 46.71),
PlotData(DateTime.parse('2020-05-02'), 49.15),
PlotData(DateTime.parse('2020-05-01'), 46.09),
PlotData(DateTime.parse('2020-04-30'), 44.74),
PlotData(DateTime.parse('2020-04-29'), 44.68),
PlotData(DateTime.parse('2020-04-28'), 44.72),
PlotData(DateTime.parse('2020-04-27'), 44.82),
PlotData(DateTime.parse('2020-04-26'), 42.99),
PlotData(DateTime.parse('2020-04-25'), 41.88),
PlotData(DateTime.parse('2020-04-24'), 40.99),
PlotData(DateTime.parse('2020-04-23'), 40.81),
PlotData(DateTime.parse('2020-04-22'), 42.67),
PlotData(DateTime.parse('2020-04-21'), 44.35),
PlotData(DateTime.parse('2020-04-20'), 42.75),
PlotData(DateTime.parse('2020-04-19'), 42.68),
PlotData(DateTime.parse('2020-04-18'), 39.64),
PlotData(DateTime.parse('2020-04-17'), 41.08),
PlotData(DateTime.parse('2020-04-16'), 41.22),
PlotData(DateTime.parse('2020-04-15'), 42.52),
];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

const coinAPIURL = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/';
const apiKey = 'OTUxMTk1Njk3NWI5NDgzYzhkNDFiYjM5MDgxMWE0YmM';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestURL = '$coinAPIURL$crypto$selectedCurrency';
      // print(requestURL);
      http.Response response = await http.get(
        requestURL,
        headers: {'x-ba-key': '$apiKey'},
      );
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);

        // print(decodedData);

        double price = decodedData['last'];
        double weeklyAverage = decodedData['averages']['week'];
        double percentWeeklyChange = decodedData['changes']['percent']['week'];
        double percentDaily = decodedData['changes']['percent']['day'];
        double percentMonthly = decodedData['changes']['percent']['month'];
        double openDaily = decodedData['open']['day'];
        double high = decodedData['high'];
        double low = decodedData['low'];
        String currency = decodedData['display_symbol'];
        currency = currency.substring(currency.indexOf('-')+1);

        cryptoPrices[crypto] = price.toStringAsFixed(0);
        cryptoPrices[crypto + '_AVERAGE'] = weeklyAverage.toStringAsFixed(2);
        cryptoPrices[crypto + '_CHANGE'] =
            percentWeeklyChange.toStringAsFixed(2);
        cryptoPrices[crypto + '_PERCENT_DAILY'] = percentDaily.toStringAsFixed(2);
        cryptoPrices[crypto + '_PERCENT_MONTHLY'] = percentMonthly.toStringAsFixed(2);
        cryptoPrices[crypto + '_OPEN'] = openDaily.toStringAsFixed(2);
        cryptoPrices[crypto + '_DAY_HIGH'] = high.toStringAsFixed(2);
        cryptoPrices[crypto + '_DAY_LOW'] = low.toStringAsFixed(2);
        cryptoPrices['currency'] = currency;
      } else {
        // print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}

class PlotData {
  final DateTime date;
  final double data;

  PlotData(this.date, this.data);
}