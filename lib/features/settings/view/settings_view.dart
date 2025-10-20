import 'package:el_etehad/core/manager/changeThemeCubit/change_theme_cubit.dart';
import 'package:el_etehad/features/profile/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );

    _fadeController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    // final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Animated App Bar
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'الإعدادات',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onPrimary,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF000014), Color(0xFF271C2E)],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.settings_rounded,
                    size: 80,
                    color: colorScheme.onPrimary.withOpacity(0.6),
                  ),
                ),
              ),
            ),
          ),

          // Settings Content
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),

                      // Theme Section
                      _buildSectionTitle(
                        'المظهر',
                        Icons.palette_rounded,
                        colorScheme.secondary,
                      ),
                      const SizedBox(height: 12),
                      _buildThemeCard(),

                      const SizedBox(height: 30),

                      // General Section
                      _buildSectionTitle(
                        'عام',
                        Icons.tune_rounded,
                        colorScheme.tertiary,
                      ),
                      const SizedBox(height: 12),
                      _buildSettingsCard(
                        icon: Icons.notifications_rounded,
                        title: 'الإشعارات',
                        subtitle: 'إدارة إشعارات التطبيق',
                        trailing: Switch(value: true, onChanged: (value) {}),
                      ),

                      const SizedBox(height: 30),

                      // Account Section
                      _buildSectionTitle(
                        'الحساب',
                        Icons.person_rounded,
                        colorScheme.secondary,
                      ),
                      const SizedBox(height: 12),
                      _buildSettingsCard(
                        icon: Icons.edit_rounded,
                        title: 'الملف الشخصي',
                        subtitle: 'قم برؤيه معلوماتك',
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                              builder: (context) => const ProfileView(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildSettingsCard(
                        icon: Icons.lock_rounded,
                        title: 'الخصوصية والأمان',
                        subtitle: 'إدارة خصوصيتك',
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        onTap: () {},
                      ),

                      const SizedBox(height: 30),

                      // Support Section
                      _buildSectionTitle(
                        'الدعم',
                        Icons.help_rounded,
                        colorScheme.tertiary,
                      ),
                      const SizedBox(height: 12),
                      _buildSettingsCard(
                        icon: Icons.info_rounded,
                        title: 'حول التطبيق',
                        subtitle: 'الإصدار 1.0.0',
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        onTap: () {},
                      ),
                      const SizedBox(height: 12),
                      _buildSettingsCard(
                        icon: Icons.contact_support_rounded,
                        title: 'اتصل بنا',
                        subtitle: 'نحن هنا للمساعدة',
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        onTap: () {},
                      ),

                      const SizedBox(height: 30),

                      // Logout Button
                      _buildLogoutButton(),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeCard() {
    return BlocBuilder<ChangeThemeCubit, ChangeThemeState>(
      builder: (context, state) {
        final cubit = context.read<ChangeThemeCubit>();
        final isDark = cubit.isDarkMode;
        final colorScheme = Theme.of(context).colorScheme;

        return TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 300),
          tween: Tween<double>(begin: 0.95, end: 1.0),
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: Card(
                elevation: isDark ? 4 : 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        colorScheme.secondaryContainer,
                        colorScheme.secondaryContainer.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        // Animated Icon Container
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: colorScheme.secondary,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.secondary.withOpacity(0.4),
                                blurRadius: 12,
                                spreadRadius: 1,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            isDark
                                ? Icons.dark_mode_rounded
                                : Icons.light_mode_rounded,
                            color: colorScheme.onSecondary,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'الوضع ${isDark ? 'الداكن' : 'الفاتح'}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSecondaryContainer,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                isDark
                                    ? 'أنت تستخدم الوضع الداكن'
                                    : 'أنت تستخدم الوضع الفاتح',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: colorScheme.onSecondaryContainer
                                      .withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Animated Switch
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          child: Transform.scale(
                            scale: 1.1,
                            child: Switch(
                              inactiveThumbColor: Colors.white,
                              value: isDark,
                              onChanged: (value) {
                                cubit.toggleTheme();
                                _scaleController.reset();
                                _scaleController.forward();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSettingsCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    void Function()? onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: isDark ? 3 : 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorScheme.outline.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        colorScheme.primary.withOpacity(0.15),
                        colorScheme.primary.withOpacity(0.08),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: colorScheme.primary, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    final colorScheme = Theme.of(context).colorScheme;
    // final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.error.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: colorScheme.errorContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.logout_rounded,
                            color: colorScheme.error,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'تسجيل الخروج',
                          style: TextStyle(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    content: Text(
                      'هل أنت متأكد من رغبتك في تسجيل الخروج؟',
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 16,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          foregroundColor: colorScheme.onSurfaceVariant,
                        ),
                        child: const Text('إلغاء'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Add logout logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.error,
                          foregroundColor: colorScheme.onError,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('تسجيل الخروج'),
                      ),
                    ],
                  ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.error,
            foregroundColor: colorScheme.onError,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout_rounded, color: colorScheme.onError),
              const SizedBox(width: 8),
              Text(
                'تسجيل الخروج',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onError,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
