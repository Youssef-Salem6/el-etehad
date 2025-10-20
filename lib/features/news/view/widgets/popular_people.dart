import 'package:el_etehad/features/news/view/widgets/animated_widgets.dart';
import 'package:flutter/material.dart';


class PopularPeople extends StatelessWidget {
  final ThemeData theme;
  final List<Map<String, String>> popularPeople;

  const PopularPeople({
    super.key,
    required this.theme,
    required this.popularPeople,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Icon(Icons.people, color: theme.primaryColor, size: 24),
              const SizedBox(width: 8),
              Text(
                'الشخصيات البارزة في الخبر',
                style: theme.textTheme.headlineMedium,
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: popularPeople.length,
            itemBuilder: (context, index) {
              final person = popularPeople[index];
              return AnimatedPersonCard(
                delay: index * 120,
                child: Container(
                  width: 160,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.primaryColor,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: theme.primaryColor.withOpacity(0.3),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.network(
                            person['image']!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: theme.primaryColor.withOpacity(0.2),
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: theme.primaryColor,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          person['name']!,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          person['role']!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}