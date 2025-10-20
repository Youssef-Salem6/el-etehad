import 'package:el_etehad/fetures/services/models/emergency_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/emergency_banner.dart';
import 'components/numbers_grid_section.dart';
import 'components/numbers_list_section.dart';


class ImportantNumbersView extends StatefulWidget {
  const ImportantNumbersView({super.key});

  @override
  State<ImportantNumbersView> createState() => _ImportantNumbersViewState();
}

class _ImportantNumbersViewState extends State<ImportantNumbersView>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final List<EmergencyNumber> emergencyNumbers = [
    EmergencyNumber(
      name: 'الشرطة',
      number: '122',
      icon: Icons.local_police,
      color: const Color(0xFF3b82f6),
      gradient: const [Color(0xFF3b82f6), Color(0xFF2563eb)],
    ),
    EmergencyNumber(
      name: 'الإسعاف',
      number: '123',
      icon: Icons.local_hospital,
      color: const Color(0xFFef4444),
      gradient: const [Color(0xFFef4444), Color(0xFFdc2626)],
    ),
    EmergencyNumber(
      name: 'الإطفاء',
      number: '180',
      icon: Icons.local_fire_department,
      color: const Color(0xFFf59e0b),
      gradient: const [Color(0xFFf59e0b), Color(0xFFd97706)],
    ),
    EmergencyNumber(
      name: 'الغاز الطبيعي',
      number: '129',
      icon: Icons.gas_meter,
      color: const Color(0xFF8b5cf6),
      gradient: const [Color(0xFF8b5cf6), Color(0xFF7c3aed)],
    ),
    EmergencyNumber(
      name: 'الكهرباء',
      number: '121',
      icon: Icons.electric_bolt,
      color: const Color(0xFFf59e0b),
      gradient: const [Color(0xFFf59e0b), Color(0xFFd97706)],
    ),
    EmergencyNumber(
      name: 'المياه',
      number: '125',
      icon: Icons.water_drop,
      color: const Color(0xFF06b6d4),
      gradient: const [Color(0xFF06b6d4), Color(0xFF0891b2)],
    ),
  ];

  final List<EmergencyNumber> otherNumbers = [
    EmergencyNumber(
      name: 'الاستعلامات',
      number: '140',
      icon: Icons.info,
      color: const Color(0xFF10b981),
      gradient: const [Color(0xFF10b981), Color(0xFF059669)],
    ),
    EmergencyNumber(
      name: 'الخط الساخن للشكاوى',
      number: '15115',
      icon: Icons.report_problem,
      color: const Color(0xFFef4444),
      gradient: const [Color(0xFFef4444), Color(0xFFdc2626)],
    ),
    EmergencyNumber(
      name: 'مكافحة المخدرات',
      number: '126',
      icon: Icons.medication,
      color: const Color(0xFF8b5cf6),
      gradient: const [Color(0xFF8b5cf6), Color(0xFF7c3aed)],
    ),
    EmergencyNumber(
      name: 'النجدة النهرية',
      number: '124',
      icon: Icons.directions_boat,
      color: const Color(0xFF06b6d4),
      gradient: const [Color(0xFF06b6d4), Color(0xFF0891b2)],
    ),
    EmergencyNumber(
      name: 'حماية المستهلك',
      number: '19588',
      icon: Icons.shield,
      color: const Color(0xFF10b981),
      gradient: const [Color(0xFF10b981), Color(0xFF059669)],
    ),
    EmergencyNumber(
      name: 'خط نجدة الطفل',
      number: '16000',
      icon: Icons.child_care,
      color: const Color(0xFFec4899),
      gradient: const [Color(0xFFec4899), Color(0xFFdb2777)],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
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
    _fadeController.dispose();
    super.dispose();
  }

  void _copyNumber(String number) {
    Clipboard.setData(ClipboardData(text: number));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Text('تم نسخ الرقم $number'),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF10b981),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('أرقام الطوارئ'),
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Emergency Banner
              EmergencyBanner(),

              // Emergency Numbers Section
              NumbersGridSection(
                title: 'أرقام الطوارئ الأساسية',
                numbers: emergencyNumbers,
                isDark: isDark,
                onCopy: _copyNumber,
                accentColor: const Color(0xFFef4444),
              ),

              const SizedBox(height: 32),

              // Other Numbers Section
              NumbersListSection(
                title: 'أرقام أخرى مهمة',
                numbers: otherNumbers,
                isDark: isDark,
                onCopy: _copyNumber,
                accentColor: const Color(0xFF10b981),
                startIndex: emergencyNumbers.length,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}