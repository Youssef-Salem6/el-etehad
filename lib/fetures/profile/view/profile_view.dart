import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _listController;
  late Animation<double> _headerAnimation;
  late Animation<Offset> _slideAnimation;

  // Sample data - replace with your actual data
  final String userName = 'أحمد محمد';
  final String userEmail = 'ahmed@example.com';
  final String userImage =
      ''; // Add your image URL or leave empty for placeholder

  final List<Map<String, String>> savedNews = [
    {
      'title': 'الاتحاد يفوز بالدوري المصري للمرة العاشرة',
      'date': '2024-10-05',
      'image': 'https://via.placeholder.com/300x200',
      'category': 'رياضة',
    },
    {
      'title': 'تحديث جديد لتطبيق الاتحاد',
      'date': '2024-10-03',
      'image': 'https://via.placeholder.com/300x200',
      'category': 'تقنية',
    },
    {
      'title': 'أخبار الاتحاد اليومية',
      'date': '2024-10-01',
      'image': 'https://via.placeholder.com/300x200',
      'category': 'عام',
    },
  ];

  @override
  void initState() {
    super.initState();

    _headerController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _listController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _headerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOutCubic),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _listController, curve: Curves.easeOutCubic),
    );

    _headerController.forward();
    _listController.forward();
  }

  @override
  void dispose() {
    _headerController.dispose();
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Animated Header with Back Button
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _headerAnimation,
              child: _buildProfileHeader(isDark, primaryColor),
            ),
          ),

          // Stats Section
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _headerAnimation,
              child: _buildStatsSection(isDark, primaryColor),
            ),
          ),

          // Saved News Header
          SliverToBoxAdapter(
            child: SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الأخبار المحفوظة',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    Text(
                      '${savedNews.length} خبر',
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Saved News List
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return TweenAnimationBuilder<double>(
                  duration: Duration(milliseconds: 400 + (index * 100)),
                  tween: Tween(begin: 0.0, end: 1.0),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, 30 * (1 - value)),
                      child: Opacity(opacity: value, child: child),
                    );
                  },
                  child: _buildNewsCard(savedNews[index], isDark, primaryColor),
                );
              }, childCount: savedNews.length),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(bool isDark, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryColor, primaryColor.withOpacity(0.7)],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          // Back Button at the top
          Align(
            alignment: Alignment.topRight,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Profile Image with animation
          TweenAnimationBuilder<double>(
            duration: const Duration(seconds: 2),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.5),
                      Colors.white.withOpacity(0.1),
                    ],
                    transform: GradientRotation(value * 6.28),
                  ),
                ),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child:
                        userImage.isEmpty
                            ? Icon(Icons.person, size: 60, color: primaryColor)
                            : Image.network(
                              userImage,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.person,
                                  size: 60,
                                  color: primaryColor,
                                );
                              },
                            ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          // Name
          Text(
            userName,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),

          // Email
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.email_outlined, color: Colors.white70, size: 18),
              const SizedBox(width: 8),
              Text(
                userEmail,
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStatsSection(bool isDark, Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              icon: Icons.bookmark,
              label: 'محفوظات',
              value: '${savedNews.length}',
              isDark: isDark,
              primaryColor: primaryColor,
              delay: 200,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _buildStatCard(
              icon: Icons.favorite,
              label: 'إعجابات',
              value: '${savedNews.length * 5}',
              isDark: isDark,
              primaryColor: primaryColor,
              delay: 300,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _buildStatCard(
              icon: Icons.visibility,
              label: 'مشاهدات',
              value: '${savedNews.length * 12}',
              isDark: isDark,
              primaryColor: primaryColor,
              delay: 400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required bool isDark,
    required Color primaryColor,
    required int delay,
  }) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.elasticOut,
      builder: (context, animValue, child) {
        return Transform.scale(scale: animValue, child: child);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: primaryColor, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCard(
    Map<String, String> news,
    bool isDark,
    Color primaryColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Row(
          children: [
            // News Image
            Container(
              width: 120,
              height: 120,
              color: primaryColor.withOpacity(0.1),
              child:
                  news['image']!.isNotEmpty
                      ? Image.network(
                        news['image']!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.image,
                            size: 40,
                            color: primaryColor.withOpacity(0.3),
                          );
                        },
                      )
                      : Icon(
                        Icons.article,
                        size: 40,
                        color: primaryColor.withOpacity(0.3),
                      ),
            ),

            // News Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        news['category']!,
                        style: TextStyle(
                          fontSize: 11,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Title
                    Text(
                      news['title']!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Date
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                        const SizedBox(width: 5),
                        Text(
                          news['date']!,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Bookmark Icon
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Icon(Icons.bookmark, color: primaryColor, size: 24),
            ),
          ],
        ),
      ),
    );
  }
}
