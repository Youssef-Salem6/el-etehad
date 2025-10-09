import 'package:el_etehad/fetures/home/view/widgets/animated_artical_card.dart';
import 'package:el_etehad/fetures/home/view/widgets/animated_breaking_news_card.dart';
import 'package:el_etehad/fetures/home/view/widgets/animated_category_card.dart';
import 'package:el_etehad/fetures/home/view/widgets/animated_video_card.dart';
import 'package:el_etehad/fetures/home/view/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _fadeController;
  late AnimationController _logoController;
  late AnimationController _pulseController;
  late Animation<double> _headerAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _logoScale;
  late Animation<double> _logoRotation;
  late Animation<double> _pulseAnimation;

  late ScrollController _scrollController;
  double _scrollProgress = 0.0;

  @override
  void initState() {
    super.initState();

    _scrollController =
        ScrollController()..addListener(() {
          setState(() {
            // Calculate scroll progress (0.0 to 1.0)
            // expandedHeight - minHeight = 200 - 56 = 144
            final maxScroll = 144.0;
            _scrollProgress = (_scrollController.offset / maxScroll).clamp(
              0.0,
              1.0,
            );
          });
        });

    _headerController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _headerAnimation = CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeOutBack,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _logoRotation = Tween<double>(begin: -0.5, end: 0.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _headerController.forward();
    _fadeController.forward();
    _logoController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _headerController.dispose();
    _fadeController.dispose();
    _logoController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Animated App Bar with Logo
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsetsDirectional.only(
                start: 16,
                bottom: 16,
              ),
              title: Opacity(
                opacity: _scrollProgress, // Show only when scrolled
                child: const Text(
                  'الاتحاد',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Gradient Background
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          colorScheme.primary,
                          colorScheme.primary.withOpacity(0.8),
                          colorScheme.secondary.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                  // Animated Circle 1
                  Positioned(
                    right: -50,
                    top: -50,
                    child: AnimatedBuilder(
                      animation: _headerController,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _headerController.value * 2 * math.pi,
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Animated Circle 2
                  Positioned(
                    left: -30,
                    bottom: -30,
                    child: AnimatedBuilder(
                      animation: _headerController,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: -_headerController.value * 1.5 * math.pi,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.08),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Centered Animated Logo - Hide when scrolling
                  Center(
                    child: AnimatedBuilder(
                      animation: Listenable.merge([
                        _logoController,
                        _pulseController,
                      ]),
                      builder: (context, child) {
                        return Opacity(
                          opacity: 1 - _scrollProgress, // Hide when scrolling
                          child: Transform.scale(
                            scale:
                                _logoScale.value *
                                _pulseAnimation.value *
                                (1 - _scrollProgress * 0.3),
                            child: Transform.rotate(
                              angle: _logoRotation.value,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 10,
                                    sigmaY: 10,
                                  ),
                                  child: Container(
                                    width: 280,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(24),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                        width: 1.5,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: colorScheme.secondary
                                              .withOpacity(
                                                0.3 * (1 - _scrollProgress),
                                              ),
                                          blurRadius: 20,
                                          spreadRadius: 5,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(24),
                                      child: Image.asset(
                                        "assets/images/logo ethad.png",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
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
                    title: 'مقالات مميزة',
                    icon: Icons.article_outlined,
                    color: Colors.orange,
                    onMorePressed: () {},
                  ),
                  const SizedBox(height: 12),
                  _buildFeaturedArticles(),

                  const SizedBox(height: 30),

                  // Categories Grid
                  SectionTitle(
                    title: 'الأقسام',
                    icon: Icons.grid_view,
                    color: colorScheme.primary,
                    onMorePressed: () {},
                  ),
                  const SizedBox(height: 12),
                  _buildCategoriesGrid(),

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
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return AnimatedBreakingNewsCard(
            index: index,
            title: 'خبر عاجل ${index + 1}',
            time: '${index + 1}د',
            onTap: () {
              // Handle tap
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
        padding: const EdgeInsets.only(right: 16, left: 16, bottom: 8),
        physics: const BouncingScrollPhysics(),
        itemCount: 8,
        itemBuilder: (context, index) {
          return AnimatedVideoCard(
            index: index,
            title: 'فيديو إخباري ${index + 1}',
            views: '${(index + 1) * 12}K',
            likes: '${(index + 1) * 3}K',
            duration: '5:43',
            onTap: () {
              // Handle tap
            },
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
          title: 'مقال مميز حول الأحداث الجارية ${index + 1}',
          category: 'سياسة',
          readTime: '${index + 3} دقائق',
          onTap: () {
            // Handle tap
          },
        );
      },
    );
  }

  Widget _buildCategoriesGrid() {
    final colorScheme = Theme.of(context).colorScheme;

    final categories = [
      {
        'name': 'سياسة',
        'icon': Icons.account_balance,
        'color': colorScheme.primary,
      },
      {'name': 'رياضة', 'icon': Icons.sports_soccer, 'color': Colors.green},
      {'name': 'اقتصاد', 'icon': Icons.trending_up, 'color': Colors.orange},
      {'name': 'تكنولوجيا', 'icon': Icons.computer, 'color': Colors.purple},
      {'name': 'ثقافة', 'icon': Icons.theater_comedy, 'color': Colors.pink},
      {'name': 'صحة', 'icon': Icons.favorite, 'color': colorScheme.secondary},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return AnimatedCategoryCard(
          index: index,
          name: categories[index]['name'] as String,
          icon: categories[index]['icon'] as IconData,
          color: categories[index]['color'] as Color,
          onTap: () {
            // Handle tap
          },
        );
      },
    );
  }
}
