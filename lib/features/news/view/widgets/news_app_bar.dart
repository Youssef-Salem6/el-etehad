import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewsAppBar extends StatelessWidget {
  final ScrollController scrollController;
  final double imageOpacity;
  final String mainImage;
  final ThemeData theme;
  final VoidCallback onBack;

  const NewsAppBar({
    super.key,
    required this.scrollController,
    required this.imageOpacity,
    required this.mainImage,
    required this.theme,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300.0,
      floating: false,
      pinned: true,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: theme.primaryColor,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: onBack,
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {},
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.white),
            onPressed: () {},
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
              opacity: imageOpacity,
              child: Image.network(
                mainImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: theme.primaryColor,
                    child: const Icon(
                      Icons.newspaper,
                      size: 80,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 150,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}