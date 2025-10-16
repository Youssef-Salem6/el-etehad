import 'package:el_etehad/core/paths/images_paths.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CardFooter extends StatelessWidget {
  final bool isInsideCard;

  const CardFooter({super.key, this.isInsideCard = false});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // If inside card/image, always use white color
    final textColor =
        isInsideCard
            ? Colors.white70
            : (isDark ? Colors.white70 : Colors.black54);
    final iconColor =
        isInsideCard
            ? Colors.white70
            : (isDark ? Colors.white70 : Colors.black54);

    return Row(
      children: [
        Icon(CupertinoIcons.time, color: iconColor, size: 16),
        const Gap(5),
        Text(
          "السبت",
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Icon(Icons.location_on_outlined, color: iconColor, size: 16),
        const Gap(5),
        Text(
          "كفر الشيخ",
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Image(
          image: AssetImage(ImagesPaths.aiIcon),
          width: 20,
          color: iconColor,
          colorBlendMode: BlendMode.srcIn,
        ),
        const Gap(5),
        Text(
          "AI",
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
