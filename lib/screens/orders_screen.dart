import 'package:flutter/material.dart';
import 'package:myfood/utils/color_utils.dart';
import 'package:myfood/widgets.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String _selectedStatus = "Todos";

  @override
  Widget build(BuildContext context) {
    return CustomConvexBottomBar(
      currentIndex: 2, // Índice correspondente ao botão "Pedidos"
      child: Scaffold(
        appBar: CustomAppBar(),
        body: OrdersBody(
          selectedStatus: _selectedStatus,
          onStatusChanged: (String newStatus) {
            setState(() {
              _selectedStatus = newStatus;
            });
          },
        ),
      ),
    );
  }
}

class OrdersBody extends StatelessWidget {
  final String selectedStatus;
  final Function(String) onStatusChanged;

  const OrdersBody({
    super.key,
    required this.selectedStatus,
    required this.onStatusChanged,
  });

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

    final List<String> statuses = [
      "Todos",
      "Entregue",
      "Em andamento",
      "Cancelado",
    ];

    final Map<String, Color> tagColors = {
      "Todos": Colors.blue,
      "Entregue": Colors.green,
      "Em andamento": Colors.amber,
      "Cancelado": Colors.red,
    };

    final Map<String, Color> tagColorsAccent = {
      "Todos": Colors.blueAccent.shade100,
      "Entregue": Colors.greenAccent.shade100,
      "Em andamento": Colors.amberAccent.shade100,
      "Cancelado": Colors.redAccent.shade100,
    };

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final filteredOrders =
        selectedStatus == "Todos"
            ? orders
            : orders
                .where((order) => order["status"] == selectedStatus)
                .toList();

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Meus Pedidos',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    statuses.map((status) {
                      final isSelected = selectedStatus == status;
                      final buttonBackgroundColor =
                          isSelected
                              ? isDarkMode
                                  ? darken(tagColors[status]!, 0.3)
                                  : tagColors[status]!.withAlpha(10)
                              : (isDarkMode
                                  ? Colors.grey[800]!
                                  : Colors.grey[200]!);
                      final buttonForegroundColor =
                          isSelected
                              ? (isDarkMode
                                  ? tagColorsAccent[status]!
                                  : tagColors[status]!)
                              : (isDarkMode ? Colors.white : Colors.black);

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonBackgroundColor,
                            foregroundColor: buttonForegroundColor,
                            shadowColor: Colors.transparent,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                          ),
                          onPressed: () => onStatusChanged(status),
                          child: Text(status),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                final order = filteredOrders[index];
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

    Color tagBackground;
    Color tagTextColor;

    switch (status) {
      case "Entregue":
        tagBackground =
            isDarkMode
                ? Colors.greenAccent.withAlpha(50)
                : Colors.green.withAlpha(50);
        tagTextColor = isDarkMode ? Colors.greenAccent : Colors.green.shade800;
        break;
      case "Em andamento":
        tagBackground =
            isDarkMode
                ? Colors.amberAccent.withAlpha(50)
                : Colors.amber.withAlpha(50);
        tagTextColor = isDarkMode ? Colors.amberAccent : Colors.amber.shade800;
        break;
      case "Cancelado":
        tagBackground =
            isDarkMode
                ? Colors.redAccent.withAlpha(50)
                : Colors.red.withAlpha(50);
        tagTextColor = isDarkMode ? Colors.redAccent : Colors.red.shade800;
        break;
      default:
        tagBackground = Colors.grey.withAlpha(50);
        tagTextColor = Colors.grey.shade800;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
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
                  Container(
                    constraints: const BoxConstraints(minWidth: 160),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: tagBackground,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.circle, size: 12, color: tagTextColor),
                        const SizedBox(width: 4),
                        Text(
                          status,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: tagTextColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
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
