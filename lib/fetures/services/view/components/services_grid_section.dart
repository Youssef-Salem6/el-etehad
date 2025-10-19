import 'package:el_etehad/fetures/services/view/current_calc_view.dart';
import 'package:flutter/material.dart';

class ServicesGridSection extends StatelessWidget {
  final ThemeData theme;
  final bool isDark;

  const ServicesGridSection({
    super.key,
    required this.theme,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'خدمات أخرى',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildServicesGrid(context),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildServicesGrid(BuildContext context) {
    final services = [
      ServiceItem(
        icon: Icons.currency_exchange,
        title: 'أسعار العملات',
        subtitle: 'تحويل العملات',
        color: const Color(0xFF3b82f6),
      ),
      ServiceItem(
        icon: Icons.train,
        title: 'مواعيد القطارات',
        subtitle: 'جداول السكك الحديدية',
        color: const Color(0xFF10b981),
      ),
      ServiceItem(
        icon: Icons.subway,
        title: 'مترو الأنفاق',
        subtitle: 'خطوط ومواعيد المترو',
        color: const Color(0xFFf59e0b),
      ),
      ServiceItem(
        icon: Icons.local_gas_station,
        title: 'أسعار البنزين',
        subtitle: 'أسعار المحروقات',
        color: const Color(0xFFef4444),
      ),
      ServiceItem(
        icon: Icons.phone,
        title: 'أرقام مهمة',
        subtitle: 'خدمات الطوارئ',
        color: const Color(0xFF8b5cf6),
      ),
      ServiceItem(
        icon: Icons.local_pharmacy,
        title: 'صيدليات',
        subtitle: 'صيدليات الخدمة',
        color: const Color(0xFF06b6d4),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return _buildServiceCard(services[index], context);
        },
      ),
    );
  }

  Widget _buildServiceCard(ServiceItem service, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (service.icon == Icons.currency_exchange) {
          Navigator.of(
            context,
            rootNavigator: false,
          ).push(MaterialPageRoute(builder: (context) => CurrentCalcView()));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1a1424) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                isDark
                    ? const Color(0xFF271C2E).withOpacity(0.3)
                    : const Color(0xFF271C2E).withOpacity(0.1),
          ),
          boxShadow: [
            BoxShadow(
              color:
                  isDark
                      ? const Color(0xFF000014).withOpacity(0.4)
                      : const Color(0xFF000014).withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: service.color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(service.icon, color: service.color, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              service.title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                service.subtitle,
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  ServiceItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });
}
