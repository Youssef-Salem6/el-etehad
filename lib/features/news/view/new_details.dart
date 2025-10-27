import 'package:el_etehad/features/news/manager/cubit/get_news_details_cubit.dart';
import 'package:el_etehad/features/news/view/widgets/bottom_actions.dart';
import 'package:el_etehad/features/news/view/widgets/news_app_bar.dart';
import 'package:el_etehad/features/news/view/widgets/news_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewDetails extends StatefulWidget {
  final int id;
  const NewDetails({super.key, required this.id});

  @override
  State<NewDetails> createState() => _NewDetailsState();
}

class _NewDetailsState extends State<NewDetails> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  double _imageOpacity = 1.0;
  late AnimationController _fadeController;
  late AnimationController _slideController;

  // بيانات الخبر الحقيقية (fallback data)
  final String newsTitle =
      'الذكاء الاصطناعي يحقق طفرة جديدة في مجال الطب بتشخيص الأمراض المبكرة';
  final String newsCategory = 'تكنولوجيا';
  final String newsTime = 'منذ ساعتين';
  final String authorName = 'د. سارة أحمد';
  final String authorRole = 'محررة علمية';
  final String mainImage =
      'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=800&q=80';

  final List<String> contentParagraphs = [
    'أعلنت مجموعة من الباحثين في جامعة ستانفورد عن تطوير نظام ذكاء اصطناعي جديد قادر على تشخيص الأمراض النادرة بدقة تصل إلى 95%، وهو ما يمثل قفزة نوعية في عالم الطب الرقمي.',
    'يعتمد النظام الجديد على تقنيات التعلم العميق وتحليل البيانات الطبية الضخمة، حيث تم تدريبه على أكثر من 10 ملايين حالة طبية من مختلف أنحاء العالم، مما يمكنه من التعرف على الأنماط المرضية النادرة.',
    'وفقاً للدكتور جيمس تشين، رئيس فريق البحث، فإن هذا النظام يمكنه تقليل وقت التشخيص من أسابيع إلى دقائق معدودة، وهو ما قد ينقذ حياة الآلاف من المرضى سنوياً.',
    'تخطط المستشفيات الكبرى في أوروبا والولايات المتحدة لتبني هذه التقنية بحلول نهاية العام الجاري، حيث من المتوقع أن تحدث ثورة في طريقة تشخيص وعلاج الأمراض المستعصية.',
  ];

  final List<Map<String, String>> imageGallery = [
    {
      'url':
          'https://images.unsplash.com/photo-1530497610245-94d3c16cda28?w=400&q=80',
      'caption': 'مختبر الأبحاث',
    },
    {
      'url':
          'https://images.unsplash.com/photo-1579154204601-01588f351e67?w=400&q=80',
      'caption': 'تحليل البيانات',
    },
    {
      'url':
          'https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?w=400&q=80',
      'caption': 'التشخيص الرقمي',
    },
    {
      'url':
          'https://images.unsplash.com/photo-1581093458791-9d42e2b9b2b8?w=400&q=80',
      'caption': 'نتائج الأبحاث',
    },
  ];

  final List<Map<String, String>> popularPeople = [
    {
      'name': 'د. جيمس تشين',
      'role': 'رئيس فريق البحث',
      'image':
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200&q=80',
      'description': 'أستاذ الذكاء الاصطناعي في جامعة ستانفورد',
    },
    {
      'name': 'د. إيملي روبرتس',
      'role': 'مديرة المشروع',
      'image':
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&q=80',
      'description': 'خبيرة في الطب الرقمي والتشخيص المبكر',
    },
    {
      'name': 'د. محمد الخطيب',
      'role': 'استشاري طبي',
      'image':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&q=80',
      'description': 'مستشار المشروع في منطقة الشرق الأوسط',
    },
    {
      'name': 'د. لينا كوهين',
      'role': 'باحثة رئيسية',
      'image':
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&q=80',
      'description': 'متخصصة في خوارزميات التعلم العميق',
    },
  ];

  final List<Map<String, String>> relatedNews = [
    {
      'title': 'تطبيقات الذكاء الاصطناعي في مكافحة السرطان',
      'time': 'منذ 3 ساعات',
      'image':
          'https://images.unsplash.com/photo-1559757175-5700dde675bc?w=200&q=80',
    },
    {
      'title': 'الروبوتات الجراحية تحقق نجاحات غير مسبوقة',
      'time': 'منذ 5 ساعات',
      'image':
          'https://images.unsplash.com/photo-1581093588401-fbb62a02f120?w=200&q=80',
    },
    {
      'title': 'ثورة جديدة في علاج الأمراض الوراثية',
      'time': 'منذ يوم',
      'image':
          'https://images.unsplash.com/photo-1582719508461-905c673771fd?w=200&q=80',
    },
  ];

  @override
  void initState() {
    super.initState();

    // Fetch news details from API
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetNewsDetailsCubit>().getNewsDetails(id: widget.id);
    });

    _scrollController.addListener(_scrollListener);

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..forward();
  }

  void _scrollListener() {
    setState(() {
      double offset = _scrollController.offset;
      _imageOpacity = (1.0 - (offset / 300.0)).clamp(0.0, 1.0);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocBuilder<GetNewsDetailsCubit, GetNewsDetailsState>(
        builder: (context, state) {
          // Loading state
          if (state is GetNewsDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error state
          if (state is GetNewsDetailsFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'خطأ في تحميل البيانات',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<GetNewsDetailsCubit>().getNewsDetails(
                        id: widget.id,
                      );
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }

          // Success state
          if (state is GetNewsDetailsSuccess) {
            final newsDetailsModel = state.newsDetailsModel;

            return CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                NewsAppBar(
                  scrollController: _scrollController,
                  imageOpacity: _imageOpacity,
                  mainImage: mainImage,
                  theme: theme,
                  onBack: () => Navigator.pop(context),
                ),
                SliverToBoxAdapter(
                  child: NewsContent(
                    fadeController: _fadeController,
                    slideController: _slideController,
                    theme: theme,
                    newsTime: newsTime,
                    newsTitle: newsTitle,
                    authorRole: authorRole,
                    contentParagraphs: contentParagraphs,
                    imageGallery: imageGallery,
                    popularPeople: popularPeople,
                    relatedNews: relatedNews,
                    newsDetailsModel: newsDetailsModel,
                  ),
                ),
              ],
            );
          }

          // Initial state (also show loading)
          return const Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar:
          BlocBuilder<GetNewsDetailsCubit, GetNewsDetailsState>(
            builder: (context, state) {
              // Only show bottom actions when success
              if (state is GetNewsDetailsSuccess) {
                return BottomActions(theme: theme);
              }
              return const SizedBox.shrink();
            },
          ),
    );
  }
}
