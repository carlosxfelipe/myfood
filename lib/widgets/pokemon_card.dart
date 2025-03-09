import 'package:flutter/material.dart';
import 'package:myfood/providers/search_provider.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: _getTypeColor(pokemon.types.first),
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            pokemon.imageUrl,
            height: 80,
            width: 80,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 8),
          Text(
            pokemon.name.toUpperCase(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Wrap(
            spacing: 4,
            children:
                pokemon.types.map((type) => _buildTypeChip(type)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeChip(String type) {
    return Chip(
      label: Text(
        type.toUpperCase(),
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
      backgroundColor: _getTypeColor(type),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
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
