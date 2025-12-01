import 'package:el_etehad/features/category/models/section_model.dart';
import 'package:el_etehad/features/news/models/news_images_model.dart';
import 'package:el_etehad/features/news/models/news_writer_model.dart';

class NewsDetailsModel {
  int? id;
  String? title, description, imageTitle, publishedAt, geminiSummary, body;
  List? tags, keyWords;
  NewsImagesModel? newsImagesModel;
  NewsWriterModel? newsWriterModel;
  SectionModel? sectionModel;

  NewsDetailsModel({
    required this.id,
    required this.description,
    required this.geminiSummary,
    required this.imageTitle,
    required this.keyWords,
    required this.newsImagesModel,
    required this.newsWriterModel,
    required this.publishedAt,
    required this.tags,
    required this.title,
    required this.sectionModel,
    required this.body,
  });

  NewsDetailsModel.fromJson({required Map json}) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    imageTitle = json["image_title"];
    publishedAt = json["published_at"];
    body = json["body"];

    // Fix: Check if section exists and is not null
    if (json["section"] != null && json["section"] is Map) {
      sectionModel = SectionModel.fromJson(json: json["section"]);
    } else if (json["section_data"] != null && json["section_data"] is Map) {
      // Try section_data as fallback
      sectionModel = SectionModel.fromJson(json: json["section_data"]);
    } else {
      sectionModel = null;
    }

    tags = json["tags"] ?? [];
    keyWords = json["keywords"] ?? [];
    geminiSummary = json["gemini_summary"];

    // Handle image - check if exists and is not null
    if (json["image"] != null && json["image"] is Map) {
      newsImagesModel = NewsImagesModel.fromJson(json: json["image"]);
    } else {
      newsImagesModel = null;
    }

    // Handle writer - check if exists and is not null
    if (json["writer"] != null && json["writer"] is Map) {
      newsWriterModel = NewsWriterModel.fromJson(json: json["writer"]);
    } else {
      newsWriterModel = NewsWriterModel.fromJson(
        json: {"id": 5, "name": "د. سارة أحمد"},
      );
    }
  }
}
