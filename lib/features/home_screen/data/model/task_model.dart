class Tasks {
  String? task;
  String? date;
  String? time;
  String? id;
  bool? done;

  Tasks({this.task, this.date, this.time ,required this.id, this.done});

  Tasks.fromJson(Map<String, dynamic> json) {
    task = json['task'];
    date = json['date'];
    time = json['time'];
    id = json['id'];
    done = json['done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task'] = task;
    data['date'] = date;
    data['time'] = time;
    data['id'] = id;
    data['done'] =done;
    return data;
  }
}
