const _id = 'id';
const _durationInMinutes = 'durationInMinutes';
const _isCompleted = 'isCompleted';
const _dateTime = 'dateTime';
const _title = 'title';

class Task {
  final String id;
  final int durationInMinutes;
  final bool isCompleted;
  final String dateTime;
  final String title;
  Task(
      {this.id,
      this.durationInMinutes,
      this.isCompleted,
      this.dateTime,
      this.title});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> m = new Map();
    m[_id] = this.id;
    m[_durationInMinutes] = this.durationInMinutes;
    m[_isCompleted] = this.isCompleted;
    m[_dateTime] = this.dateTime;
    m[_title] = this.title;
    return m;
  }

  Map<String, dynamic> toCompletedMap() {
    Map<String, dynamic> m = new Map();
    m[_id] = this.id;
    m[_durationInMinutes] = this.durationInMinutes;
    m[_isCompleted] = true;
    m[_dateTime] = this.dateTime;
    m[_title] = this.title;
    return m;
  }

  factory Task.fromJson(Map map) {
    return Task(
        id: map[_id],
        durationInMinutes: map[_durationInMinutes],
        isCompleted: map[_isCompleted],
        dateTime: map[_dateTime],
        title: map[_title]);
  }
}
