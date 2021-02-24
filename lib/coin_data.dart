import 'Services/network_helper.dart';

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

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  //get data from API
  Future getDataFromAPI(currency) async {
    var decodedData;
    currency = currency.toString();
    NetworkHelper networking = NetworkHelper(
        URL:
            "https://rest.coinapi.io/v1/exchangerate/BTC/$currency?apikey=8C1F225D-3E48-40CF-96FE-88AD0604B41D");
    decodedData = await networking.getJesonData();
    print(decodedData);
    return decodedData;
  }
}
