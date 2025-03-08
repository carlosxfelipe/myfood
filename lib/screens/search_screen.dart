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
              appBar: CustomAppBar(
                onSearchChanged: searchProvider.searchPokemon,
              ),
              body:
                  searchProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                        itemCount: searchProvider.results.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(searchProvider.results[index]),
                          );
                        },
                      ),
            ),
          );
        },
      ),
    );
  }
}
