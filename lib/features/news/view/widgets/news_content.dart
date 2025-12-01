import 'package:el_etehad/features/news/models/news_details_model.dart';
import 'package:el_etehad/features/news/view/widgets/animated_widgets.dart';
import 'package:el_etehad/features/news/view/widgets/image_gallery.dart';
import 'package:el_etehad/features/news/view/widgets/popular_people.dart';
import 'package:el_etehad/features/news/view/widgets/related_news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class NewsContent extends StatelessWidget {
  final NewsDetailsModel newsDetailsModel;
  final AnimationController fadeController;
  final AnimationController slideController;
  final ThemeData theme;
  final String newsTime;
  final String newsTitle;
  final String authorRole;
  final List<String> contentParagraphs;
  final List<Map<String, String>> imageGallery;
  final List<Map<String, String>> popularPeople;
  final List<Map<String, String>> relatedNews;

  const NewsContent({
    super.key,
    required this.fadeController,
    required this.slideController,
    required this.theme,
    required this.newsTime,
    required this.newsTitle,
    required this.authorRole,
    required this.contentParagraphs,
    required this.imageGallery,
    required this.popularPeople,
    required this.relatedNews,
    required this.newsDetailsModel,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryAndTime(),
          _buildTitle(),
          const SizedBox(height: 16),
          _buildAuthorInfo(),
          const SizedBox(height: 24),
          _buildContent(),
          const SizedBox(height: 32),
          ImageGallery(theme: theme, imageGallery: imageGallery),
          const SizedBox(height: 32),
          PopularPeople(theme: theme, popularPeople: popularPeople),
          const SizedBox(height: 32),
          RelatedNews(theme: theme, relatedNews: relatedNews),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildCategoryAndTime() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-0.5, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: slideController, curve: Curves.easeOut),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                newsDetailsModel.sectionModel!.title ?? "قسم",
                style: TextStyle(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Icon(
              Icons.access_time,
              size: 16,
              color: theme.textTheme.bodySmall?.color,
            ),
            const SizedBox(width: 4),
            Text(
              newsDetailsModel.publishedAt!,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.5, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: slideController, curve: Curves.easeOut),
        ),
        child: Text(
          newsDetailsModel.title!,
          style: theme.textTheme.displaySmall?.copyWith(height: 1.4),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }

  Widget _buildAuthorInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: FadeTransition(
        opacity: fadeController,
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=200&q=80',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newsDetailsModel.newsWriterModel!.name ?? "Unknown",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(authorRole, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
            IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          1,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: AnimatedParagraph(
              delay: index * 200,
              child: Html(
                data: newsDetailsModel.body ?? '',
                style: {
                  // تخصيص أنماط النص
                  "body": Style(
                    textAlign: TextAlign.right,
                    lineHeight: const LineHeight(1.8),
                    fontSize: FontSize(16.0),
                    fontFamily: theme.textTheme.bodyLarge?.fontFamily,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                  "p": Style(
                    textAlign: TextAlign.right,
                    lineHeight: const LineHeight(1.8),
                  ),
                  "h1": Style(
                    textAlign: TextAlign.right,
                    fontSize: FontSize(24.0),
                    fontWeight: FontWeight.bold,
                  ),
                  "h2": Style(
                    textAlign: TextAlign.right,
                    fontSize: FontSize(20.0),
                    fontWeight: FontWeight.bold,
                  ),
                  "h3": Style(
                    textAlign: TextAlign.right,
                    fontSize: FontSize(18.0),
                    fontWeight: FontWeight.bold,
                  ),
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
