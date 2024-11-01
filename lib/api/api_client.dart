import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = "https://api.api-ninjas.com/v1/";

  static Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return await http.get(url, headers: {
      'X-Api-Key': 'YOUR_API_KEY',
    });
  }
}
