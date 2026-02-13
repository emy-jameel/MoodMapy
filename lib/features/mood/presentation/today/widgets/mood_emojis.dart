import 'package:flutter/material.dart';
import 'package:mood_map/core/constants/colors.dart';
import 'package:mood_map/features/mood/domain/enums/mood_type.dart';

class MoodEmojis extends StatelessWidget {
  final List<MoodType> moodList;
  final MoodType? selected;
  final Function(MoodType) onSelect;

  const MoodEmojis({
    super.key,
    required this.moodList,
    required this.selected,
    required this.onSelect,
  });

  Color _moodColor(MoodType mood) {
    switch (mood) {
      case MoodType.happy:
        return MoodColors.happyNormal;
      case MoodType.good:
        return MoodColors.goodNormal;
      case MoodType.okay:
        return MoodColors.okNormal;
      case MoodType.bad:
        return MoodColors.badNormal;
      case MoodType.awfull:
        return MoodColors.awfulNormal;
    }
  }

  String _moodLabel(BuildContext context, MoodType mood) {
    // You might want to move these to l10n later if they aren't there
    switch (mood) {
      case MoodType.happy:
        return "Happy";
      case MoodType.good:
        return "Good";
      case MoodType.okay:
        return "Okay";
      case MoodType.bad:
        return "Bad";
      case MoodType.awfull:
        return "Awful";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            moodList.map((mood) {
              final isSelected = mood == selected;

              return GestureDetector(
                onTap: () {
                  onSelect(mood);
                  // Simple haptic feedback if available (requires service or just ease)
                  // For now, reliance on logic is enough, or import services
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutBack,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: EdgeInsets.all(isSelected ? 10 : 8),
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? _moodColor(mood).withAlpha(50)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? _moodColor(mood) : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      AnimatedScale(
                        scale: isSelected ? 1.2 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.elasticOut,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow:
                                isSelected
                                    ? [
                                      BoxShadow(
                                        color: _moodColor(mood).withAlpha(100),
                                        blurRadius: 15,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]
                                    : [],
                          ),
                          child: Image.asset(
                            mood.assetPath,
                            height: 50,
                            width: 50,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      // Animated Label
                      AnimatedSize(
                        duration: const Duration(milliseconds: 200),
                        child: SizedBox(
                          height: isSelected ? 24 : 0,
                          child:
                              isSelected
                                  ? Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      // Ideally translate this
                                      mood.name.toUpperCase(),
                                      style: TextStyle(
                                        color: _moodColor(mood),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                                  : const SizedBox(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
