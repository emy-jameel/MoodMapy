import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mood_map/core/constants/colors.dart';

import 'dart:ui'; // For simple BackdropFilter

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    this.backgroundColor,
    required this.currentIndex,
    required this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    required this.items,
  });

  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final int currentIndex;
  final List<BottomNavigationBarItem> items;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: (backgroundColor ??
                    (isDark ? const Color(0xFF222C36) : Colors.white))
                .withAlpha(204), // 0.8 opacity
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black26 : Colors.black12,
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
            border: Border(
              top: BorderSide(
                color: isDark ? Colors.white10 : Colors.white54,
                width: 1,
              ),
            ),
          ),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(items.length, (i) {
                  final isSelected = currentIndex == i;
                  return Expanded(
                    child: InkWell(
                      onTap: () {
                        onTap(i);
                        HapticFeedback.lightImpact();
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? (selectedItemColor ??
                                          (isDark
                                              ? MoodColors.primaryLight
                                              : MoodColors.primaryNormal))
                                      .withAlpha(
                                        isDark ? 51 : 64,
                                      ) // 0.2/0.25 opacity
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedScale(
                              scale: isSelected ? 1.1 : 1.0,
                              duration: const Duration(milliseconds: 300),
                              child: IconTheme(
                                data: IconThemeData(
                                  color:
                                      isSelected
                                          ? (selectedItemColor ??
                                              (isDark
                                                  ? MoodColors.primaryLight
                                                  : MoodColors.primaryDark))
                                          : (unselectedItemColor ??
                                              (isDark
                                                  ? Colors.white54
                                                  : MoodColors
                                                      .tSecondaryNormal)),
                                  size: 26,
                                ),
                                child: items[i].icon,
                              ),
                            ),
                            if (isSelected) ...[
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  items[i].label ?? "",
                                  style: TextStyle(
                                    color:
                                        selectedItemColor ??
                                        (isDark
                                            ? MoodColors.primaryLight
                                            : MoodColors.primaryDark),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    fontFamily:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.fontFamily,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
