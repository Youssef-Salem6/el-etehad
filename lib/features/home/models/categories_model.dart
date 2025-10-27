class CategoriesModel {
  int? id;
  String? name, color;

  CategoriesModel({required this.id, required this.name, required this.color});

  CategoriesModel.fromjson({required Map<String, dynamic> json}) {
    id = json["id"];
    name = json["name"];
    color = json["color"];
  }
}
