import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:volsu_app_v1/models/timetable.dart';

class Cache {
  Cache._();

  static final _instance = Cache._();

  static Cache get instance => _instance; // Singleton

  Future<String> get pathLessons async =>
      p.join((await getTemporaryDirectory()).path, "basetimetable");

  Future<void> clearAll() async {
    await clearBaseTimetable();
  }

  /*
   * BaseTimetable
   */
  Future<bool> isBaseTimetableCached() async {
    final file = File(await pathLessons);
    return await file.exists() && await file.length() > 0;
  }

  Future<BaseTimetable> getBaseTimetable() async {
    final json = await File(await pathLessons).readAsString();
    return BaseTimetable.fromJson(jsonDecode(json));
  }

  /// Оптимистичное выполнение
  Future<void> saveBaseTimetable(BaseTimetable baseTimetable) async {
    await File(await pathLessons).writeAsString(jsonEncode(baseTimetable));
  }

  /// Оптимистичное выполнение
  Future<void> clearBaseTimetable() async {
    try {
      final file = File(await pathLessons);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (FileSystemException) {}
  }
}
