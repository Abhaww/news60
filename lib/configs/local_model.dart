import 'package:hive/hive.dart';

part 'local_model.g.dart';

@HiveType(typeId: 0)
class LocalNewsModel extends HiveObject{
  @HiveField(0)
  late List<String> newsId;

  @override
  Future<void> save() {
    // TODO: implement save
    return super.save();
  }
}