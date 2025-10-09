import 'package:flutter/material.dart';

class FollowingView extends StatefulWidget {
  const FollowingView({super.key});

  @override
  State<FollowingView> createState() => _FollowingViewState();
}

class _FollowingViewState extends State<FollowingView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  // Sample data for following sources
  final List<Map<String, dynamic>> followingSources = [
    {
      'name': 'الجزيرة',
      'category': 'أخبار عامة',
      'icon': '🌍',
      'articles': '2.5K',
      'followers': '1.2M',
      'isFollowing': true,
      'verified': true,
    },
    {
      'name': 'العربية',
      'category': 'أخبار عالمية',
      'icon': '📰',
      'articles': '3.1K',
      'followers': '985K',
      'isFollowing': true,
      'verified': true,
    },
    {
      'name': 'سكاي نيوز عربية',
      'category': 'أخبار عاجلة',
      'icon': '⚡',
      'articles': '1.8K',
      'followers': '750K',
      'isFollowing': true,
      'verified': true,
    },
    {
      'name': 'بي بي سي عربي',
      'category': 'تحليلات',
      'icon': '📊',
      'articles': '1.5K',
      'followers': '890K',
      'isFollowing': true,
      'verified': true,
    },
  ];

  // Sample data for recommended sources
  final List<Map<String, dynamic>> recommendedSources = [
    {
      'name': 'الشرق الأوسط',
      'category': 'سياسة واقتصاد',
      'icon': '💼',
      'articles': '2.2K',
      'followers': '650K',
      'isFollowing': false,
      'verified': true,
    },
    {
      'name': 'رويترز عربي',
      'category': 'أخبار عالمية',
      'icon': '🌐',
      'articles': '1.9K',
      'followers': '520K',
      'isFollowing': false,
      'verified': true,
    },
    {
      'name': 'CNN بالعربية',
      'category': 'أخبار متنوعة',
      'icon': '📡',
      'articles': '1.6K',
      'followers': '430K',
      'isFollowing': false,
      'verified': true,
    },
    {
      'name': 'فرانس 24',
      'category': 'أخبار دولية',
      'icon': '🗞️',
      'articles': '1.3K',
      'followers': '380K',
      'isFollowing': false,
      'verified': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _toggleFollow(int index, bool isRecommended) {
    setState(() {
      if (isRecommended) {
        recommendedSources[index]['isFollowing'] =
            !recommendedSources[index]['isFollowing'];
      } else {
        followingSources[index]['isFollowing'] =
            !followingSources[index]['isFollowing'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'المصادر المتابَعة',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2C2C2C) : Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: isDark ? Colors.white70 : Colors.black87,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              tabs: const [Tab(text: 'المتابَعون'), Tab(text: 'الموصى بها')],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildFollowingTab(), _buildRecommendedTab()],
      ),
    );
  }

  Widget _buildFollowingTab() {
    return followingSources.isEmpty
        ? _buildEmptyState(
          'لا توجد مصادر متابَعة',
          'ابدأ بمتابعة المصادر الإخبارية المفضلة لديك',
        )
        : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: followingSources.length,
          itemBuilder: (context, index) {
            return _buildSourceCard(followingSources[index], index, false);
          },
        );
  }

  Widget _buildRecommendedTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: recommendedSources.length,
      itemBuilder: (context, index) {
        return _buildSourceCard(recommendedSources[index], index, true);
      },
    );
  }

  Widget _buildSourceCard(
    Map<String, dynamic> source,
    int index,
    bool isRecommended,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 300 + (index * 50)),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
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
              // Navigate to source details
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Source Icon
                  Hero(
                    tag: 'source_${source['name']}',
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            theme.primaryColor,
                            theme.primaryColor.withOpacity(0.7),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: theme.primaryColor.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          source['icon'],
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Source Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                source['name'],
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  fontSize: 17,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (source['verified']) ...[
                              const SizedBox(width: 4),
                              Icon(
                                Icons.verified,
                                size: 18,
                                color: theme.primaryColor,
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          source['category'],
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.primaryColor.withOpacity(0.8),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.article_outlined,
                              size: 14,
                              color: isDark ? Colors.white54 : Colors.black54,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${source['articles']} مقال',
                              style: theme.textTheme.bodySmall,
                            ),
                            const SizedBox(width: 12),
                            Icon(
                              Icons.people_outline,
                              size: 14,
                              color: isDark ? Colors.white54 : Colors.black54,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${source['followers']} متابع',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Follow Button
                  _buildFollowButton(source, index, isRecommended),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFollowButton(
    Map<String, dynamic> source,
    int index,
    bool isRecommended,
  ) {
    final theme = Theme.of(context);
    final isFollowing = source['isFollowing'];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _toggleFollow(index, isRecommended),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isFollowing ? Colors.transparent : theme.primaryColor,
              border: Border.all(color: theme.primaryColor, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isFollowing ? Icons.check : Icons.add,
                  size: 18,
                  color: isFollowing ? theme.primaryColor : Colors.white,
                ),
                const SizedBox(width: 4),
                Text(
                  isFollowing ? 'متابَع' : 'متابعة',
                  style: TextStyle(
                    color: isFollowing ? theme.primaryColor : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(String title, String subtitle) {
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
              return Transform.scale(scale: value, child: child);
            },
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.newspaper, size: 60, color: theme.primaryColor),
            ),
          ),
          const SizedBox(height: 24),
          Text(title, style: theme.textTheme.headlineMedium),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
