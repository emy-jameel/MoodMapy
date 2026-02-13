enum MoodType { happy, good, okay, bad, awfull }

enum MoodSaveResult { success, noMood, emptyNote, error }

extension MoodTypeExtension on MoodType {
  String get assetPath => 'assets/emojis/$name.gif';
}
