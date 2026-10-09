import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const baseUrl = 'https://rickandmortyapi.com/api';

  Future<Map<String, dynamic>> get(String endpoint, int page) async {
    final res = await http.get(Uri.parse('$baseUrl/$endpoint?page=$page'));
    if (res.statusCode != 200) throw Exception('HTTP ${res.statusCode}');
    return jsonDecode(res.body) as Map<String, dynamic>;
  }
}
