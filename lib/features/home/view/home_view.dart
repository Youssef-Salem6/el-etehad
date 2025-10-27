import 'package:el_etehad/core/paths/images_paths.dart';
import 'package:el_etehad/features/category/view/category_News.dart';
import 'package:el_etehad/features/home/manager/homeData/get_home_data_cubit.dart';
import 'package:el_etehad/features/home/models/news_model.dart';
import 'package:el_etehad/features/home/view/widgets/HorizontalCategorySlider.dart';
import 'package:el_etehad/features/home/view/widgets/animated_artical_card.dart';
import 'package:el_etehad/features/home/view/widgets/animated_breaking_news_card.dart';
import 'package:el_etehad/features/home/view/widgets/animated_video_card.dart';
import 'package:el_etehad/features/home/view/widgets/section_title.dart';
// import 'package:el_etehad/features/home/view/widgets/voting_component.dart';
import 'package:el_etehad/features/polls/view/poll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    BlocProvider.of<GetHomeDataCubit>(context).getHomeData();
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

    return BlocConsumer<GetHomeDataCubit, GetHomeDataState>(
      listener: (context, state) {
        if (state is GetHomeDataSuccess) {
          print("Api success");
        }
      },
      builder: (context, state) {
        return state is GetHomeDataLoading
            ? Center(child: CircularProgressIndicator())
            : Scaffold(
              body: CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // Clean Modern App Bar
                  SliverAppBar(
                    expandedHeight: 100,
                    floating: false,
                    pinned: true,
                    elevation: 0,
                    backgroundColor:
                        isDark
                            ? const Color(0xFF271C2E)
                            : const Color(0xFF0d0316),
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
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Mini Logo
                              SizedBox(
                                width: 80,
                                height: 40,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    ImagesPaths.logoImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  _scrollController.animateTo(
                                    0,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                icon: Icon(Icons.close, color: Colors.white),
                              ),
                            ],
                          ),
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
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Container(
                                      width: 240,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Image.asset(
                                        ImagesPaths.logoImage,
                                        fit: BoxFit.cover,
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

                  // Category Slider - Now using the reusable component
                  SliverToBoxAdapter(
                    child: HorizontalCategorySlider(
                      categories: _categories,
                      selectedCategory: _selectedCategory,
                      isDark: isDark,
                      showInContainer: true,
                      onCategorySelected: (category) {
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
                          SectionTitle(
                            isMore: true,
                            title: 'استطلاع رأي',
                            icon: Icons.how_to_vote_outlined,
                            color: Colors.orange,
                            onMorePressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PollView(),
                                ),
                              );
                            },
                          ),
                          // AnimatedPollWidget(
                          //   poll: Poll(
                          //     question: "ايه رأيك في السيسي",
                          //     options: [
                          //       PollOption(
                          //         color: Colors.green,
                          //         text: "طرش",
                          //         votes: 120,
                          //       ),
                          //       PollOption(
                          //         color: Colors.yellow,
                          //         text: "جامد",
                          //         votes: 120,
                          //       ),
                          //       PollOption(
                          //         color: Colors.lightBlue,
                          //         text: "رايق",
                          //         votes: 120,
                          //       ),
                          //       PollOption(
                          //         color: Colors.purpleAccent,
                          //         text: "فريد من نوعه",
                          //         votes: 120,
                          //       ),
                          //     ],
                          //     totalVotes: 550,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
      },
    );
  }

  Widget _buildBreakingNewsSection() {
    List data = BlocProvider.of<GetHomeDataCubit>(context).data["news"];
    return SizedBox(
      height: 380,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        physics: const BouncingScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return AnimatedBreakingNewsCard(
            newsModel: NewsModel.fromJson(json: data[index]),
            index: index,
            time: '${index + 1}د',
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
    List data = BlocProvider.of<GetHomeDataCubit>(context).data["articals"];
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: data.length,
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
          newsModel: NewsModel.fromJson(json: data[index]),
        );
      },
    );
  }
}
