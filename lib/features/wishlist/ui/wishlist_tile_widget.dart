import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/models/home_product_data_model.dart';
import 'package:flutter_bloc_tutorial/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter_bloc_tutorial/features/wishlist/ui/wishlist.dart';

import '../../home/ui/home.dart';
import '../../home/ui/product_tile_widget.dart';

class WishlistTileWidget extends StatefulWidget {
  final ProductDataModel productDataModel;
  final WishlistBloc wishlistBloc;
  const WishlistTileWidget({
    super.key,
    required this.productDataModel,
    required this.wishlistBloc,
  });

  @override
  State<WishlistTileWidget> createState() => _WishlistTileWidgetState();
}

class _WishlistTileWidgetState extends State<WishlistTileWidget> {
  @override
  Widget build(BuildContext context) {
    // log(Home.productwidget!.length.toString());
    return BlocBuilder<WishlistBloc, WishlistState>(
      bloc: widget.wishlistBloc,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: BlocBuilder<WishlistBloc, WishlistState>(
                  bloc: widget.wishlistBloc,
                  builder: (context, state) {
                    return IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        widget.wishlistBloc.add(
                            WishlistRemoveFromItm(widget.productDataModel));
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 05,
              ),
              Container(
                height: 200,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.productDataModel.imageUrl))),
              ),
              const SizedBox(height: 20),
              Text(widget.productDataModel.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(widget.productDataModel.description),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("\$" + widget.productDataModel.price.toString(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
