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
}
