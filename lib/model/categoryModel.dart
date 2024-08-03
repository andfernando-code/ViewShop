class CategoryModel {
  final String categoryID;
  final String categoryName;
  final String categoryImage;

  CategoryModel({
    required this.categoryID,
    required this.categoryName,
    required this.categoryImage,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> data) {
    return CategoryModel(
      categoryID: data['categoryID'] ?? '',
      categoryName: data['categoryName'] ?? '',
      categoryImage: data['categoryImage'] ?? '',
    );
  }
}