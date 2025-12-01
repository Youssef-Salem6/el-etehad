import 'package:flutter/material.dart';

class CarDetails extends StatefulWidget {
  const CarDetails({super.key});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

Map details = {
  "colors": [Colors.red, Colors.black, Colors.white, Colors.blue],
  "tires_size": "18 بوصة",
  "acceleration": "0-100 كم/س في 8.5 ثانية",
  "max_speed": "220 كم/س",
  "year": "2024",
  "image": "assets/images/car3.png",
  "brand": "تويوتا",
  "model": "كورولا",
  "engine": "2.0 لتر 4 سلندر",
  "transmission": "أوتوماتيك CVT",
  "fuel_type": "بنزين",
  "fuel_consumption": "6.2 لتر/100كم",
  "seats": "5 مقاعد",
  "doors": "4 أبواب",
  "price": "420,000 لحلوح بس ",
  "description":
      "سيارة عائلية متوسطة الحجم تتميز بالموثوقية العالية والاقتصاد في استهلاك الوقود. تأتي بتصميم عصري ومواصفات متقدمة.",
};

class _CarDetailsState extends State<CarDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(
          context,
        ).copyWith(physics: const BouncingScrollPhysics(), overscroll: true),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // صورة السيارة مع AppBar
            SliverAppBar(
              expandedHeight: 350,
              pinned: true,
              stretch: true,
              backgroundColor: colorScheme.surface,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    // صورة السيارة
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            colorScheme.surface,
                            colorScheme.surface.withOpacity(0.8),
                          ],
                        ),
                      ),
                      child: Image.asset(
                        details["image"],
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.directions_car,
                            size: 150,
                            color: colorScheme.primary.withOpacity(0.3),
                          );
                        },
                      ),
                    ),
                    // Gradient overlay
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, colorScheme.surface],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              leading: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.surface.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Icon(Icons.arrow_back, color: colorScheme.onSurface),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.surface.withOpacity(0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
              ],
            ),

            // محتوى الصفحة
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // العنوان والسعر
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${details["brand"]} ${details["model"]}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary.withOpacity(
                                        0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      "موديل ${details["year"]}",
                                      style: TextStyle(
                                        color: colorScheme.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    colorScheme.primary,
                                    colorScheme.secondary,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: colorScheme.primary.withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    details["price"],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    "السعر",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // الوصف
                        Text(
                          details["description"],
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(height: 1.6),
                        ),
                      ],
                    ),
                  ),

                  // عرض الألوان
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.palette,
                              color: colorScheme.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "الألوان المتاحة",
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 60,
                          child: ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context).copyWith(
                              physics: const BouncingScrollPhysics(),
                              overscroll: true,
                            ),
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: details["colors"].length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 60,
                                  margin: const EdgeInsets.only(left: 12),
                                  decoration: BoxDecoration(
                                    color: details["colors"][index],
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: colorScheme.outline,
                                      width: 1,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // TabBar للمواصفات
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      padding: const EdgeInsets.all(4),
                      indicator: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      unselectedLabelColor: colorScheme.onSurfaceVariant,
                      dividerColor: Colors.transparent,
                      labelPadding: EdgeInsets.zero,
                      tabs: const [
                        SizedBox(width: 100, child: Tab(text: "المواصفات")),
                        SizedBox(width: 100, child: Tab(text: "الأداء")),
                        SizedBox(width: 100, child: Tab(text: "التفاصيل")),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // محتوى التابات
                  SizedBox(
                    height: 300,
                    child: TabBarView(
                      controller: _tabController,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        // تاب المواصفات
                        _buildSpecsList([
                          {
                            "icon": Icons.speed,
                            "title": "المحرك",
                            "value": details["engine"],
                          },
                          {
                            "icon": Icons.settings,
                            "title": "ناقل الحركة",
                            "value": details["transmission"],
                          },
                          {
                            "icon": Icons.local_gas_station,
                            "title": "نوع الوقود",
                            "value": details["fuel_type"],
                          },
                          {
                            "icon": Icons.event_seat,
                            "title": "المقاعد",
                            "value": details["seats"],
                          },
                          {
                            "icon": Icons.door_front_door,
                            "title": "الأبواب",
                            "value": details["doors"],
                          },
                          {
                            "icon": Icons.tire_repair,
                            "title": "مقاس الإطارات",
                            "value": details["tires_size"],
                          },
                        ]),

                        // تاب الأداء
                        _buildSpecsList([
                          {
                            "icon": Icons.flash_on,
                            "title": "التسارع",
                            "value": details["acceleration"],
                          },
                          {
                            "icon": Icons.speed,
                            "title": "السرعة القصوى",
                            "value": details["max_speed"],
                          },
                          {
                            "icon": Icons.eco,
                            "title": "استهلاك الوقود",
                            "value": details["fuel_consumption"],
                          },
                        ]),

                        // تاب التفاصيل
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailItem(
                                "الضمان",
                                "5 سنوات أو 150,000 كم",
                              ),
                              _buildDetailItem("الصيانة المجانية", "3 سنوات"),
                              _buildDetailItem(
                                "نظام السلامة",
                                "6 وسائد هوائية",
                              ),
                              _buildDetailItem(
                                "الكاميرات",
                                "كاميرا خلفية + حساسات",
                              ),
                              _buildDetailItem("الشاشة", "8 بوصة تعمل باللمس"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecsList(List<Map<String, dynamic>> specs) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(
        context,
      ).copyWith(physics: const BouncingScrollPhysics(), overscroll: true),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: specs.length,
        itemBuilder: (context, index) {
          final spec = specs[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    spec["icon"],
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        spec["title"],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurfaceVariant.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        spec["value"],
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurfaceVariant.withOpacity(0.7),
            ),
          ),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
