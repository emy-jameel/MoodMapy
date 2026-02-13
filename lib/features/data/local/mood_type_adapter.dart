import 'package:hive/hive.dart';
import 'package:mood_map/features/mood/domain/enums/mood_type.dart';

// إذا enum اسمه MoodType
class MoodTypeAdapter extends TypeAdapter<MoodType> {
  @override
  final int typeId = 0;

  @override
  MoodType read(BinaryReader reader) {
    return MoodType.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, MoodType obj) {
    writer.writeByte(obj.index);
  }
}
