import 'package:flutter/material.dart';
import 'package:myfood/widgets.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomConvexBottomBar(
      currentIndex: 1, // Índice correspondente ao botão "Busca"
      child: Scaffold(appBar: CustomAppBar(), body: SearchBody()),
    );
  }
}

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 16, top: 16),
      child: Align(alignment: Alignment.topLeft, child: Text('Busca')),
    );
  }
}
