
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter_bloc_tutorial/features/wishlist/ui/wishlist_tile_widget.dart';


class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }
  // Wishlist.isDeleteall = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc, WishlistState>(
      bloc: wishlistBloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Wishlist Items'),
            actions: [
              IconButton(
                  onPressed: () {
                    wishlistBloc.add(WishListDeleteAllItem());
                  },
                  icon: Icon(Icons.delete_forever))
            ],
          ),
          body: BlocConsumer<WishlistBloc, WishlistState>(
            bloc: wishlistBloc,
            listener: (context, state) {
              if (state is WishListEmptyState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("No items here"),
                  backgroundColor: Colors.red,
                ));
              }

              if (state is WishListItemRemoveState) {
                // ScaffoldMessenger.of(context)
                //     .showSnackBar(SnackBar(content: Text("Item Removed "),backgroundColor: Colors.red,));
              }
            },
            // listenWhen: (previous, current) => current is! WishListActionState,
            // buildWhen: (previous, current) => current is! WishListActionState,
            builder: (context, state) {
              switch (state.runtimeType) {
                case WishlistLoadingState:
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                case WishListEmptyState:
                  return Center(
                    child: Text(
                      "No items here",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                case WishListSuccessStae:
                  final successState = state as WishListSuccessStae;
                  return ListView.builder(
                      itemCount: successState.wishlistItems.length,
                      itemBuilder: (context, index) {
                        return WishlistTileWidget(
                          wishlistBloc: wishlistBloc,
                          productDataModel: successState.wishlistItems[index],
                        );
                      });

                default:
              }
              return Container();
            },
          ),
        );
      },
    );
  }
}
