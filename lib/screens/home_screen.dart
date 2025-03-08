import 'package:flutter/material.dart';
import 'package:myfood/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomConvexBottomBar(
      currentIndex: 0, // Índice correspondente ao botão "Início"
      child: Scaffold(
        appBar: AddressAppBar(
          address: "Rua das Flores, 123",
          // onAddressTap: () => debugPrint('Endereço tocado!'),
        ),
        body: const HomeBody(),
      ),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final List<Map<String, dynamic>> products = [
    {
      "imageUrl":
          'https://merconnect-production.s3.amazonaws.com/uploads/products/221_200215_5cd93d7a-ae5f-4bb1-81a2-51131d1b6e64.png',
      "productName": 'Coca Cola 1l',
      "productDetails": 'Sabor Original',
      "pricePerUnit": 6.79,
      "quantity": 1,
    },
    {
      "imageUrl":
          'https://merconnect-production.s3.amazonaws.com/uploads/products/7894900031515-min.png',
      "productName": 'Fanta Laranja 2l',
      "productDetails": 'Sabor Original',
      "pricePerUnit": 8.79,
      "quantity": 1,
    },
  ];

  void _incrementQuantity(int index) {
    setState(() {
      products[index]["quantity"]++;
    });
  }

  void _decrementQuantity(int index) {
    if (products[index]["quantity"] > 1) {
      setState(() {
        products[index]["quantity"]--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const WelcomeWidget(),
          const SizedBox(height: 10),
          const CarouselWidget(indicatorColor: Colors.red),
          const SizedBox(height: 10),
          const CategoriesWidget(),
          const FeedbackWidget(),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                imageUrl: product["imageUrl"],
                productName: product["productName"],
                productDetails: product["productDetails"],
                pricePerUnit: product["pricePerUnit"],
                quantity: product["quantity"],
                onIncrement: () => _incrementQuantity(index),
                onDecrement: () => _decrementQuantity(index),
                onAdd: () {
                  debugPrint(
                    '${product["productName"]} adicionado ao carrinho!',
                  );
                },
              );
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
