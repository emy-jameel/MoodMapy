import 'package:flutter/material.dart';

// class MoodEmojiCircle extends StatelessWidget {
//   final String? icon;
//   final Color color;
//   final bool isSelected;
//   final bool isCenter;
//   final bool shadow;
//   const MoodEmojiCircle({super.key, this.icon, required this.color, this.isSelected = false, this.isCenter = false, this.shadow = false});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: isCenter ? 84 : 64,
//       height: isCenter ? 84 : 64,
//       decoration: BoxDecoration(
//         color: isSelected ? color : Colors.grey[100],
//         border: Border.all(color: isSelected ? color.withOpacity(0.75) : Colors.grey[300]!, width: isSelected ? 3.4 : 1.1),
//         boxShadow:
//             shadow && isSelected
//                 ? [BoxShadow(color: color.withOpacity(0.19), blurRadius: 24, offset: const Offset(0, 6), spreadRadius: 2)]
//                 : [],
//         shape: BoxShape.circle,
//       ),
//       child:
//           icon != null
//               ? Padding(
//                 padding: EdgeInsets.all(isCenter ? 14 : 8),
//                 child: Image.asset(icon!, width: isCenter ? 38 : 28, height: isCenter ? 38 : 28),
//               )
//               : Icon(Icons.blur_on, color: isSelected ? Colors.white : Colors.grey[500], size: isCenter ? 38 : 32),
//     );
//   }
// }

class MoodEmojiCircle extends StatelessWidget {
  final String? icon;
  final Color color;
  final bool isSelected;
  final bool isCenter;
  final bool shadow;

  const MoodEmojiCircle({
    super.key,
    this.icon,
    required this.color,
    this.isSelected = false,
    this.isCenter = false,
    this.shadow = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // خلفية الدائرة الافتراضية حسب الثيم
    final bgColor =
        isSelected ? color : (isDark ? Colors.grey[850] : Colors.grey[100]);

    // لون إطار الدائرة حسب الحالة
    final borderColor =
        isSelected
            ? color.withAlpha(isDark ? 140 : 191)
            : (isDark ? Colors.grey[700]! : Colors.grey[300]!);

    return Container(
      width: isCenter ? 84 : 64,
      height: isCenter ? 84 : 64,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor, width: isSelected ? 3.4 : 1.1),
        boxShadow:
            shadow && isSelected
                ? [
                  BoxShadow(
                    color: color.withAlpha(isDark ? 56 : 48),
                    blurRadius: 24,
                    offset: const Offset(0, 6),
                    spreadRadius: 2,
                  ),
                ]
                : [],
        shape: BoxShape.circle,
      ),
      child:
          icon != null
              ? Padding(
                padding: EdgeInsets.all(isCenter ? 14 : 8),
                child: Image.asset(
                  icon!,
                  width: isCenter ? 38 : 28,
                  height: isCenter ? 38 : 28,
                  color: null, // اتركه افتراضي ليعمل مع الإيموجي الملون
                ),
              )
              : Icon(
                Icons.blur_on,
                color:
                    isSelected
                        ? Colors.white
                        : (isDark ? Colors.grey[500] : Colors.grey[500]),
                size: isCenter ? 38 : 32,
              ),
    );
  }
}
