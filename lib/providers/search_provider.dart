import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  List<Pokemon> _results = [];
  bool _isLoading = false;

  List<Pokemon> get results => _results;
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
        final filteredPokemons =
            pokemons
                .where(
                  (pokemon) => pokemon['name']
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()),
                )
                .toList();

        List<Pokemon> pokemonDetails = [];

        for (var pokemon in filteredPokemons) {
          final detailsResponse = await _dio.get(pokemon['url']);
          if (detailsResponse.statusCode == 200) {
            final data = detailsResponse.data;
            pokemonDetails.add(Pokemon.fromJson(data));
          }
        }

        _results = pokemonDetails;
      }
    } catch (e) {
      _results = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}

class Pokemon {
  final String name;
  final String imageUrl;
  final List<String> types;

  Pokemon({required this.name, required this.imageUrl, required this.types});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      imageUrl: json['sprites']['front_default'],
      types:
          (json['types'] as List)
              .map((type) => type['type']['name'].toString())
              .toList(),
    );
  }
}
