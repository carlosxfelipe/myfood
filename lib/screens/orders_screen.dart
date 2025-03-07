import 'package:flutter/material.dart';
import 'package:myfood/widgets.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomConvexBottomBar(
      currentIndex: 2, // Índice correspondente ao botão "Pedidos"
      child: Scaffold(appBar: CustomAppBar(), body: const OrdersBody()),
    );
  }
}

class OrdersBody extends StatelessWidget {
  const OrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> orders = [
      {
        "id": "#12345",
        "status": "Entregue",
        "date": "05/03/2025",
        "total": 56.90,
        "items": "2 itens",
      },
      {
        "id": "#12346",
        "status": "Em andamento",
        "date": "06/03/2025",
        "total": 32.50,
        "items": "1 item",
      },
      {
        "id": "#12347",
        "status": "Cancelado",
        "date": "04/03/2025",
        "total": 78.20,
        "items": "3 itens",
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Meus Pedidos',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderCard(
                  orderId: order["id"],
                  status: order["status"],
                  date: order["date"],
                  total: order["total"],
                  items: order["items"],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderId;
  final String status;
  final String date;
  final double total;
  final String items;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.status,
    required this.date,
    required this.total,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    Color statusColor;
    switch (status) {
      case "Entregue":
        statusColor = Colors.green;
        break;
      case "Em andamento":
        statusColor = Colors.orange;
        break;
      case "Cancelado":
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors:
                isDarkMode
                    ? [Colors.grey[800]!, Colors.grey[900]!]
                    : [Colors.grey[100]!, Colors.grey[200]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    orderId,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    status,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text('Data: $date', style: Theme.of(context).textTheme.bodySmall),
              Text(items, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 8),
              Text(
                'Total: R\$ ${total.toStringAsFixed(2).replaceAll(".", ",")}',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
