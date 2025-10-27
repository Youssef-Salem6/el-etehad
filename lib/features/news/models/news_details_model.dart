import 'package:el_etehad/features/news/models/news_images_model.dart';
import 'package:el_etehad/features/news/models/news_writer_model.dart';

class NewsDetailsModel {
  int? id;
  String? title, description, imageTitle, publishedAt, section, geminiSummary;
  List? tags, keyWords;
  NewsImagesModel? newsImagesModel;
  NewsWriterModel? newsWriterModel;

  NewsDetailsModel({
    required this.id,
    required this.description,
    required this.geminiSummary,
    required this.imageTitle,
    required this.keyWords,
    required this.newsImagesModel,
    required this.newsWriterModel,
    required this.publishedAt,
    required this.section,
    required this.tags,
    required this.title,
  });

  NewsDetailsModel.fromJson({required Map json}) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    imageTitle = json["image_title"];
    publishedAt = json["published_at"];
    section = json["section"];
    tags = json["tags"];
    keyWords = json["keywords"];
    geminiSummary = json["gemini_summary"];
    newsImagesModel = NewsImagesModel.fromJson(json: json["image"]);
    newsWriterModel = NewsWriterModel.fromJson(json: json["writer"]);
  }
}
