import 'package:flutter/material.dart';
import 'package:myfood/providers/search_provider.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _getTypeColor(pokemon.types.first),
      appBar: AppBar(
        title: Text(pokemon.name.toUpperCase()),
        backgroundColor: _getTypeColor(pokemon.types.first),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              pokemon.imageUrl,
              height: 200,
              width: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Text(
              pokemon.name.toUpperCase(),
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children:
                  pokemon.types
                      .map(
                        (type) => Chip(
                          label: Text(
                            type.toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: _getTypeColor(type),
                        ),
                      )
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return Colors.redAccent;
      case 'water':
        return Colors.blueAccent;
      case 'grass':
        return Colors.green;
      case 'electric':
        return Colors.yellow.shade700;
      case 'psychic':
        return Colors.purpleAccent;
      case 'ice':
        return Colors.cyanAccent;
      case 'dragon':
        return Colors.indigo;
      case 'dark':
        return Colors.grey[850]!;
      case 'fairy':
        return Colors.pinkAccent;
      case 'fighting':
        return Colors.orange;
      case 'rock':
        return Colors.brown;
      case 'ground':
        return Colors.orange.shade300;
      case 'bug':
        return Colors.lightGreen.shade700;
      case 'ghost':
        return Colors.deepPurple;
      case 'steel':
        return Colors.blueGrey;
      case 'poison':
        return Colors.purple;
      case 'flying':
        return Colors.blue.shade300;
      default:
        return Colors.grey;
    }
  }
}
