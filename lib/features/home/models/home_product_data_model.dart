class ProductDataModel {
  final String id;
  final String name;
  final String description;
  final double price;
   bool isCartListed;
   bool isWishListed;
  final String imageUrl;
  ProductDataModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.isWishListed,
    required this.isCartListed,
  });
}
