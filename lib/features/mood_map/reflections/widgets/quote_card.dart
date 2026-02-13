import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:mood_map/core/theme/text_styles.dart';

import 'package:mood_map/core/constants/icons.dart';
import 'package:flutter/services.dart'; // للنسخ
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_map/features/favorites/cubit/favorites_cubit.dart';
import 'package:mood_map/l10n/app_localizations.dart';
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
    final favoritesCubit = context.read<FavoritesCubit>();
    final isFavorite = favoritesCubit.isFavorite(quote);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color:
                  isDark
                      ? Colors.white.withAlpha(15)
                      : Colors.white.withAlpha(200),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isDark ? Colors.white12 : Colors.white54,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: isDark ? Colors.black26 : Colors.black12,
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder:
                          (child, anim) =>
                              ScaleTransition(scale: anim, child: child),
                      child: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border_rounded,
                        key: ValueKey(isFavorite),
                        color:
                            isFavorite
                                ? const Color(0xFFFF5252)
                                : (isDark ? Colors.white70 : Colors.black45),
                        size: 30,
                      ),
                    ),
                    onPressed: () {
                      if (isFavorite) {
                        favoritesCubit.removeFavorite(quote);
                      } else {
                        favoritesCubit.addFavorite(quote);
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
                  style: MoodTextStyles.heading2.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    height: 1.4,
                    color:
                        isDark ? Colors.white.withAlpha(240) : Colors.black87,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Copy Button
                    _ActionButton(
                      icon: MoodIcons.copy,
                      onTap: () => _copyQuote(context),
                      isDark: isDark,
                      tooltip: 'Copy',
                    ),
                    const SizedBox(width: 40),
                    // Share Button
                    _ActionButton(
                      icon: Icons.ios_share_rounded,
                      isIconData: true,
                      onTap: () => _shareQuote(context),
                      isDark: isDark,
                      tooltip: 'Share',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final dynamic icon;
  final bool isIconData;
  final VoidCallback onTap;
  final bool isDark;
  final String tooltip;

  const _ActionButton({
    required this.icon,
    this.isIconData = false,
    required this.onTap,
    required this.isDark,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? Colors.white10 : Colors.grey.withAlpha(20),
          shape: BoxShape.circle,
        ),
        child:
            isIconData
                ? Icon(
                  icon as IconData,
                  color: isDark ? Colors.white70 : Colors.black54,
                  size: 24,
                )
                : Image.asset(
                  icon as String,
                  color: isDark ? Colors.white70 : Colors.black54,
                  width: 24,
                  height: 24,
                ),
      ),
    );
  }
}
