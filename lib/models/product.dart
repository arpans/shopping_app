class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.isFavorite = false,
  });

  // Method to create a Product from a JSON object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      isFavorite:
          false, // Default value, change when fetching user-specific data
    );
  }

  // Method to convert a Product to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'isFavorite': isFavorite,
    };
  }

  // Method to create a copy of a Product with modified properties
  Product copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
