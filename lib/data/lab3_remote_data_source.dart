import 'dart:convert';

import 'package:http/http.dart' as http;

class Lab3RemoteDataSource {
  Lab3RemoteDataSource({http.Client? client}) : _client = client ?? http.Client();

  static final _feedUri = Uri.https(
    'test-api-jlbn.onrender.com',
    '/lab2026/v3/feed',
  );
  static final _detailsUri = Uri.https(
    'test-api-jlbn.onrender.com',
    '/lab2026/v3/feed/details',
  );

  final http.Client _client;

  Future<Map<String, dynamic>> getFeed() => _getJson(_feedUri);
  Future<Map<String, dynamic>> getDetails() => _getJson(_detailsUri);

  Future<Map<String, dynamic>> _getJson(Uri uri) async {
    final response = await _client
        .get(uri, headers: const {'Accept': 'application/json'})
        .timeout(const Duration(seconds: 20));
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Serverul a răspuns cu codul ${response.statusCode}.');
    }
    final decoded = jsonDecode(utf8.decode(response.bodyBytes));
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Răspuns JSON invalid de la server.');
    }
    return decoded;
  }
}
