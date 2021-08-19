import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:shop/utils/constants.dart';

class Product with ChangeNotifier {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token, String userId) async {
    _toggleFavorite();

    try {
      final url =
          '${Constants.BASE_API_URL}/userFavorites/$userId/$id.json?auth=$token';

      final response = await put(
        Uri.parse(url),
        body: json.encode(isFavorite),
      );

      if(response.statusCode >= 400) {
        _toggleFavorite();
      }
    } catch(error) {
      _toggleFavorite();
    }
  }
}
