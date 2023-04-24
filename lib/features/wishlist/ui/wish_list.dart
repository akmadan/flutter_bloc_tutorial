import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:simple_bloc/features/wishlist/ui/wish_list_tile_widget.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final WishlistBloc wishlistBloc = WishlistBloc();
  @override
  void initState() {
    wishlistBloc.add(WishListInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishlist items"),
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishlistSuccessState:
              final successState = state as WishlistSuccessState;
              return ListView.builder(
                itemCount: successState.favItems.length,
                itemBuilder: (context, index) {
                  return WishlistTileWidget(
                    productDataModel: successState.favItems[index],
                    wishlistBloc: wishlistBloc,
                  );
                },
              );
          }
          return Container();
        },
        listenWhen: (previous, current) {
          return current is WishlistActionState;
        },
        buildWhen: (previous, current) {
          return current is! WishlistActionState;
        },
        listener: (context, state) {},
      ),
    );
  }
}
