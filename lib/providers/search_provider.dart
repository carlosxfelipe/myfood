import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  List<String> _results = [];
  bool _isLoading = false;

  List<String> get results => _results;
  bool get isLoading => _isLoading;

  Future<void> searchPokemon(String query) async {
    if (query.isEmpty) {
      _results = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _dio.get(
        'https://pokeapi.co/api/v2/pokemon?limit=1000',
      );

      if (response.statusCode == 200) {
        final List pokemons = response.data['results'];
        _results =
            pokemons
                .where(
                  (pokemon) => pokemon['name']
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()),
                )
                .map<String>((pokemon) => pokemon['name'].toString())
                .toList();
      }
    } catch (e) {
      _results = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
