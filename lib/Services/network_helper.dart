import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper({this.URL});
  final URL;

  Future getJesonData() async {
    http.Response response = await http.get(URL);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    print(response.statusCode);
  }
}
