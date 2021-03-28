import 'package:localstorage/localstorage.dart';
import 'package:pomodoro_todo/models/models.dart';

class CoreStorage {
  static String _maxCount = 'maxCount';
  static LocalStorage storage = new LocalStorage('POMODORO');

  /// API to create Task in Local Storage
  static void createTask(String title, int durationInMinutes) async {
    String x = getNext().toString();
    Task task = Task(
        id: x,
        durationInMinutes: durationInMinutes,
        isCompleted: false,
        dateTime: DateTime.now().toString(),
        title: title);
    await storage.setItem(x.toString(), task.toMap());
  }

  /// API to complete Task
  static void completeTask(Task task) {
    storage.setItem(task.id, task.toCompletedMap());
  }

  ///API to get all Tasks
  static Future<List<Task>> getTasks() async {
    await storage.ready;
    int x = storage.getItem(_maxCount);
    List<Task> list = new List.empty(growable: true);
    if (x == null) return list;
    for (int i = 0; i < x; i++) {
      list.add(Task.fromJson(storage.getItem(i.toString())));
    }
    return list;
  }

  /// API to clear all data
  static void clearAll() {
    storage.clear();
  }

  /// API to delete task with Id
  static void deleteTask(String id) async {
    await storage.ready;
    Task replaceTask = getLastTask();
    if (id == replaceTask.id) {
      storage.setItem(_maxCount, storage.getItem(_maxCount) - 1);
      return;
    }
    Task task = Task(
        id: id,
        dateTime: replaceTask.dateTime,
        durationInMinutes: replaceTask.durationInMinutes,
        title: replaceTask.title,
        isCompleted: replaceTask.isCompleted);

    await storage.setItem(id, task.toMap());
    await storage.setItem(_maxCount, storage.getItem(_maxCount) - 1);
  }

  /// API to get Last Task
  static Task getLastTask() {
    int x = storage.getItem(_maxCount) - 1;
    return Task.fromJson(storage.getItem(x.toString()));
  }

  ///API to getNext int to store data
  static int getNext() {
    int x = storage.getItem(_maxCount);
    if (x == null) {
      storage.setItem(_maxCount, 1);
      return 0;
    } else {
      storage.setItem(_maxCount, x + 1);
      return x;
    }
  }
}
