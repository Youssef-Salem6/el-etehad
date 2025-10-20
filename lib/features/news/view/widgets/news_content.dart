import 'package:el_etehad/features/news/view/widgets/animated_widgets.dart';
import 'package:el_etehad/features/news/view/widgets/image_gallery.dart';
import 'package:el_etehad/features/news/view/widgets/popular_people.dart';
import 'package:el_etehad/features/news/view/widgets/related_news.dart';
import 'package:flutter/material.dart';


class NewsContent extends StatelessWidget {
  final AnimationController fadeController;
  final AnimationController slideController;
  final ThemeData theme;
  final String newsCategory;
  final String newsTime;
  final String newsTitle;
  final String authorName;
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
    required this.newsCategory,
    required this.newsTime,
    required this.newsTitle,
    required this.authorName,
    required this.authorRole,
    required this.contentParagraphs,
    required this.imageGallery,
    required this.popularPeople,
    required this.relatedNews,
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
          CurvedAnimation(
            parent: slideController,
            curve: Curves.easeOut,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                newsCategory,
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
            Text(newsTime, style: theme.textTheme.bodySmall),
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
          CurvedAnimation(
            parent: slideController,
            curve: Curves.easeOut,
          ),
        ),
        child: Text(
          newsTitle,
          style: theme.textTheme.displaySmall?.copyWith(
            height: 1.4,
          ),
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
                    authorName,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    authorRole,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
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
          contentParagraphs.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: AnimatedParagraph(
              delay: index * 200,
              child: Text(
                contentParagraphs[index],
                style: theme.textTheme.bodyLarge?.copyWith(height: 1.8),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ),
      ),
    );
  }
}