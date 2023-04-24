import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc/features/home/models/home_product_data_model.dart';
import 'package:simple_bloc/features/notify/bloc/notify_bloc.dart';
import 'package:simple_bloc/features/wishlist/bloc/wishlist_bloc.dart';

class WishlistTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final WishlistBloc wishlistBloc;
  const WishlistTileWidget(
      {super.key, required this.productDataModel, required this.wishlistBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(productDataModel.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            height: 200,
            width: double.maxFinite,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            productDataModel.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(productDataModel.description),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${productDataModel.price}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  // IconButton(
                  //   onPressed: () {
                  //     // homeBloc.add(HomeProductWishlistButtonClickedEvent(
                  //     //     clickedProduct: productDataModel));
                  //   },
                  //   icon: const Icon(Icons.favorite_border),
                  // ),
                  BlocBuilder<NotifyBloc, NotifyState>(
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          wishlistBloc.add(WishlistRemoveFromWishListEvent(
                              productDataModel: productDataModel));
                          BlocProvider.of<NotifyBloc>(context)
                              .add(NotifyRemoveEvent());
                        },
                        icon: const Icon(Icons.favorite),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
