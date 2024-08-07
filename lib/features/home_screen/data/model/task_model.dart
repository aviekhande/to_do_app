class Tasks {
  String? task;
  String? date;
  String? time;
  String? id;
  bool? done;
  String? priority;
  String? alarm;
  bool? imp;

  Tasks({this.task, this.date, this.time ,required this.id, this.done ,this.priority,this.alarm,this.imp});

  Tasks.fromJson(Map<String, dynamic> json) {
    task = json['task'];
    date = json['date'];
    time = json['time'];
    id = json['id'];
    done = json['done'];
    priority = json['priority'];
    alarm = json['alarm'];
    imp = json['imp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task'] = task;
    data['date'] = date;
    data['time'] = time;
    data['id'] = id;
    data['done'] =done;
    data['priority'] = priority;
    data['alarm']= alarm;
    data['imp']=imp;
    return data;
  }
}
