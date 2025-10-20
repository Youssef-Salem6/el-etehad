// import 'package:el_etehad/fetures/following/view/following_view.dart';
import 'package:el_etehad/features/games/view/games_view.dart';
import 'package:el_etehad/features/home/view/home_view.dart';
import 'package:el_etehad/features/search/view/search_view.dart';
import 'package:el_etehad/features/services/view/side_sevices.dart';
import 'package:el_etehad/features/settings/view/settings_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class NavView extends StatefulWidget {
  const NavView({super.key});

  @override
  State<NavView> createState() => _NavViewState();
}

class _NavViewState extends State<NavView> with TickerProviderStateMixin {
  final PersistentTabController _controller = PersistentTabController(
    initialIndex: 0,
  );

  late AnimationController _screenAnimationController;
  late AnimationController _iconAnimationController;
  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();

    // Screen transition animation
    _screenAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Icon bounce animation
    _iconAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _screenAnimationController.forward();

    // Listen to tab changes
    _controller.addListener(() {
      if (_controller.index != _previousIndex) {
        setState(() {
          _previousIndex = _controller.index;
        });
        _screenAnimationController.reset();
        _screenAnimationController.forward();

        // Icon bounce effect
        _iconAnimationController.reset();
        _iconAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _screenAnimationController.dispose();
    _iconAnimationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _buildScreens() {
    return [
      const HomeView(),
      const SearchView(),
      const GamesView(),
      const SideServices(),
      const SettingsView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeColor = Theme.of(context).primaryColor;
    final inactiveColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return [
      _buildNavBarItem(
        icon: Icons.home_outlined,
        title: "الرئيسية",
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        textColor: textColor,
        index: 0,
      ),
      _buildNavBarItem(
        icon: Icons.search,
        title: "بحث",
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        textColor: textColor,
        index: 1,
      ),

      _buildNavBarItem(
        icon: CupertinoIcons.game_controller,
        title: "الالعاب",
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        textColor: textColor,
        index: 2,
      ),

      _buildNavBarItem(
        icon: CupertinoIcons.chart_bar,
        title: "خدمات",
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        textColor: textColor,
        index: 3,
      ),
      _buildNavBarItem(
        icon: Icons.settings_outlined,
        title: "الإعدادات",
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        textColor: textColor,
        index: 4,
      ),
    ];
  }

  PersistentBottomNavBarItem _buildNavBarItem({
    required IconData icon,
    required String title,
    required Color activeColor,
    required Color inactiveColor,
    required Color textColor,
    required int index,
  }) {
    return PersistentBottomNavBarItem(
      textStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      icon: AnimatedBuilder(
        animation: _iconAnimationController,
        builder: (context, child) {
          final isActive = _controller.index == index;
          final scale =
              isActive && _iconAnimationController.isAnimating
                  ? 1.0 +
                      (0.2 *
                          Curves.elasticOut.transform(
                            _iconAnimationController.value,
                          ))
                  : 1.0;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Transform.scale(
                  scale: scale,
                  child: Icon(icon, size: 26),
                ),
              ),
            ],
          );
        },
      ),
      activeColorPrimary: activeColor,
      inactiveColorPrimary: inactiveColor,
      title: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final navBarColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final shadowColor =
        isDark ? Colors.black.withOpacity(0.5) : Colors.grey.withOpacity(0.3);

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(context),
      confineToSafeArea: true,
      backgroundColor: navBarColor,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: navBarColor,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
      navBarStyle: NavBarStyle.style1,
      navBarHeight: 65.0,
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOutCubic,
        ),
      ),
    );
  }
}
