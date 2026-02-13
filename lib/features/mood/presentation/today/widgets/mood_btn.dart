import 'package:flutter/material.dart';
import 'package:mood_map/core/theme/text_styles.dart';
import 'package:mood_map/core/constants/colors.dart';

// class MoodButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   final Color backgroundColor;
//   final Color textColor;

//   const MoodButton({
//     super.key,
//     required this.text,
//     required this.onPressed,
//     this.backgroundColor = const Color(0xFFa9def9),
//     this.textColor = Colors.black,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: backgroundColor,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//       ),
//       onPressed: onPressed,
//       child: Text(text, style: MoodTextStyles.normal3.copyWith(fontWeight: FontWeight.w500, color: Colors.black)),
//     );
//   }
// }

class MoodButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const MoodButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor =
        backgroundColor ??
        (isDark ? MoodColors.primaryDark : MoodColors.primaryNormal);
    final fgColor = textColor ?? (isDark ? Colors.white : Colors.black);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        elevation: isDark ? 0 : 2,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: MoodTextStyles.normal3.copyWith(
          fontWeight: FontWeight.w500,
          color: fgColor,
        ),
      ),
    );
  }
}
