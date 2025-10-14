import 'package:el_etehad/fetures/news/view/new_details.dart';
import 'package:flutter/material.dart';

class NewsItem {
  final String headline;
  final String description;
  final String imageUrl;
  final String sourceIcon;
  final String sourceName;
  final String timeAgo;

  NewsItem({
    required this.headline,
    required this.description,
    required this.imageUrl,
    required this.sourceIcon,
    required this.sourceName,
    required this.timeAgo,
  });
}

class CategoryNews extends StatefulWidget {
  final String categoryName;
  const CategoryNews({super.key, required this.categoryName});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews>
    with TickerProviderStateMixin {
  late AnimationController _cardController;
  late AnimationController _imageController;
  late List<AnimationController> _itemControllers;

  final List<NewsItem> newsList = [
    NewsItem(
      headline: 'عنوان الخبر الأول',
      description: 'وصف قصير للخبر يعطي نظرة عامة عن المحتوى الرئيسي',
      imageUrl:
          'https://images.unsplash.com/photo-1530497610245-94d3c16cda28?w=400&q=80',
      sourceIcon:
          'https://images.unsplash.com/photo-1579154204601-01588f351e67?w=400&q=80',
      sourceName: 'مصدر الخبر',
      timeAgo: 'منذ ساعة',
    ),
    NewsItem(
      headline: 'عنوان الخبر الأول',
      description: 'وصف قصير للخبر يعطي نظرة عامة عن المحتوى الرئيسي',
      imageUrl:
          'https://images.unsplash.com/photo-1530497610245-94d3c16cda28?w=400&q=80',
      sourceIcon:
          'https://images.unsplash.com/photo-1579154204601-01588f351e67?w=400&q=80',
      sourceName: 'مصدر الخبر',
      timeAgo: 'منذ ساعة',
    ),
    NewsItem(
      headline: 'عنوان الخبر الأول',
      description: 'وصف قصير للخبر يعطي نظرة عامة عن المحتوى الرئيسي',
      imageUrl:
          'https://images.unsplash.com/photo-1530497610245-94d3c16cda28?w=400&q=80',
      sourceIcon:
          'https://images.unsplash.com/photo-1579154204601-01588f351e67?w=400&q=80',
      sourceName: 'مصدر الخبر',
      timeAgo: 'منذ ساعة',
    ),
    NewsItem(
      headline: 'عنوان الخبر الأول',
      description: 'وصف قصير للخبر يعطي نظرة عامة عن المحتوى الرئيسي',
      imageUrl:
          'https://images.unsplash.com/photo-1530497610245-94d3c16cda28?w=400&q=80',
      sourceIcon:
          'https://images.unsplash.com/photo-1579154204601-01588f351e67?w=400&q=80',
      sourceName: 'مصدر الخبر',
      timeAgo: 'منذ ساعة',
    ),
    NewsItem(
      headline: 'عنوان الخبر الثاني',
      description: 'وصف قصير للخبر يعطي نظرة عامة عن المحتوى الرئيسي',
      imageUrl:
          'https://images.unsplash.com/photo-1530497610245-94d3c16cda28?w=400&q=80',
      sourceIcon:
          'https://images.unsplash.com/photo-1579154204601-01588f351e67?w=400&q=80',
      sourceName: 'مصدر الخبر',
      timeAgo: 'منذ ساعتين',
    ),
    NewsItem(
      headline: 'عنوان الخبر الثالث',
      description: 'وصف قصير للخبر يعطي نظرة عامة عن المحتوى الرئيسي',
      imageUrl:
          'https://images.unsplash.com/photo-1530497610245-94d3c16cda28?w=400&q=80',
      sourceIcon:
          'https://images.unsplash.com/photo-1579154204601-01588f351e67?w=400&q=80',
      sourceName: 'مصدر الخبر',
      timeAgo: 'منذ 3 ساعات',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _cardController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _imageController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _itemControllers = List.generate(
      newsList.length,
      (_) => AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      ),
    );

    _cardController.forward();
    _imageController.forward();

    Future.delayed(const Duration(milliseconds: 300), () {
      for (int i = 0; i < _itemControllers.length; i++) {
        Future.delayed(Duration(milliseconds: i * 150), () {
          if (mounted) _itemControllers[i].forward();
        });
      }
    });
  }

  @override
  void dispose() {
    _cardController.dispose();
    _imageController.dispose();
    for (var controller in _itemControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.categoryName,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            return FadeTransition(
              opacity: Tween<double>(begin: 0, end: 1).animate(
                CurvedAnimation(
                  parent: _itemControllers[index],
                  curve: Curves.easeOut,
                ),
              ),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.3, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: _itemControllers[index],
                    curve: Curves.easeOut,
                  ),
                ),
                child: _buildNewsCard(context, newsList[index]),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNewsCard(BuildContext context, NewsItem news) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewDetails()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: ScaleTransition(
                  scale: Tween<double>(begin: 1.0, end: 1.05).animate(
                    CurvedAnimation(
                      parent: _imageController,
                      curve: Curves.easeOut,
                    ),
                  ),
                  child: Image.network(
                    news.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (_, __, ___) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported),
                        ),
                  ),
                ),
              ),

              // Dark overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
              ),

              // Content
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top - Source info
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ScaleTransition(
                            scale: Tween<double>(begin: 0.5, end: 1.0).animate(
                              CurvedAnimation(
                                parent: _cardController,
                                curve: Curves.elasticOut,
                              ),
                            ),
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  news.sourceIcon,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (_, __, ___) => Container(
                                        color: Colors.grey[400],
                                        child: const Icon(
                                          Icons.account_circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  news.sourceName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                                Text(
                                  news.timeAgo,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Bottom - Headline and description
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            news.headline,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            news.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              height: 1.4,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
