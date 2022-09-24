class CategoriesModel {
  int? id;
  String? category_name;
  String? category_name_ar;
  String? image;

  CategoriesModel(
      {this.id, this.category_name, this.category_name_ar, this.image});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category_name = json['category_name'];
    category_name_ar = json['category_name_ar'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.category_name;
    data['category_name_ar'] = this.category_name_ar;
    data['image'] = this.image;

    return data;
  }
}
