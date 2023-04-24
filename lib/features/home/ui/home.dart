import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc/features/cart/ui/cart.dart';
import 'package:simple_bloc/features/home/bloc/home_bloc.dart';
import 'package:simple_bloc/features/home/ui/product_tile_widget.dart';
import 'package:simple_bloc/features/notify/bloc/notify_bloc.dart';
import 'package:simple_bloc/features/wishlist/ui/wish_list.dart';
import 'package:badges/badges.dart' as badges;
import 'package:simple_bloc/utils/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeIntialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) {
        return current is HomeActionState;
      },
      buildWhen: (previous, current) {
        return current is! HomeActionState;
      },
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Wishlist()));
        } else if (state is HomeProductItemCartedActionState) {
          //Item Carted
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Item Carted'),
          ));
        } else if (state is HomeProductItemWishlistedActionState) {
          //Item Wishlisted
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Item Wishlisted'),
          ));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );

          case HomeLoadedSucessState:
            final successState = state as HomeLoadedSucessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Ali Grocery app"),
                actions: [
                  //for WIshlist
                  BlocBuilder<NotifyBloc, NotifyState>(
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          homeBloc.add(HomeWishlistCartButtonNavigateEvent());
                        },
                        // icon: const Icon(Icons.favorite_border),
                        icon: badges.Badge(
                          showBadge: state.notifyCount > 0 ? true : false,
                          badgeContent: Text(
                            state.notifyCount > 99
                                ? ':D'
                                : state.notifyCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          child: const Icon(
                            Icons.favorite_border,
                            // color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),

                  //FOr Cart
                  BlocBuilder<NotifyCartBloc, NotifyStateForCart>(
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          homeBloc.add(HomeCartButtonNavigateEvent());
                        },
                        icon: badges.Badge(
                          showBadge: state.notifyCount > 0 ? true : false,
                          badgeContent: Text(
                            state.notifyCount > 99
                                ? ':D'
                                : state.notifyCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          child: const Icon(
                            Icons.shopping_bag_outlined,
                            // color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductTileWidget(
                      productDataModel: successState.products[index],
                      homeBloc: homeBloc,
                    );
                  }),
            );
          case HomeErrorState:
            return const Scaffold(
              body: Center(child: Text("error")),
            );
          default:
            return const Text('Check State Problem');
        }
      },
    );
  }
}
