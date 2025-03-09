import 'package:flutter/material.dart';
import 'package:myfood/providers/search_provider.dart';
import 'package:myfood/screens.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetailScreen(pokemon: pokemon),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: _getGradient(pokemon.types),
          ),
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
        ),
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

  /// Se o Pokémon tiver 2 tipos, cria um gradiente. Se tiver 1 tipo, usa apenas essa cor com variação no alpha.
  LinearGradient _getGradient(List<String> types) {
    if (types.length > 1) {
      return LinearGradient(
        colors: types.map((type) => _getTypeColor(type)).toList(),
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      return LinearGradient(
        colors: [
          _getTypeColor(types.first),
          _getTypeColor(types.first).withAlpha(200),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
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
