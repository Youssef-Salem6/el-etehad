import 'package:el_etehad/core/manager/changeThemeCubit/change_theme_cubit.dart';
import 'package:el_etehad/fetures/profile/view/profile_view.dart';
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
              title: const Text(
                'الإعدادات',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colorScheme.primary,
                      colorScheme.primary.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.settings_rounded,
                    size: 80,
                    color: Colors.white.withOpacity(0.5),
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
                        colorScheme.primary,
                      ),
                      const SizedBox(height: 12),
                      _buildThemeCard(),

                      const SizedBox(height: 30),

                      // General Section
                      _buildSectionTitle(
                        'عام',
                        Icons.tune_rounded,
                        colorScheme.primary,
                      ),
                      const SizedBox(height: 12),
                      _buildSettingsCard(
                        icon: Icons.notifications_rounded,
                        title: 'الإشعارات',
                        subtitle: 'إدارة إشعارات التطبيق',
                        trailing: Switch(
                          value: true,
                          onChanged: (value) {},
                          activeColor: colorScheme.primary,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Account Section
                      _buildSectionTitle(
                        'الحساب',
                        Icons.person_rounded,
                        colorScheme.primary,
                      ),
                      const SizedBox(height: 12),
                      _buildSettingsCard(
                        icon: Icons.edit_rounded,
                        title: 'الملف الشخصي',
                        subtitle: 'قم برؤيه معلوماتك',
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
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
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {},
                      ),

                      const SizedBox(height: 30),

                      // Support Section
                      _buildSectionTitle(
                        'الدعم',
                        Icons.help_rounded,
                        colorScheme.primary,
                      ),
                      const SizedBox(height: 12),
                      _buildSettingsCard(
                        icon: Icons.info_rounded,
                        title: 'حول التطبيق',
                        subtitle: 'الإصدار 1.0.0',
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {},
                      ),
                      const SizedBox(height: 12),
                      _buildSettingsCard(
                        icon: Icons.contact_support_rounded,
                        title: 'اتصل بنا',
                        subtitle: 'نحن هنا للمساعدة',
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
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
    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
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
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors:
                          isDark
                              ? [
                                colorScheme.primary.withOpacity(0.3),
                                colorScheme.primary.withOpacity(0.2),
                              ]
                              : [
                                colorScheme.primary.withOpacity(0.1),
                                colorScheme.primary.withOpacity(0.05),
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
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.primary.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            isDark
                                ? Icons.dark_mode_rounded
                                : Icons.light_mode_rounded,
                            color: Colors.white,
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
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                isDark
                                    ? 'أنت تستخدم الوضع الداكن'
                                    : 'أنت تستخدم الوضع الفاتح',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
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
                              value: isDark,
                              onChanged: (value) {
                                cubit.toggleTheme();
                                _scaleController.reset();
                                _scaleController.forward();
                              },
                              activeColor: colorScheme.primary,
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

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
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
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
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
    );
  }

  Widget _buildLogoutButton() {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: const Text('تسجيل الخروج'),
                  content: const Text('هل أنت متأكد من رغبتك في تسجيل الخروج؟'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('إلغاء'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Add logout logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.secondary,
                      ),
                      child: const Text('تسجيل الخروج'),
                    ),
                  ],
                ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.secondary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 3,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded),
            SizedBox(width: 8),
            Text(
              'تسجيل الخروج',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
