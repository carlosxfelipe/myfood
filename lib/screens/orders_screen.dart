import 'package:flutter/material.dart';
import 'package:myfood/widgets.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomConvexBottomBar(
      currentIndex: 2, // Índice correspondente ao botão "Pedidos"
      child: Scaffold(appBar: CustomAppBar(), body: OrdersBody()),
    );
  }
}

class OrdersBody extends StatelessWidget {
  const OrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 16, top: 16),
      child: Align(alignment: Alignment.topLeft, child: Text('Pedidos')),
    );
  }
}
