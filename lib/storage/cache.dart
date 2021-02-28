import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:volsu_app_v1/storage/lesson_model.dart';
import 'package:path/path.dart' as p;

class Cache {
  Cache._();

  static final _instance = Cache._();

  static Cache get instance => _instance; // Singleton

  Future<String> get pathLessons async => p.join((await getTemporaryDirectory()).path, "lessons");

  Future<bool> isLessonsCached() async {
    return false;
  }

  Future<List<LessonModel>> getLessons() async {
    // final json = await File(await pathLessons).readAsString();
    // print("getLessons(): " + json);
    // final map = jsonDecode(json);
    // return List<LessonModel>.from(map.map((lessonJson) => LessonModel.fromJson(lessonJson)));
  }

  Future<void> saveLessons(List<LessonModel> lessons) async {
    // final json = jsonEncode(lessons);
    // print("saveLessons(): " + json);
    // File(await pathLessons).writeAsString(json.encode(lessons));
  }
}
