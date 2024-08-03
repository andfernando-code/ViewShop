

class Product {
  final String itemID;
  final String itemName;
  final String description;
  final String image;
  final double price;
   bool isFavorite;
  final String colors;
  final String category;
  final double reviewRate;

  Product({
    required this.itemID,
    required this.itemName,
    required this.description,
    required this.image,
    required this.price,
    required this.isFavorite,
    required this.colors,
    required this.category,
    required this.reviewRate,
  });

  factory Product.fromMap(String documentId,Map<String, dynamic> data) {
    return Product(
      itemID: documentId,
      itemName: data['itemName'] ?? '',
      description: data['description'] ?? '',
      image: data['image'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      colors: data['color'],
      category: data['category'] ?? '',
      reviewRate: (data['reviewRate'] ?? 0).toDouble(),
      isFavorite: false,
    );
  }
}
