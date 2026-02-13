import 'package:flutter/material.dart';
import 'package:mood_map/core/theme/text_styles.dart';
import 'package:mood_map/core/constants/colors.dart';
import 'package:mood_map/core/constants/emojis.dart';
import 'package:mood_map/core/constants/icons.dart';
import 'package:mood_map/core/widgets/header_logo.dart';
import 'package:mood_map/features/mood_map/settings/settings_page.dart';
import 'package:mood_map/features/provider/Favorite_provider.dart';
import 'package:mood_map/features/mood_map/favorite/widgets/favorite_card.dart';
import 'package:mood_map/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

// class FavoritesPage extends StatelessWidget {
//   const FavoritesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final favoritesProvider = Provider.of<FavoritesProvider>(context);

//     final isEmpty = favoritesProvider.favorites.isEmpty;

//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         heroTag: 'settings-fab',
//         onPressed: () {
//           Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()));
//         },
//         backgroundColor: Colors.white,
//         elevation: 5,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         child: const Icon(MoodIcons.settings, color: Color(0xFF4E5A65), size: 32),
//       ),
//       backgroundColor: const Color(0xFFF8FBFD),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header (نفس التصميم العام)
//             Row(
//               children: [
//                 const HeaderLogo(showHeart: false),
//                 const Spacer(),
//                 IconButton(icon: const Icon(Icons.arrow_forward_ios), onPressed: () => Navigator.pop(context)),
//               ],
//             ),
//             const SizedBox(height: 18),
//             Text(AppLocalizations.of(context)!.favorites, style: MoodTextStyles.bold3.copyWith(color: Colors.black, fontSize: 28)),
//             const SizedBox(height: 12),
//             Expanded(
//               child:
//                   isEmpty
//                       ? Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset(MoodEmoji.please, height: 77, width: 77, fit: BoxFit.contain),
//                             const SizedBox(height: 16),
//                             Text(
//                               AppLocalizations.of(context)!.noFavorites,
//                               style: TextStyle(fontSize: 19, color: Colors.grey[600], fontWeight: FontWeight.w500),
//                               textAlign: TextAlign.center,
//                             ),
//                           ],
//                         ),
//                       )
//                       : ListView.builder(
//                         padding: const EdgeInsets.all(16),
//                         itemCount: favoritesProvider.favorites.length,
//                         itemBuilder: (context, idx) {
//                           final quote = favoritesProvider.favorites[idx];
//                           return FavoriteQuoteCard(quote: quote, onRemove: () => favoritesProvider.removeFavorite(quote.text));
//                         },
//                       ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final isEmpty = favoritesProvider.favorites.isEmpty;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'settings-fab',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsPage()),
          );
        },
        backgroundColor: isDark ? MoodColors.primaryDark : Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Icon(
          MoodIcons.settings,
          color: isDark ? MoodColors.primaryLight : const Color(0xFF4E5A65),
          size: 32,
        ),
      ),
      backgroundColor:
          isDark ? const Color(0xFF222C36) : const Color(0xFFF8FBFD),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Row(
              children: [
                const HeaderLogo(showHeart: false),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              AppLocalizations.of(context)!.favorites,
              style: MoodTextStyles.bold3.copyWith(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child:
                  isEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              MoodEmoji.please,
                              height: 77,
                              width: 77,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              AppLocalizations.of(context)!.noFavorites,
                              style: TextStyle(
                                fontSize: 19,
                                color:
                                    isDark ? Colors.white54 : Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                      : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: favoritesProvider.favorites.length,
                        itemBuilder: (context, idx) {
                          final quote = favoritesProvider.favorites[idx];
                          return FavoriteQuoteCard(
                            quote: quote,
                            onRemove:
                                () => favoritesProvider.removeFavorite(
                                  quote.text,
                                ),
                            // يمكنك تعديل FavoriteQuoteCard ليدعم isDark إن أردت
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
