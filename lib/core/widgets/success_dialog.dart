import 'package:flutter/material.dart';
import 'package:mood_map/core/theme/text_styles.dart';
import 'package:mood_map/core/constants/icons.dart';
import 'package:mood_map/l10n/app_localizations.dart';

// class SuccessDialogWidget extends StatelessWidget {
//   const SuccessDialogWidget({super.key});
//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(const Duration(seconds: 1), () => Navigator.pop(context));
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
//       backgroundColor: Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.all(34.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Image.asset(MoodIcons.success, width: 70), // أو أيقونة checkmark دائرية مثل الصورة الأخيرة
//             const SizedBox(height: 16),
//             Text(AppLocalizations.of(context)!.successful, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
//           ],
//         ),
//       ),
//     );
//   }
// }

class SuccessDialogWidget extends StatelessWidget {
  const SuccessDialogWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = Localizations.localeOf(context).languageCode;

    Future.delayed(const Duration(seconds: 1), () => Navigator.pop(context));
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      backgroundColor: isDark ? const Color(0xFF23243C) : Colors.white,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(34.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(MoodIcons.success, width: 70),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.successful,
              style: MoodTextStyles.bold3.copyWith(
                fontSize: 22,
                color: isDark ? Colors.white : Colors.black,
                fontFamily: lang == 'ar' ? 'Zain' : 'Poppins',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
