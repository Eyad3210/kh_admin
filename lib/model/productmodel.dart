class ProductModel {
  int? id;
  int ?categoryId;
  String? name;
  String ?nameAr;
  int ?price;
  int ?discountId;
  String? description;
  String ?image;

  ProductModel(
      {this.id,
      this.categoryId,
      this.name,
      this.nameAr,
      this.price,
      this.discountId,
      this.description,
      this.image});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    nameAr = json['name_ar'];
    price = json['price'];
    discountId = json['discount_id'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['price'] = this.price;
    data['discount_id'] = this.discountId;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}
