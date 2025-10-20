import 'package:el_etehad/core/paths/images_paths.dart';
import 'package:el_etehad/fetures/home/view/widgets/card_footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AnimatedBreakingNewsCard extends StatefulWidget {
  final int index;
  final String title;
  final String time;
  final VoidCallback? onTap;

  const AnimatedBreakingNewsCard({
    super.key,
    required this.index,
    required this.title,
    required this.time,
    this.onTap,
  });

  @override
  State<AnimatedBreakingNewsCard> createState() =>
      _AnimatedBreakingNewsCardState();
}

class _AnimatedBreakingNewsCardState extends State<AnimatedBreakingNewsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500 + (widget.index * 100)),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: 260,
          margin: const EdgeInsets.only(left: 16, bottom: 2),
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: NetworkImage(
                "https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=800&q=180",
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(blurRadius: 6, offset: const Offset(0, 5))],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: widget.onTap,
              child: Column(
                children: [
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [0.3, 0.75, 1],
                        colors: [
                          Color(0xFF000014),
                          Color(0xFF271C2E),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image(
                                    image: AssetImage(ImagesPaths.logoIcon),
                                    width: 20,
                                  ),
                                  Gap(5),
                                  Text(
                                    "سياسه",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 220,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    "ذكاء اصطناعي جديد قادر على تشخيص الأمراض النادرة بدقة تصل إلى 95%",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 220,
                                child: CardFooter(isInsideCard: true),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
