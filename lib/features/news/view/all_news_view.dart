import 'package:el_etehad/features/home/models/news_model.dart';
import 'package:el_etehad/features/home/view/widgets/animated_artical_card.dart';
import 'package:flutter/material.dart';

class AllNewsView extends StatefulWidget {
  final List data;
  const AllNewsView({super.key, required this.data});

  @override
  State<AllNewsView> createState() => _AllNewsViewState();
}

class _AllNewsViewState extends State<AllNewsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('جميع الأخبار')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: widget.data.length,
          itemBuilder: (context, index) {
            return AnimatedArticleCard(
              index: index,
              readTime: '${index + 3} دقائق',
              newsModel: NewsModel.fromJson(json: widget.data[index]),
            );
          },
        ),
      ),
    );
  }
}
