class ProductsDataModel {
  String? name;
  String? category;
  String? price;
  String? description;
  String? image;
  String? id;

  ProductsDataModel({
    this.name,
    this.category,
    this.price,
    this.description,
    this.image,
    this.id,
  });

  factory ProductsDataModel.fromJson(Map<String, dynamic> json) {
    return ProductsDataModel(
      name: json["name"],
      category: json["category"],
      price: json["price"],
      description: json["description"],
      id: json["id"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "category": category,
      "price": price,
      "description": description,
      "image": image,
      "id": id,
    };
  }
}
