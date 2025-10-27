import 'package:el_etehad/core/paths/images_paths.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CardFooter extends StatelessWidget {
  final bool isInsideCard;
  final String location, day;
  final bool isUsedAi;

  const CardFooter({
    super.key,
    this.isInsideCard = false,
    required this.location,
    required this.day,
    required this.isUsedAi,
  });

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
          day,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Icon(Icons.location_on_outlined, color: iconColor, size: 18),
        const Gap(5),
        Text(
          location,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Visibility(
          visible: isUsedAi,
          child: Image(
            image: AssetImage(ImagesPaths.aiIcon),
            width: 18,
            color: iconColor,
            colorBlendMode: BlendMode.srcIn,
          ),
        ),
        const Gap(5),
        Visibility(
          visible: isUsedAi,
          child: Text(
            "AI",
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
