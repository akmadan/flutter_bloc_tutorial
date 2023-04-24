import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc/features/cart/ui/cart_tile_widget.dart';
import 'package:simple_bloc/features/home/ui/product_tile_widget.dart';

import '../bloc/cart_bloc.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart Items"),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final successState = state as CartSuccessState;
              return ListView.builder(
                  itemCount: successState.cartItems.length,
                  itemBuilder: (context, index) {
                    return CartTileWidget(
                      productDataModel: successState.cartItems[index],
                      cartBloc: cartBloc,
                    );
                  });
          }
          return Container();
        },
        listenWhen: (previous, current) {
          return current is CartActionState;
        },
        buildWhen: (previous, current) {
          return current is! CartActionState;
        },
        listener: (context, state) {},
      ),
    );
  }
}
