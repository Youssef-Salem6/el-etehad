import 'package:el_etehad/core/paths/apis.dart';
import 'package:el_etehad/core/paths/images_paths.dart';
import 'package:el_etehad/features/home/models/news_model.dart';
import 'package:el_etehad/features/home/view/widgets/card_footer.dart';
import 'package:el_etehad/features/news/manager/getNewsDetails/get_news_details_cubit.dart';
import 'package:el_etehad/features/news/view/new_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AnimatedBreakingNewsCard extends StatefulWidget {
  final int index;
  final String time;
  final NewsModel newsModel;

  const AnimatedBreakingNewsCard({
    super.key,
    required this.index,
    required this.time,
    required this.newsModel,
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
            image: DecorationImage(
              image: NetworkImage("$endPoint/${widget.newsModel.image}"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(blurRadius: 6, offset: const Offset(0, 5))],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => BlocProvider(
                          create: (context) => GetNewsDetailsCubit(),
                          child: NewDetails(id: widget.newsModel.id!),
                        ),
                  ),
                );
              },
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
                                    widget.newsModel.category ?? "قسم",
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
                                    widget.newsModel.title ?? "عنوان",
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
                                child: CardFooter(
                                  isInsideCard: true,
                                  location:
                                      widget.newsModel.location ?? "كفر الشيخ",
                                  day: widget.newsModel.publishedAt ?? "السبت",
                                  isUsedAi: widget.newsModel.usedAi ?? false,
                                ),
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
