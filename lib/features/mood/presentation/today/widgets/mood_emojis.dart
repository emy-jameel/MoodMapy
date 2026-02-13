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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          moodList.map((mood) {
            final isSelected = mood == selected;

            Widget emoji = AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isSelected ? 70 : 60,
              height: isSelected ? 70 : 60,
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? _moodColor(mood).withAlpha(46)
                        : Colors.transparent,
                border: Border.all(
                  color: isSelected ? _moodColor(mood) : Colors.transparent,
                  width: isSelected ? 3 : 1.5,
                ),
                borderRadius: BorderRadius.circular(45),
                boxShadow: [
                  BoxShadow(
                    color:
                        isSelected
                            ? _moodColor(mood).withAlpha(51)
                            : Colors.transparent,
                    blurRadius: isSelected ? 15 : 0,
                    spreadRadius: isSelected ? 1 : 0,
                    offset: isSelected ? Offset(0, 8) : Offset(0, 0),
                  ),
                ],
              ),
              clipBehavior: Clip.none,
              child: Image.asset(
                mood.assetPath,
                height: 45,
                width: 45,
                fit: BoxFit.contain,
              ),
            );

            // لو الإيموجي هو المختار فعّل الحركة
            if (isSelected) {
              emoji = AnimatedScale(
                scale: 1.15,
                duration: const Duration(milliseconds: 320),
                curve: Curves.elasticOut,
                child: emoji,
              );
            }

            return GestureDetector(onTap: () => onSelect(mood), child: emoji);
          }).toList(),
    );
  }
}
