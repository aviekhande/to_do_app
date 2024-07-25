class Tasks {
  String? task;
  String? date;
  String? time;

  Tasks({this.task, this.date, this.time});

  Tasks.fromJson(Map<String, dynamic> json) {
    task = json['task'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task'] = task;
    data['date'] = date;
    data['time'] = time;
    return data;
  }
}
