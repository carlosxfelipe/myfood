import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myfood/providers/search_provider.dart';
import 'package:myfood/widgets.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchProvider(),
      child: Consumer<SearchProvider>(
        builder: (context, searchProvider, child) {
          return CustomConvexBottomBar(
            currentIndex: 1, // Índice correspondente ao botão "Busca"
            child: Scaffold(
              appBar: SearchAppBar(
                onSearchChanged: searchProvider.searchPokemon,
              ),
              body:
                  searchProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : searchProvider.results.isEmpty
                      ? _buildEmptyState(context, searchProvider)
                      : GridView.builder(
                        padding: const EdgeInsets.all(8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.9,
                            ),
                        itemCount: searchProvider.results.length,
                        itemBuilder: (context, index) {
                          final pokemon = searchProvider.results[index];
                          return PokemonCard(pokemon: pokemon);
                        },
                      ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, SearchProvider searchProvider) {
    List<String> suggestions = [
      "Pikachu",
      "Charizard",
      "Bulbasaur",
      "Mewtwo",
      "Eevee",
    ];

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final chipColor = isDarkMode ? Colors.grey[800]! : Colors.grey[200]!;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 80, color: Colors.grey[600]),
          const SizedBox(height: 16),
          Text(
            "Pesquise um prato ou bebida...",
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            children:
                suggestions
                    .map(
                      (suggestion) => GestureDetector(
                        onTap: () => searchProvider.searchPokemon(suggestion),
                        child: Chip(
                          label: Text(suggestion),
                          backgroundColor: chipColor,
                          labelStyle: TextStyle(color: textColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}
