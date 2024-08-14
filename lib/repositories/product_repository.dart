import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<List> getProducts() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }
}
