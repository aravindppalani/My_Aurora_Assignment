import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String url = 'https://november7-730026606190.europe-west1.run.app/image';

  Future<String> fetchImage() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['url'];
    } else {
      throw Exception('Failed to load image');
    }
  }
}