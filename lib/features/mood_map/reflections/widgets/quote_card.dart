import 'package:flutter/material.dart';
import 'package:mood_map/core/theme/text_styles.dart';
import 'package:mood_map/core/constants/colors.dart';
import 'package:mood_map/core/constants/icons.dart';
import 'package:flutter/services.dart'; // للنسخ
import 'package:mood_map/features/provider/Favorite_provider.dart';
import 'package:mood_map/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart'; // للمشاركة

// class QuoteCard extends StatelessWidget {
//   const QuoteCard({super.key, required this.quote});

//   final String quote;

//   void _copyQuote(BuildContext context) {
//     Clipboard.setData(ClipboardData(text: quote));
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم نسخ الاقتباس!')));
//   }

//   void _shareQuote(BuildContext context) {
//     Share.share(quote, subject: 'مشاركة اقتباس');
//   }

//   @override
//   Widget build(BuildContext context) {
//     final favProvider = Provider.of<FavoritesProvider>(context);
//     final isFavorite = favProvider.isFavorite(quote);
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 50),
//       child: Container(
//         padding: const EdgeInsets.all(24),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(24),
//           boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4))],
//         ),
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.topLeft,
//               child: IconButton(
//                 icon: Icon(
//                   isFavorite ? Icons.favorite : Icons.favorite_border_sharp,
//                   color: isFavorite ? Colors.red : MoodColors.tPrimaryDark,
//                   size: 32,
//                 ),
//                 onPressed: () {
//                   if (isFavorite) {
//                     favProvider.removeFavorite(quote);
//                   } else {
//                     favProvider.addFavorite(quote);
//                   }
//                 },
//                 tooltip: isFavorite ? AppLocalizations.of(context)!.removeFromFavorites : AppLocalizations.of(context)!.toggleFavorite,
//               ),
//             ),
//             const SizedBox(height: 24),
//             Text('"$quote"', textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
//             const SizedBox(height: 24),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // زر النسخ
//                 InkWell(
//                   onTap: () => _copyQuote(context),
//                   borderRadius: BorderRadius.circular(40),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Image.asset(MoodIcons.copy, color: MoodColors.primaryNormalActive, width: 25, height: 25),
//                   ),
//                 ),
//                 const SizedBox(width: 50),
//                 // زر المشاركة
//                 InkWell(
//                   onTap: () => _shareQuote(context),
//                   borderRadius: BorderRadius.circular(40),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Image.asset(
//                       MoodIcons.download, // يمكنك تغيير الأيقونة إلى share إذا أحببت
//                       color: MoodColors.primaryNormalActive,
//                       width: 25,
//                       height: 25,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class QuoteCard extends StatelessWidget {
  final String quote;
  final bool isDark;

  const QuoteCard({super.key, required this.quote, required this.isDark});

  void _copyQuote(BuildContext context) {
    Clipboard.setData(ClipboardData(text: quote));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تم نسخ الاقتباس!',
          style: TextStyle(color: isDark ? Colors.white : Colors.black87),
        ),
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _shareQuote(BuildContext context) {
    Share.share(quote, subject: 'مشاركة اقتباس');
  }

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavoritesProvider>(context);
    final isFavorite = favProvider.isFavorite(quote);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF23272F) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black26 : Colors.black12,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border_sharp,
                  color:
                      isFavorite
                          ? Colors.red
                          : (isDark
                              ? MoodColors.primaryDark
                              : MoodColors.tPrimaryDark),
                  size: 32,
                ),
                onPressed: () {
                  if (isFavorite) {
                    favProvider.removeFavorite(quote);
                  } else {
                    favProvider.addFavorite(quote);
                  }
                },
                tooltip:
                    isFavorite
                        ? AppLocalizations.of(context)!.removeFromFavorites
                        : AppLocalizations.of(context)!.toggleFavorite,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '"$quote"',
              textAlign: TextAlign.center,
              style: MoodTextStyles.normal3.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // زر النسخ
                InkWell(
                  onTap: () => _copyQuote(context),
                  borderRadius: BorderRadius.circular(40),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      MoodIcons.copy,
                      color:
                          isDark
                              ? MoodColors.primaryDarkActive
                              : MoodColors.primaryNormalActive,
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
                const SizedBox(width: 50),
                // زر المشاركة
                InkWell(
                  onTap: () => _shareQuote(context),
                  borderRadius: BorderRadius.circular(40),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      MoodIcons.download, // أو share
                      color:
                          isDark
                              ? MoodColors.primaryDarkActive
                              : MoodColors.primaryNormalActive,
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
