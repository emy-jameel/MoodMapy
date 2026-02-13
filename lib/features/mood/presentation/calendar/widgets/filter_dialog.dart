import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mood_map/core/constants/mood_utils.dart';
import 'package:mood_map/features/mood/domain/enums/mood_type.dart';
import 'package:mood_map/core/constants/colors.dart';
import 'mood_emoji_circle.dart';

// class MoodCircleFilterDialog extends StatefulWidget {
//   final MoodType? selected;
//   const MoodCircleFilterDialog({super.key, this.selected});

//   @override
//   State<MoodCircleFilterDialog> createState() => _MoodCircleFilterDialogState();
// }

// class _MoodCircleFilterDialogState extends State<MoodCircleFilterDialog> with SingleTickerProviderStateMixin {
//   MoodType? _selected;
//   late AnimationController _controller;

//   @override
//   void initState() {
//     _selected = widget.selected;
//     _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..forward();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final moods = [
//       {'type': MoodType.happy, 'icon': MoodEmoji.happy, 'color': MoodColors.happyNormal},
//       {'type': MoodType.good, 'icon': MoodEmoji.good, 'color': MoodColors.goodNormal},
//       {'type': MoodType.okay, 'icon': MoodEmoji.okay, 'color': MoodColors.okNormal},
//       {'type': MoodType.bad, 'icon': MoodEmoji.bad, 'color': MoodColors.badNormal},
//       {'type': MoodType.awfull, 'icon': MoodEmoji.awfull, 'color': MoodColors.awfulNormal},
//     ];
//     const double radius = 100;
//     final center = Offset(radius, radius);

//     return Center(
//       child: ScaleTransition(
//         scale: CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
//         child: Material(
//           color: Colors.transparent,
//           child: Stack(
//             clipBehavior: Clip.none,
//             alignment: Alignment.center,
//             children: [
//               // الدائرة الأساسية الشفافة
//               Container(
//                 width: radius * 2.2,
//                 height: radius * 2.2,
//                 decoration: BoxDecoration(
//                   color:
//                       Theme.of(context).brightness == Brightness.dark
//                           ? Colors.grey[900]!.withOpacity(0.99)
//                           : Colors.white.withOpacity(0.98),
//                   borderRadius: BorderRadius.circular(radius + 60),
//                   boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 25, offset: const Offset(0, 16), spreadRadius: 1)],
//                 ),
//               ),
//               // الإيموجي حول الدائرة مع تحريك/شفافية عند دخول الديالوق
//               ...List.generate(moods.length, (i) {
//                 final mood = moods[i];
//                 final angle = (2 * math.pi / moods.length) * i - math.pi / 2;
//                 final dx = center.dx + radius * math.cos(angle) - 20;
//                 final dy = center.dy + radius * math.sin(angle) - 20;
//                 final isSelected = _selected == mood['type'];
//                 return AnimatedBuilder(
//                   animation: _controller,
//                   builder: (context, child) {
//                     final appear = Curves.easeOut.transform(_controller.value);
//                     return Positioned(
//                       left: center.dx + (dx - center.dx) * appear,
//                       top: center.dy + (dy - center.dy) * appear,
//                       child: GestureDetector(
//                         onTap: () {
//                           setState(() => _selected = mood['type'] as MoodType);
//                           Future.delayed(const Duration(milliseconds: 800), () {
//                             Navigator.of(context).pop(_selected);
//                           });
//                         },
//                         child: AnimatedScale(
//                           scale: isSelected ? 1.18 : 1.0,
//                           duration: const Duration(milliseconds: 800),
//                           curve: Curves.easeOut,
//                           child: MoodEmojiCircle(
//                             icon: mood['icon'] as String,
//                             color: mood['color'] as Color,
//                             isSelected: isSelected,
//                             shadow: true,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }),
//               // All في الوسط
//               AnimatedBuilder(
//                 animation: _controller,
//                 builder: (context, child) {
//                   final appear = Curves.easeOut.transform(_controller.value);
//                   return Positioned(
//                     left: center.dx - 30,
//                     top: center.dy - 30 - (1 - appear) * 42,
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() => _selected = null);
//                         Future.delayed(const Duration(milliseconds: 800), () {
//                           Navigator.of(context).pop(null);
//                         });
//                       },
//                       child: AnimatedScale(
//                         scale: _selected == null ? 1.19 : 1,
//                         duration: const Duration(milliseconds: 800),
//                         child: MoodEmojiCircle(
//                           icon: null,
//                           color: MoodColors.goodDarkHover,
//                           isSelected: _selected == null,
//                           isCenter: true,
//                           shadow: true,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class MoodCircleFilterDialog extends StatefulWidget {
  final MoodType? selected;
  const MoodCircleFilterDialog({super.key, this.selected});

  @override
  State<MoodCircleFilterDialog> createState() => _MoodCircleFilterDialogState();
}

class _MoodCircleFilterDialogState extends State<MoodCircleFilterDialog>
    with SingleTickerProviderStateMixin {
  MoodType? _selected;
  late AnimationController _controller;

  @override
  void initState() {
    _selected = widget.selected;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final moods = getMoodList(context);

    const double radius = 100;
    final center = Offset(radius, radius);

    return Center(
      child: ScaleTransition(
        scale: CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
        child: Material(
          color: Colors.transparent,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // دائرة الخلفية
              Container(
                width: radius * 2.2,
                height: radius * 2.2,
                decoration: BoxDecoration(
                  color: Theme.of(context).dialogBackgroundColor,
                  borderRadius: BorderRadius.circular(radius + 60),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 25,
                      offset: const Offset(0, 16),
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
              // المزاجات حول الدائرة
              ...List.generate(moods.length, (i) {
                final mood = moods[i];
                final angle = (2 * math.pi / moods.length) * i - math.pi / 2;
                final dx = center.dx + radius * math.cos(angle) - 20;
                final dy = center.dy + radius * math.sin(angle) - 20;
                final isSelected = _selected == mood['type'];
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final appear = Curves.easeOut.transform(_controller.value);
                    return Positioned(
                      left: center.dx + (dx - center.dx) * appear,
                      top: center.dy + (dy - center.dy) * appear,
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _selected = mood['type'] as MoodType);
                          Future.delayed(const Duration(milliseconds: 800), () {
                            Navigator.of(context).pop(_selected);
                          });
                        },
                        child: AnimatedScale(
                          scale: isSelected ? 1.18 : 1.0,
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeOut,
                          child: MoodEmojiCircle(
                            icon: mood['icon'] as String?,
                            color: mood['color'] as Color,
                            isSelected: isSelected,
                            shadow: true,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
              // زر All في المنتصف
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final appear = Curves.easeOut.transform(_controller.value);
                  return Positioned(
                    left: center.dx - 30,
                    top: center.dy - 30 - (1 - appear) * 42,
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _selected = null);
                        Future.delayed(const Duration(milliseconds: 800), () {
                          Navigator.of(context).pop(null);
                        });
                      },
                      child: AnimatedScale(
                        scale: _selected == null ? 1.19 : 1,
                        duration: const Duration(milliseconds: 800),
                        child: MoodEmojiCircle(
                          icon: null,
                          color: MoodColors.goodDarkHover,
                          isSelected: _selected == null,
                          isCenter: true,
                          shadow: true,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
