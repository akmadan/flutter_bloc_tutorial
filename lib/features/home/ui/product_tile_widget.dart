import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/models/home_product_data_model.dart';

class ProductTileWidget extends StatefulWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  ProductTileWidget({
    super.key,
    required this.productDataModel,
    required this.homeBloc,
  });

  @override
  State<ProductTileWidget> createState() => _ProductTileWidgetState();
}

class _ProductTileWidgetState extends State<ProductTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  BlocBuilder<HomeBloc, HomeState>(
                    bloc: widget.homeBloc,
                    builder: (context, state) {
                      return IconButton(
                          onPressed: () {
                            log(widget.productDataModel.isWishListed
                                .toString());
                            widget.homeBloc.add(
                              HomeProductWishlistButtonClickedEvent(
                                  clickedProduct: widget.productDataModel,
                                  isCliked:
                                      widget.productDataModel.isWishListed),
                            );
                          },
                          icon: widget.productDataModel.isWishListed == false
                              ? Icon(
                                  Icons.favorite_border,
                                  color: Colors.black,
                                )
                              : Icon(
                                  Icons.favorite,
                                  color: Theme.of(context).primaryColor,
                                ));
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        widget.homeBloc.add(HomeProductCartButtonClickedEvent(
                            clickedProduct: widget.productDataModel));
                      },
                      icon: Icon(Icons.shopping_bag_outlined)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
