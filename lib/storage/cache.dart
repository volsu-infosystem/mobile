import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:volsu_app_v1/models/lesson_model.dart';

class Cache {
  Cache._();

  static final _instance = Cache._();

  static Cache get instance => _instance; // Singleton

  Future<String> get pathLessons async => p.join((await getTemporaryDirectory()).path, "lessons");

  Future<void> clearAll() async {
    await clearLessons();
  }

  /*
   * Lessons
   */
  Future<bool> isLessonsCached() async {
    final file = File(await pathLessons);
    return await file.exists() && await file.length() > 0;
  }

  Future<List<LessonModel>> getLessons() async {
    final json = await File(await pathLessons).readAsString();
    final map = jsonDecode(json);
    return List<LessonModel>.from(map.map((lessonJson) => LessonModel.fromJson(lessonJson)));
  }

  /// Оптимистичное выполнение
  Future<void> saveLessons(List<LessonModel> lessons) async {
    final preparedList = <dynamic>[];
    lessons.forEach((element) {
      preparedList.add(element.toJson());
    });
    await File(await pathLessons).writeAsString(jsonEncode(preparedList));
  }

  /// Оптимистичное выполнение
  Future<void> clearLessons() async {
    final file = File(await pathLessons);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
