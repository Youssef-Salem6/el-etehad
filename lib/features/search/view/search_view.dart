import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  final List<String> categories = [
    'الكل',
    'الرئيسية',
    'سياسة',
    'رياضة',
    'عالمي',
    'فن',
    'منوعات',
    'انفوجرافيك',
    'حوادث',
    'اقتصاد',
    'تكنولوجيا',
    'صحة',
    'ثقافة',
  ];

  final Map<String, List<Map<String, dynamic>>> newsData = {
    'الكل': [
      {
        'title': 'انطلاق مؤتمر التقنية السنوي في دبي',
        'source': 'العربية',
        'time': 'منذ ساعتين',
        'image': '💻',
        'category': 'تكنولوجيا',
      },
      {
        'title': 'ارتفاع أسعار النفط لأعلى مستوى هذا العام',
        'source': 'الجزيرة',
        'time': 'منذ 3 ساعات',
        'image': '📈',
        'category': 'اقتصاد',
      },
      {
        'title': 'منتخب مصر يتأهل للدور النهائي',
        'source': 'بي إن سبورت',
        'time': 'منذ 5 ساعات',
        'image': '⚽',
        'category': 'رياضة',
      },
    ],
    'سياسة': [
      {
        'title': 'قمة عربية طارئة لبحث الأوضاع الإقليمية',
        'source': 'الشرق الأوسط',
        'time': 'منذ ساعة',
        'image': '🏛️',
        'category': 'سياسة',
      },
      {
        'title': 'اتفاقية تعاون جديدة بين دول الخليج',
        'source': 'العربية',
        'time': 'منذ 4 ساعات',
        'image': '🤝',
        'category': 'سياسة',
      },
    ],
    'رياضة': [
      {
        'title': 'محمد صلاح يسجل هدفين في مباراة الأمس',
        'source': 'بي إن سبورت',
        'time': 'منذ ساعة',
        'image': '⚽',
        'category': 'رياضة',
      },
      {
        'title': 'الأهلي يفوز بكأس السوبر الإفريقي',
        'source': 'سبورت 360',
        'time': 'منذ 6 ساعات',
        'image': '🏆',
        'category': 'رياضة',
      },
    ],
    'تكنولوجيا': [
      {
        'title': 'إطلاق هاتف ذكي جديد بمواصفات متطورة',
        'source': 'تك كرانش عربي',
        'time': 'منذ ساعتين',
        'image': '📱',
        'category': 'تكنولوجيا',
      },
      {
        'title': 'شركة ناشئة عربية تحصل على تمويل ضخم',
        'source': 'ومضة',
        'time': 'منذ 7 ساعات',
        'image': '🚀',
        'category': 'تكنولوجيا',
      },
    ],
    'اقتصاد': [
      {
        'title': 'البورصة المصرية تسجل ارتفاعاً قياسياً',
        'source': 'الاقتصادية',
        'time': 'منذ 3 ساعات',
        'image': '📊',
        'category': 'اقتصاد',
      },
    ],
    'صحة': [
      {
        'title': 'دراسة جديدة عن فوائد المشي اليومي',
        'source': 'صحتك',
        'time': 'منذ 5 ساعات',
        'image': '🏃',
        'category': 'صحة',
      },
    ],
    'ثقافة': [
      {
        'title': 'معرض الكتاب الدولي يفتح أبوابه',
        'source': 'الثقافة اليوم',
        'time': 'منذ 4 ساعات',
        'image': '📚',
        'category': 'ثقافة',
      },
    ],
    'فن': [
      {
        'title': 'فيلم عربي يفوز بجائزة عالمية',
        'source': 'فن',
        'time': 'منذ 6 ساعات',
        'image': '🎬',
        'category': 'فن',
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
    _searchController.addListener(() {
      setState(() {
        _isSearching = _searchController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // Search AppBar
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: 120,
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
                child: _buildSearchBar(theme, isDark),
              ),
            ),
          ),

          // Category Tabs
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              TabBar(
                controller: _tabController,
                isScrollable: true,
                indicator: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.secondary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                indicatorSize: TabBarIndicatorSize.label,
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: theme.textTheme.bodyMedium?.color,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                tabs:
                    categories.map((category) {
                      return Tab(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text(category),
                        ),
                      );
                    }).toList(),
              ),
              theme.scaffoldBackgroundColor,
            ),
          ),

          // News Cards
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              child: TabBarView(
                controller: _tabController,
                children:
                    categories.map((category) {
                      return _buildNewsList(category);
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(ThemeData theme, bool isDark) {
    return Hero(
      tag: 'search_bar',
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: theme.cardTheme.color,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colorScheme.outline.withOpacity(0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: _searchController,
            textAlign: TextAlign.right,
            style: theme.textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: 'ابحث عن الأخبار...',
              hintStyle: theme.inputDecorationTheme.hintStyle,
              prefixIcon:
                  _isSearching
                      ? IconButton(
                        icon: Icon(Icons.clear, color: theme.iconTheme.color),
                        onPressed: () {
                          _searchController.clear();
                          FocusScope.of(context).unfocus();
                        },
                      )
                      : null,
              suffixIcon: Icon(Icons.search, color: theme.colorScheme.primary),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewsList(String category) {
    final news = newsData[category] ?? [];

    if (news.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: news.length,
      itemBuilder: (context, index) {
        return _buildNewsCard(news[index], index);
      },
    );
  }

  Widget _buildNewsCard(Map<String, dynamic> news, int index) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 300 + (index * 50)),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              // Navigate to article details
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // News Image/Icon
                  Hero(
                    tag: 'news_${news['title']}_$index',
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.primary,
                            theme.colorScheme.secondary,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          news['image'],
                          style: const TextStyle(fontSize: 36),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // News Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                theme.colorScheme.primary.withOpacity(0.2),
                                theme.colorScheme.secondary.withOpacity(0.2),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: theme.colorScheme.primary.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            news['category'],
                            style: TextStyle(
                              color:
                                  isDark
                                      ? theme.colorScheme.secondary
                                      : theme.colorScheme.primary,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Title
                        Text(
                          news['title'],
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        // Source and Time
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              news['time'],
                              style: theme.textTheme.bodySmall,
                            ),
                            const SizedBox(width: 12),
                            Icon(
                              Icons.newspaper,
                              size: 14,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                news['source'],
                                style: theme.textTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Bookmark Icon
                  IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: () {
                      // Add to bookmarks
                    },
                    color: theme.iconTheme.color,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 600),
            curve: Curves.elasticOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value.clamp(0.0, 1.0),
                child: child,
              );
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary.withOpacity(0.2),
                    theme.colorScheme.secondary.withOpacity(0.2),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off,
                size: 50,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('لا توجد أخبار', style: theme.textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text('جرب البحث في فئة أخرى', style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar, this._color);

  final TabBar _tabBar;
  final Color _color;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: _color, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
