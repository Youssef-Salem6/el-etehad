class NewsModel {
  int? id;
  String? title, category, image, location, publishedAt;
  bool? usedAi;

  NewsModel({
    required this.id,
    required this.title,
    required this.category,
    required this.image,
    required this.location,
    required this.publishedAt,
    required this.usedAi,
  });

  NewsModel.fromJson({required Map<String, dynamic> json}) {
    id = json["id"];
    title = json["title"];
    category = json["category"];
    image = json["image"];
    location = json["location"];
    publishedAt = json["published_at"];
    usedAi = json["used_ai"];
  }
}
