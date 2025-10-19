import 'package:el_etehad/core/paths/images_paths.dart';
import 'package:el_etehad/fetures/category/view/category_News.dart';
import 'package:el_etehad/fetures/home/view/widgets/animated_artical_card.dart';
import 'package:el_etehad/fetures/home/view/widgets/animated_breaking_news_card.dart';
import 'package:el_etehad/fetures/home/view/widgets/animated_video_card.dart';
import 'package:el_etehad/fetures/home/view/widgets/section_title.dart';
import 'package:el_etehad/fetures/news/view/new_details.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  late ScrollController _scrollController;
  double _scrollProgress = 0.0;
  String _selectedCategory = 'الرئيسية';

  final List<String> _categories = [
    'الرئيسية',
    'سياسة',
    'رياضة',
    'عالمي',
    'فن',
    'اقتصاد',
    'تكنولوجيا',
    'صحة',
    'ثقافة',
  ];

  @override
  void initState() {
    super.initState();

    _scrollController =
        ScrollController()..addListener(() {
          setState(() {
            final maxScroll = 140.0;
            _scrollProgress = (_scrollController.offset / maxScroll).clamp(
              0.0,
              1.0,
            );
          });
        });

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Clean Modern App Bar
          SliverAppBar(
            expandedHeight: 140,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor:
                isDark ? const Color(0xFF271C2E) : const Color(0xFF0d0316),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsetsDirectional.only(
                start: 20,
                bottom: 16,
              ),
              // Small title when scrolled
              title: AnimatedOpacity(
                opacity: _scrollProgress,
                duration: const Duration(milliseconds: 200),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Mini Logo
                    Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF9b3ec7).withOpacity(0.4),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          ImagesPaths.logoImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // const SizedBox(width: 12),
                    // const Text(
                    //   'الاتحاد',
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.white,
                    //     letterSpacing: 0.5,
                    //   ),
                    // ),
                  ],
                ),
              ),
              // Expanded view
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      isDark
                          ? const Color(0xFF271C2E)
                          : const Color(0xFF0d0316),
                      isDark
                          ? const Color(0xFF1a1424)
                          : const Color(0xFF0f0319),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Opacity(
                    opacity: 1 - _scrollProgress,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Editor Info on the left
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'رئيس التحرير',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withOpacity(0.7),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'احمد الخطيب',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Logo on the right
                          Container(
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF9b3ec7,
                                  ).withOpacity(0.3),
                                  blurRadius: 20,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Image.asset(
                                  ImagesPaths.logoImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Horizontal Category Slider
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color:
                    isDark ? const Color(0xFF000014) : const Color(0xFFFAFAFA),
                boxShadow: [
                  BoxShadow(
                    color:
                        isDark
                            ? Colors.black.withOpacity(0.2)
                            : Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      physics: const BouncingScrollPhysics(),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        final isSelected = category == _selectedCategory;

                        return Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: _CategoryChip(
                            label: category,
                            isSelected: isSelected,
                            isDark: isDark,
                            onTap: () {
                              setState(() {
                                _selectedCategory = category;
                              });
                              // Navigate to category page
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          CategoryNews(categoryName: category),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Breaking News Section
                  SectionTitle(
                    isMore: true,
                    title: 'عاجل',
                    icon: Icons.bolt,
                    color: colorScheme.secondary,
                    onMorePressed: () {},
                  ),
                  const SizedBox(height: 12),
                  _buildBreakingNewsSection(),

                  const SizedBox(height: 30),

                  // Videos Section
                  SectionTitle(
                    isMore: true,
                    title: 'فيديوهات',
                    icon: Icons.play_circle_outline,
                    color: colorScheme.primary,
                    onMorePressed: () {},
                  ),
                  const SizedBox(height: 12),
                  _buildVideosSection(),

                  const SizedBox(height: 30),

                  // Featured Articles
                  SectionTitle(
                    isMore: true,
                    title: 'مقالات مميزة',
                    icon: Icons.article_outlined,
                    color: Colors.orange,
                    onMorePressed: () {},
                  ),
                  const SizedBox(height: 12),
                  _buildFeaturedArticles(),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakingNewsSection() {
    return SizedBox(
      height: 380,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return AnimatedBreakingNewsCard(
            index: index,
            title: 'خبر عاجل ${index + 1}',
            time: '${index + 1}د',
            onTap: () {
              Navigator.of(
                context,
                rootNavigator: true,
              ).push(MaterialPageRoute(builder: (context) => NewDetails()));
            },
          );
        },
      ),
    );
  }

  Widget _buildVideosSection() {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(right: 16, left: 16, bottom: 8, top: 8),
        physics: const BouncingScrollPhysics(),
        itemCount: 8,
        itemBuilder: (context, index) {
          return AnimatedVideoCard(
            index: index,
            title: 'فيديو إخباري ${index + 1}',
            views: '${(index + 1) * 12}K',
            likes: '${(index + 1) * 3}K',
            duration: '5:43',
            onTap: () {},
          );
        },
      ),
    );
  }

  Widget _buildFeaturedArticles() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return AnimatedArticleCard(
          index: index,
          description:
              "أعلنت مجموعة من الباحثين في جامعة ستانفورد عن تطوير نظام ذكاء اصطناعي جديد قادر على تشخيص الأمراض النادرة بدقة تصل إلى 95%، وهو ما يمثل قفزة نوعية في عالم الطب الرقمي.",
          title:
              'الذكاء الاصطناعي يحقق طفرة جديدة في مجال الطب بتشخيص الأمراض المبكرة',
          category: 'تكنولوجيا',
          readTime: '${index + 3} دقائق',
          onTap: () {},
        );
      },
    );
  }
}

// Category Chip Widget
class _CategoryChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  State<_CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<_CategoryChip> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color:
                widget.isSelected
                    ? const Color(0xFFef4444)
                    : (widget.isDark ? const Color(0xFF1a1424) : Colors.white),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color:
                  widget.isSelected
                      ? const Color(0xFFef4444)
                      : (widget.isDark
                          ? const Color(0xFF271C2E).withOpacity(0.5)
                          : const Color(0xFF271C2E).withOpacity(0.2)),
              width: 2,
            ),
            boxShadow:
                widget.isSelected
                    ? [
                      BoxShadow(
                        color: const Color(0xFFef4444).withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 3),
                      ),
                    ]
                    : [
                      BoxShadow(
                        color:
                            widget.isDark
                                ? const Color(0xFF000014).withOpacity(0.3)
                                : const Color(0xFF000014).withOpacity(0.08),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color:
                  widget.isSelected
                      ? Colors.white
                      : (widget.isDark
                          ? const Color(0xFFe8e8e8)
                          : const Color(0xFF0d0316)),
            ),
          ),
        ),
      ),
    );
  }
}
