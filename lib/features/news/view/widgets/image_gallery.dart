import 'package:el_etehad/features/news/view/widgets/animated_widgets.dart';
import 'package:flutter/material.dart';

class ImageGallery extends StatelessWidget {
  final ThemeData theme;
  final List<Map<String, String>> imageGallery;

  const ImageGallery({
    super.key,
    required this.theme,
    required this.imageGallery,
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
              Icon(Icons.photo_library, color: theme.primaryColor, size: 24),
              const SizedBox(width: 8),
              Text(
                'معرض الصور',
                style: theme.textTheme.headlineMedium,
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: imageGallery.length,
            itemBuilder: (context, index) {
              return AnimatedImage(
                delay: index * 100,
                child: Container(
                  width: 250,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          imageGallery[index]['url']!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: theme.primaryColor.withOpacity(0.2),
                              child: Icon(
                                Icons.image,
                                size: 50,
                                color: theme.primaryColor,
                              ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                ],
                              ),
                            ),
                            child: Text(
                              imageGallery[index]['caption']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ],
                    ),
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